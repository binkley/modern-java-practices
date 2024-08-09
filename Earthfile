VERSION 0.8
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /code

build-with-gradle:
    COPY gradlew .
    COPY gradle gradle
    COPY gradle.properties .
    COPY settings.gradle .
    COPY build.gradle .
    COPY config config
    COPY src src
    RUN --secret OWASP_NVD_API_KEY ./gradlew clean build

run-with-gradle:
    FROM +build-with-gradle
    COPY run-with-gradle.sh .
    RUN ./run-with-gradle.sh

    # For CI so that GitHub can copy artifacts
# Coverage reports
    SAVE ARTIFACT --keep-ts build/reports/jacoco/test/ AS LOCAL build/reports/jacoco/test/
# Javadocs and jars
    SAVE ARTIFACT --keep-ts build/libs/modern-java-practices-0-javadoc.jar
    SAVE ARTIFACT --keep-ts build/docs/javadoc/test/ AS LOCAL build/docs/javadoc/test/

# Test coverage and badge for Gradle:
# You need to PICK ONE from Gradle or Maven for your build.
# This project uses Maven (see below) to create the code coverage badge to
# avoid multiple updating.
# Commented is the minimum needed from the containerized build when using
# Gradle.
# After this enabling this, you still need to update the GitHub action steps
# to generate the badge using a custom path to the CVS report.
    SAVE ARTIFACT --save-ts build/reports/jacoco/test/jacocoTestReport.csv AS LOCAL build/reports/jacoco/test/jacocoTestReport.csv
# Experiment if GitHub shows test coverage from these reports:
    SAVE ARTIFACT --keep-ts build/reports/jacoco/test/jacocoTestReport.csv build/reports/jacoco/test/jacocoTestReport.csv

build-with-maven:
    COPY mvnw .
    COPY .mvn .mvn
    COPY pom.xml .
    COPY config config
    COPY src src
    RUN --secret OWASP_NVD_API_KEY ./mvnw --no-transfer-progress clean verify

    # For CI so that GitHub can copy artifacts
# Coverage reports
    SAVE ARTIFACT --keep-ts target/site/jacoco/
# Javadocs and jars
    SAVE ARTIFACT --keep-ts target/modern-java-practices-0-SNAPSHOT-javadoc.jar AS LOCAL target/modern-java-practices-0-SNAPSHOT-javadoc.jar
    SAVE ARTIFACT --keep-ts target/apidocs/ AS LOCAL target/apidocs/
    SAVE ARTIFACT --keep-ts target/modern-java-practices-0-SNAPSHOT-test-javadoc.jar AS LOCAL target/modern-java-practices-0-SNAPSHOT-test-javadoc.jar
    SAVE ARTIFACT --keep-ts target/testapidocs/ AS LOCAL target/testapidocs/

# Test coverage and badge for Maven:
# See above comments on enabling for Gradle.
# Note that ONLY the Maven containerized build updates the README frontpage
# badge for coverage. This is to avoid multiple updating.
#
# ALSO NOTE: This seems to enable GitHub action to show coverage directly in
# an action build run.
    SAVE ARTIFACT --keep-ts target/site/jacoco/jacoco.csv AS LOCAL target/site/jacoco/jacoco.csv

run-with-maven:
    FROM +build-with-maven
    COPY run-with-maven.sh .
    RUN ./run-with-maven.sh

build:
    BUILD +build-with-gradle
    BUILD +build-with-maven

run:
    BUILD +run-with-gradle
    BUILD +run-with-maven
