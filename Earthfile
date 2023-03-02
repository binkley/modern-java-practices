VERSION 0.7
FROM eclipse-temurin:17-jdk-focal
WORKDIR /java-example

build-with-gradle:
    COPY gradlew .
    COPY gradle gradle
    COPY gradle.properties .
    COPY settings.gradle .
    COPY build.gradle .
    COPY config config
    COPY src src
    RUN ./gradlew clean build

build-with-maven:
    COPY mvnw .
    COPY .mvn .mvn
    COPY pom.xml .
    COPY config config
    COPY src src
    RUN ./mvnw clean verify
