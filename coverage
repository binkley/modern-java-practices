#!/usr/bin/env bash

export PS4='+${BASH_SOURCE}:${LINENO}:${FUNCNAME[0]:+${FUNCNAME[0]}():} '

set -e
set -u
set -o pipefail

readonly progname="${0##*/}"

function print-help() {
    cat <<EOH
Usage: $progname [OPTIONS] [-- ARGUMENTS]
Checks code coverage and optionally opens the report.

OPTIONS:
  -f, --full-coverage=TYPE
                        force coverage check to 100%
                          all - both unit and mutation
                          mutation - mutation only
                          unit - unit only
  -h, --help            print this help and exit
  -m, --with-mutation   also check mutation coverage
  -o, --open-report     open coverage reports in a web browser
  -x, --no-rerun        only open coverage reports, do not rerun build

ARGUMENTS:
  All arguments are passed to ./mvnw as options.  The "--" is mandatory.
EOH
}

function bad-option() {
    cat <<EOM
$progname: invalid option -- '$1'
Try '$progname --help' for more information.
EOM
}

function bad-option-argument() {
    case $# in
    1) cat <<EOM ;;
$progname: option '$1' requires an argument
Try '$progname --help' for more information.
EOM
    2) cat <<EOM ;;
$progname: invalid "$2" for -$2 option
Try '$progname --help' for more information.
EOM
    esac
}

function require-file() {
    local file="$1"
    shift
    if [[ ! -f "$file" ]]; then
        echo "$progname: $file: No such file or directory" >&2
        return 1
    fi
}

full=none
mutation=false
open=false
run=true
# shellcheck disable=SC2214
while getopts :f:hmox-: opt; do
    [[ $opt == - ]] && opt=${OPTARG%%=*} OPTARG=${OPTARG#*=}
    # shellcheck disable=SC2213
    case $opt in
    f | full-coverage)
        case "$OPTARG" in
        unit) full="$OPTARG" ;;
        all | mutation) mutation=true full="$OPTARG" ;;
        *)
            bad-option-argument "-f" "$OPTARG"
            exit 2
            ;;
        esac
        ;;
    h | help)
        print-help
        exit 0
        ;;
    m | with-mutation) mutation=true ;;
    o | open-report) open=true ;;
    x | no-rerun) open=true run=false ;;
    \?)
        bad-option "$OPTARG"
        exit 2
        ;;
    :)
        bad-option-argument "$OPTARG"
        exit 2
        ;;
    esac
done
shift $((OPTIND - 1))

case "$full" in
none) flags='' ;;
all)
    flags='-Dcoverage.lines=100 -Dcoverage.branches=100 -Dcoverage.instructions=100 -Dcoverage.mutation=100'
    ;;
mutation)
    flags='-Dcoverage.mutation=100'
    ;;
unit)
    flags='-Dcoverage.lines=100 -Dcoverage.branches=100 -Dcoverage.instructions=100'
    ;;
esac

((rc = 0)) || true
if $run; then
    if $mutation; then
        targets='-DwithHistory clean verify'
    else
        targets='clean test jacoco:report jacoco:check'
    fi

    # shellcheck disable=SC2086
    ./mvnw $flags "$@" $targets || ((rc += $?)) || true
else
    # Refresh coverage report when editing limits in pom.xml without rebuild
    ./mvnw $flags "$@" jacoco:report jacoco:check || ((rc += $?)) || true
fi

if $open; then
    if require-file target/site/jacoco/index.html; then
        (cd target/site/jacoco && open index.html)
    else
        ((++rc))
    fi
    if $mutation && require-file target/pit-reports/index.html; then
        (cd target/pit-reports && open index.html)
    else
        ((++rc))
    fi
fi

# shellcheck disable=SC2086
exit $rc
