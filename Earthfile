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

build-with-maven:
    COPY mvnw .
    COPY .mvn .mvn
    COPY pom.xml .
    COPY config config
    COPY src src
    RUN --secret OWASP_NVD_API_KEY ./mvnw --no-transfer-progress clean verify
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
