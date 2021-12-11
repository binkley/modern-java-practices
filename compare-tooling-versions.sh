#!/bin/sh

sed -n 's,^\(.*\)Version=\(.*\),\1 \2,p' < gradle.properties 
echo
sed -n 's, *<\([^.]*\)\.version>\([^<]*\)</[^.]*\.version>,\1 \2,p' < pom.xml 
