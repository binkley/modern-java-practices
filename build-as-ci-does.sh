#/usr/bin/env bash

if ! command -v earthly >/dev/null; then
    echo "$0: No Earthly found in PATH"
    exit 2
fi

set -e  # Fail on first failed command

# Workaround for: https://github.com/earthly/earthly/issues/4220
export EARTHLY_DISABLE_REMOTE_REGISTRY_PROXY=true

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
echo "${pbold}BUILD WITH GRADLE DIRECTLY${preset}" 
./gradlew clean build
echo
echo "${pbold}RUN WITH GRADLE DIRECTLY${preset}" 
./run-with-gradle.sh

echo 
echo "${pbold}BUILD WITH MAVEN UNDER EARTHLY${preset}" 
earthly --secret OWASP_NVD_API_KEY +build-with-maven 
echo
echo "${pbold}RUN WITH MAVEN UNDER EARTHLY${preset}" 
earthly --secret OWASP_NVD_API_KEY +run-with-maven

echo 
echo "${pbold}BUILD WITH MAVEN DIRECTLY${preset}" 
./mvnw clean verify
echo
echo "${pbold}RUN WITH MAVEN DIRECTLY${preset}" 
./run-with-maven.sh
