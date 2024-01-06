#!/usr/bin/env bash
# shellcheck disable=SC2214,SC2215

if ((BASH_VERSINFO[0] < 4))
then
    cat <<EOM >&2
$0: This script requires Bash 4.0 or higher.
If you are on Mac, the native /bin/bash is from 2006 or older; consider using a
more recent Bash from Homebrew.
EOM
    exit 3
fi

export PS4='+${BASH_SOURCE}:${LINENO}:${FUNCNAME[0]:+${FUNCNAME[0]}():} '

# Edit these to suit
readonly package=hm.binkley.md
readonly artifactId=modern-java-practices
readonly version=0-SNAPSHOT
jvm_flags=()

# No editable parts below here

set -e
set -u
set -o pipefail

readonly progname="${0##*/}"

function print-help() {
    cat <<EOH
Usage: $progname [OPTIONS] [-- ARGUMENTS]
Runs a single-jar JVM project.

Options:
  -C, --alt-class=CLASS
                 execute CLASS as the alternate main class, otherwise assume
                 the jar is executable
  -J, --jvm-option=OPTION
                 adds OPTION to the JVM options
  -d, --debug    print script execution to STDERR
  -h, --help     display this help and exit

Examples:
  $progname              Runs the executable jar with no arguments to main
  $progname -C a-class   Runs the main from "a-class"
  $progname -- an-arg    Runs the executable jar passing "an-arg" to main
EOH
}

function bad-option() {
    local opt="$1"

    cat <<EOM
$progname: invalid option -- '$opt'
Try '$progname --help' for more information.
EOM
}

function runtime-classname() {
    echo "$package.$alt_class"
}

function outdated-to-jar() {
    local compare="$1"
    [[ -n "$(find "$compare" -type f -newer "$jar")" ]]
}

function build-config-outdated-gradle() {
    local settings=settings.gradle
    local build=build.gradle

    for f in gradle.properties "$settings" "$build"; do
        [[ -e "$f" ]] && outdated-to-jar "$f" && return
    done

    false
}

function jar-outdated() {
    [[ ! -e "$jar" ]] || outdated-to-jar src/main
}

function rebuild-if-needed() {
    if jar-outdated || build-config-outdated-gradle; then
        ./gradlew --warning-mode=all --no-configuration-cache jar
    fi
}

alt_class=''
debug=false
while getopts :C:J:j:dh-: opt; do
    [[ $opt == - ]] && opt=${OPTARG%%=*} OPTARG=${OPTARG#*=}
    case $opt in
    C | alt-class) alt_class=$OPTARG ;;
    J | jvm-option) jvm_flags=("${jvm_flags[@]}" "$OPTARG") ;;
    d | debug) debug=true ;;
    h | help)
        print-help
        exit 0
        ;;
    *)
        bad-option "$OPTARG"
        exit 2
        ;;
    esac
done
shift $((OPTIND - 1))

$debug && set -x

if [[ ! -x "./gradlew" ]]; then
    echo "$progname: Not executable: ./gradlew" >&2
    exit 2
fi
readonly jar=build/libs/$artifactId-$version.jar

case "$alt_class" in
'') jvm_flags=("${jvm_flags[@]}" -jar "$jar") ;;
*)
    readonly runtime_classname="$(runtime-classname "$package.$alt_class")"
    jvm_flags=("${jvm_flags[@]}" -cp "$jar" "$runtime_classname")
    ;;
esac

rebuild-if-needed

exec java "${jvm_flags[@]}" "$@"
