#!/usr/bin/env bash
# shellcheck disable=SC2214,SC2215

# Edit these to suit
readonly package=hm.binkley.md
readonly artifactId=modern-java-practices
readonly version=0-SNAPSHOT
build_tool=maven # or gradle -- this sets the default
language=java # or kotlin -- this sets the default
jvm_flags=()
# No editable parts below here

export PS4='+${BASH_SOURCE}:${LINENO}:${FUNCNAME[0]:+${FUNCNAME[0]}():} '

set -e
set -u
set -o pipefail

readonly progname="${0##*/}"

case $build_tool in
gradle | maven) ;;
*)
    echo "$progname: BUG: Pick 'gradle' or 'maven': $build_tool" >&2
    exit 2
    ;;
esac

case $language in
java | kotlin) ;;
*)
    echo "$progname: BUG: Pick 'java' or 'kotlin': $language" >&2
    exit 2
    ;;
esac

function print-help() {
    cat <<EOH
Usage: $progname [OPTIONS] [-- ARGUMENTS]
Runs a single-jar JVM project.

Options:
  -B, --build-tool=TOOL
                 builds the example using TOOL; tools:
                    gradle$([[ gradle == "$build_tool" ]] && echo ' (default)')
                    maven$([[ maven == "$build_tool" ]] && echo ' (default)')
  -C, --alt-class=CLASS
                 execute CLASS as the alternate main class, otherwise assume
                 the jar is executable
  -L, --language=LANGUAGE
                 runs the example for LANGUAGE; languages:
                    java$([[ java == "$language" ]] && echo ' (default)')
                    kotlin$([[ kotlin == "$language" ]] && echo ' (default)')
  -d, --debug    print script execution to STDERR
  -h, --help     display this help and exit

Examples:
  $progname              Runs the executable jar with no arguments to main
  $progname -C a-class   Runs the main from "a-class"
  $progname -- an-arg    Runs the executable jar passing "an-arg" to main
EOH
}

function bad-build-tool() {
    local tool="$1"

    cat <<EOM
$progname: invalid build tool -- '$tool'
Try '$progname --help' for more information.
EOM
}

function bad-language() {
    local language="$1"

    cat <<EOM
$progname: invalid language -- '$language'
Try '$progname --help' for more information.
EOM
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
    case "$language" in
    java) echo "$package.$alt_class" ;;
    kotlin) mangle-kotlin-classname "$package.$alt_class" ;;
    esac
}

function rebuild-if-needed() {
    # TODO: Rebuild if build script is newer than jar
    [[ -e "$jar" && -z "$(find src/main -type f -newer "$jar")" ]] && return

    case $build_tool in
    gradle) ./gradlew --warning-mode=all jar ;;
    maven) ./mvnw --strict-checksums -Dmaven.test.skip=true package ;;
    esac
}

alt_class=''
debug=false
while getopts :B:C:L:a:b:dhl:-: opt; do
    [[ $opt == - ]] && opt=${OPTARG%%=*} OPTARG=${OPTARG#*=}
    case $opt in
    B | build-tool) case "$OPTARG" in
        gradle | maven) build_tool="$OPTARG" ;;
        *)
            bad-build-tool "$OPTARG"
            exit 2
            ;;
        esac ;;
    C | alt-class) alt_class=$OPTARG ;;
    L | language) case "$OPTARG" in
        java | kotlin) language="$OPTARG" ;;
        *)
            bad-language "$OPTARG"
            exit 2
            ;;
        esac ;;
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

case $build_tool in
gradle)
    if [[ ! -x "./gradlew" ]]; then
        echo "$progname: Not executable: ./gradlew" >&2
        exit 2
    fi
    readonly jar=build/libs/$artifactId-$version.jar
    ;;
maven)
    if [[ ! -x "./mvnw" ]]; then
        echo "$progname: Not executable: ./mvnw" >&2
        exit 2
    fi
    readonly jar=target/$artifactId-$version-jar-with-dependencies.jar
    ;;
esac

case "$alt_class" in
'') jvm_flags=("${jvm_flags[@]}" -jar "$jar") ;;
*)
    readonly runtime_classname="$(runtime-classname "$package.$alt_class")"
    jvm_flags=("${jvm_flags[@]}" -cp "$jar" "$runtime_classname")
    ;;
esac

rebuild-if-needed

exec java "${jvm_flags[@]}" "$@"
