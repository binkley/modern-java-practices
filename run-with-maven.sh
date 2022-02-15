#!/usr/bin/env bash
# shellcheck disable=SC2214,SC2215

# Edit these to suit
readonly package=hm.binkley.md
readonly artifactId=modern-java-practices
readonly version=0-SNAPSHOT
jvm_flags=()
# No editable parts below here

export PS4='+${BASH_SOURCE}:${LINENO}:${FUNCNAME[0]:+${FUNCNAME[0]}():} '

set -e
set -u
set -o pipefail

readonly progname="${0##*/}"
readonly jar=target/$artifactId-$version-jar-with-dependencies.jar

if [[ ! -x "./mvnw" ]]; then
    echo "$progname: Not executable: ./mvnw" >&2
    exit 2
fi

function print-help() {
    cat <<EOH
Usage: $progname [OPTIONS] [-- ARGUMENTS]
Runs a single-jar JVM project.

Options:
  -C, --alt-class=CLASS
                 execute CLASS as the alternate main class, otherwise assume
                 the jar is executable
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

function mangle-kotlin-classname() {
    local IFS=.

    local -a parts
    read -r -a parts <<<"$1"
    local last="${parts[-1]}"

    case "$last" in
    *Kt) ;;
    *) last="${last}Kt" ;;
    esac
    last="${last//-/_}"
    last=""${last^}

    parts[-1]="$last"

    echo "${parts[*]}"
}

function runtime-classname() {
    echo "$package.$alt_class"
}

function rebuild-if-needed() {
    # TODO: Rebuild if build script is newer than jar
    [[ -e "$jar" && -z "$(find src/main -type f -newer "$jar")" ]] && return

    ./mvnw -Dmaven.test.skip=true package
}

alt_class=''
debug=false
while getopts :C:a:b:dhl:-: opt; do
    [[ $opt == - ]] && opt=${OPTARG%%=*} OPTARG=${OPTARG#*=}
    case $opt in
    C | alt-class) alt_class=$OPTARG ;;
    d | debug) debug=true ;;
    h | help)
        print-help
        exit 0
        ;;
    *)
        bad-option "$opt"
        exit 2
        ;;
    esac
done
shift $((OPTIND - 1))

$debug && set -x

case "$alt_class" in
'') jvm_flags=("${jvm_flags[@]}" -jar "$jar") ;;
*)
    readonly runtime_classname="$(runtime-classname "$package.$alt_class")"
    jvm_flags=("${jvm_flags[@]}" -cp "$jar" "$runtime_classname")
    ;;
esac

rebuild-if-needed

exec java "${jvm_flags[@]}" "$@"
