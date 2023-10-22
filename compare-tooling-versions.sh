#!/usr/bin/env bash

# TODO: Assume GNU diff with colorization: how to present with old diff?
# TODO: Treat plugins as one-offs, and do not compare between Gradle and Maven

# Challenging to correctly and fully compare Gradle and Maven builds
# For example, sometimes a plugin keeps in version sync upstream, sometimes
# the plugins for the same feature come from different sources with different
# version numbers.  Especially for bundled plugins, there is often no
# correspondence between Gradle and Maven

# To try other diff options, pass them on the command line to the script
# By default, this script adds color

echo "LEFT is Gradle; RIGHT is Maven"
diff --color=auto --minimal "$@" \
    <(sed -n 's,^\(.*\)Version=\(.*\),\1 \2,p' < gradle.properties \
    | tr '[:upper:]' '[:lower:]' \
    | tr -d - \
    | sort) \
    <(sed -n 's, *<\([^.]*\)\.version>\([^<]*\)</[^.]*\.version>,\1 \2,p' < pom.xml \
    | tr '[:upper:]' '[:lower:]' \
    | tr -d - \
    | sed 's/maven//g' \
    | sort)

# diff is expected to fail
exit 0
