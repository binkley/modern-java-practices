VERSION 0.7
FROM eclipse-temurin:21.0.1_12-jdk-jammy
WORKDIR /code

build-with-gradle:
    COPY gradlew .
    COPY gradle gradle
    COPY gradle.properties .
    COPY settings.gradle.kts .
    COPY build.gradle .
    COPY config config
    COPY src src
    RUN ./gradlew clean build --no-configuration-cache

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
    RUN ./mvnw clean verify

run-with-maven:
    FROM +build-with-maven
    COPY run-with-maven.sh .
    RUN ./run-with-maven.sh
