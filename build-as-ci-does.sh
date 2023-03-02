#/usr/bin/env bash

if ! command -v earthly >/dev/null; then
    echo "$0: No Earthly found in PATH"
    exit 2
fi

./batect build-with-gradle && \
    ./batect -o quiet run-with-gradle &&
    earthly +build-with-gradle &&
    earthly +run-with-gradle &&
    ./batect build-with-maven &&
    ./batect -o quiet run-with-maven &&
    earthly +build-with-maven &&
    earthly +run-with-maven
