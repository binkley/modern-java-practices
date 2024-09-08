#/usr/bin/env bash

set -e  # Fail on first failed command

if ! command -v earthly >/dev/null; then
    echo "$0: No Earthly found in PATH" >&2
    exit 2
fi

# Optionally check if gh and the act extension are installed
if gh act --help >/dev/null 2>&1; then
    gh act --artifact-server-path $PWD/workflow-artifacts
    exit $?
elif ! gh --help >/dev/null 2>&1; then
    echo "$0: No gh found in PATH; falling back to earthly" >&2
else
    echo "$0: No nektos/gh-act extension installed; falling back to earthly" >&2
fi

# Workaround for: https://github.com/earthly/earthly/issues/4220
export EARTHLY_DISABLE_REMOTE_REGISTRY_PROXY=true
# TODO: CI does not implement Earthly caching (for now)
# This **significantly** slows the development cycle.
# Best use _this script_ only before pushing changes, else make coffee or tea.
export EARTHLY_NO_CACHE=true

# Provide nicer console output via formatting and color
# See https://github.com/binkley/shell/blob/master/color/color.sh
printf -v preset "\e[0m"
printf -v pbold "\e[1m"

echo 
echo "${pbold}BUILD WITH GRADLE UNDER EARTHLY${preset}" 
earthly --secret OWASP_NVD_API_KEY +build-with-gradle 
echo
echo "${pbold}RUN WITH GRADLE UNDER EARTHLY${preset}" 
earthly --secret OWASP_NVD_API_KEY +run-with-gradle 

echo 
echo "${pbold}BUILD WITH MAVEN UNDER EARTHLY${preset}" 
earthly --secret OWASP_NVD_API_KEY +build-with-maven 
echo
echo "${pbold}RUN WITH MAVEN UNDER EARTHLY${preset}" 
earthly --secret OWASP_NVD_API_KEY +run-with-maven
