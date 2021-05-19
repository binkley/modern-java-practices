#!/usr/bin/env bash
# shellcheck disable=SC2214,SC2215

# Edit these to suit
readonly package=hm.binkley.md
readonly artifactId=modern-java-practices
readonly version=0-SNAPSHOT
build_tool=maven # or gradle -- this sets the default

# No editable parts below here

export PS4='+${BASH_SOURCE}:${LINENO}:${FUNCNAME[0]:+${FUNCNAME[0]}():} '

set -e
set -u
set -o pipefail

readonly progname="${0##*/}"

case $build_tool in
gradle | maven) ;;
*)
    echo "$progname: BUG: Build with 'gradle' or 'maven': $build_tool" >&2
    exit 2
    ;;
esac

function print-help() {
    cat <<EOH
Usage: $progname [-GJMXdh] [CLASS] [ARGUMENTS]
Runs a single-jar Kotlin project.

With no CLASS, assume the jar is executable.

  -G, --gradle      build with Gradle$([[ gradle == "$build_tool" ]] && echo ' (default)')
  -J, --java        treat CLASS as a Java class
  -M, --maven       build with Maven$([[ maven == "$build_tool" ]] && echo ' (default)')
  -X, --executable  stop processing command line
  -d, --debug       print script execution to STDERR
  -h, --help        display this help and exit

Examples:
  $progname            Runs the executable jar with no arguments to main
  $progname -X an-arg  Runs the executable jar passing "an-arg" to main
  $progname a-class    Runs the main from "a-class"
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

function rebuild-if-needed() {
    # TODO: Rebuild if build script is newer than jar
    [[ -e "$jar" && -z "$(find src/main -type f -newer "$jar")" ]] && return

    case $build_tool in
    gradle) ./gradlew --warning-mode=all jar ;;
    maven) ./mvnw -C -Dmaven.test.skip=true package ;;
    esac
}

debug=false
executable=false
kotlin=true
while getopts :GJMXdh-: opt; do
    [[ $opt == - ]] && opt=${OPTARG%%=*} OPTARG=${OPTARG#*=}
    case $opt in
    G | gradle) build_tool=gradle ;;
    J | java) kotlin=false ;;
    M | maven) build_tool=maven ;;
    X | executable)
        executable=true
        break
        ;;
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

case $build_tool in
gradle)
    if [[ ! -f build.gradle && ! -f build.gradle.kts ]]; then
        echo "$0: BUG: build tool 'gradle' build not supported" >&2
        exit 2
    fi
    readonly jar=build/libs/$artifactId-$version.jar
    ;;
maven)
    if [[ ! -f pom.xml ]]; then
        echo "$0: BUG: build tool 'maven' build not supported" >&2
        exit 2
    fi
    readonly jar=target/$artifactId-$version-jar-with-dependencies.jar
    ;;
esac

$debug && set -x
((0 == $#)) && executable=true

if $executable; then
    set - -jar "$jar" "$@"
else
    if $kotlin; then
        readonly class="$(mangle-kotlin-classname "$package.$1")"
    else
        readonly class="$package.$1"
    fi
    shift
    set - -cp "$jar" "$class" "$@"
fi

$debug && set -x # "set - ..." clears the -x flag

rebuild-if-needed

exec java -ea --enable-preview "$@"
