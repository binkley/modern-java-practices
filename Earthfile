VERSION 0.7
FROM eclipse-temurin:21.0.1_12-jdk-jammy
WORKDIR /code

gradle-commons:
    COPY gradlew .
    COPY gradle gradle
    COPY gradle.properties .
    COPY settings.gradle.kts .
    COPY build.gradle .
    COPY config config
    COPY src src
    CACHE --sharing=shared --id gradle-common ~/.gradle
    CACHE --sharing=shared --id gradle-cache ./.gradle
    RUN --secret BUILDLESS_APIKEY ./gradlew dependencies --no-configuration-cache --no-daemon
    SAVE IMAGE --cache-hint

build-with-gradle:
    FROM +gradle-commons
    RUN --secret BUILDLESS_APIKEY ./gradlew build test integrationTest --no-configuration-cache --no-daemon --scan

run-with-gradle:
    FROM +build-with-gradle
    COPY run-with-gradle.sh .
    RUN --secret BUILDLESS_APIKEY ./run-with-gradle.sh

maven-commons:
    COPY mvnw .
    COPY .mvn .mvn
    COPY .mvn/settings.xml ~/.m2/settings.xml
    COPY pom.xml .
    COPY config config
    COPY src src
    CACHE --sharing=shared --id maven-common ~/.m2
    RUN --secret BUILDLESS_APIKEY ./mvnw clean dependency:copy-dependencies
    SAVE IMAGE --cache-hint

build-with-maven:
    FROM +maven-commons
    RUN --secret BUILDLESS_APIKEY ./mvnw clean verify

run-with-maven:
    FROM +build-with-maven
    COPY run-with-maven.sh .
    RUN --secret BUILDLESS_APIKEY ./run-with-maven.sh
