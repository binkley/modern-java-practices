#/usr/bin/env bash

if ! command -v earthly >/dev/null; then
    echo "$0: No Earthly found in PATH"
    exit 2
fi

set -e

# Provide nicer console output via formatting and color
# See https://github.com/binkley/shell/blob/master/color/color.sh
printf -v preset "\e[0m"
printf -v pbold "\e[1m"

echo "${preset}"
echo "${pbold}BUILD WITH GRADLE UNDER BATECT${preset}"
./batect -o quiet build-with-gradle
echo "${pbold}RUN WITH GRADLE UNDER BATECT${preset}"
./batect -o quiet run-with-gradle

echo 
echo "${pbold}BUILD WITH MAVEN UNDER BATECT${preset}"
./batect -o quiet build-with-maven
echo "${pbold}RUN WITH MAVEN UNDER BATECT${preset}"
./batect -o quiet run-with-maven

echo 
echo "${pbold}BUILD WITH GRADLE UNDER EARTHLY${preset}" 
earthly \
  --secret BUILDLESS_APIKEY \
  --remote-cache=ghcr.io/sgammon/modern-java-practices/builder/gradle:latest \
  --push \
  --ci \
  +build-with-gradle

echo "${pbold}RUN WITH GRADLE UNDER EARTHLY${preset}"
earthly \
  --secret BUILDLESS_APIKEY \
  --remote-cache=ghcr.io/sgammon/modern-java-practices/builder/gradle:latest \
  --push \
  --ci \
  +run-with-gradle

echo 
echo "${pbold}BUILD WITH MAVEN UNDER EARTHLY${preset}" 
earthly \
  --secret BUILDLESS_APIKEY \
  --remote-cache=ghcr.io/sgammon/modern-java-practices/builder/maven:latest \
  --push \
  --ci \
  +build-with-maven

echo "${pbold}RUN WITH MAVEN UNDER EARTHLY${preset}" 
earthly \
  --secret BUILDLESS_APIKEY \
  --remote-cache=ghcr.io/sgammon/modern-java-practices/builder/maven:latest \
  --push \
  --ci \
  +run-with-maven
