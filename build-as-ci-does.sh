#/bin/sh

./batect build-with-gradle && \
    ./batect run-with-gradle &&
    ./batect build-with-maven &&
    ./batect run-with-maven
