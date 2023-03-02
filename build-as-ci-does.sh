#/usr/bin/env bash

./batect build-with-gradle && \
    ./batect -o quiet run-with-gradle &&
    ./batect build-with-maven &&
    ./batect -o quiet run-with-maven
