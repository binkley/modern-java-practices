#!/usr/bin/env bash

echo "LEFT IS Gradle; RIGHT IS Maven"
diff \
    <(sed -n 's,^\(.*\)Version=\(.*\),\1 \2,p' < gradle.properties | tr '[:upper:]' '[:lower:]') \
    <(sed -n 's, *<\([^.]*\)\.version>\([^<]*\)</[^.]*\.version>,\1 \2,p' < pom.xml | tr '[:upper:]' '[:lower:]')
