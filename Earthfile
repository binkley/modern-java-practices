VERSION 0.7
FROM eclipse-temurin:21.0.1_12-jdk-jammy
WORKDIR /code

gradle-commons:
    ARG builder
    COPY gradlew .
    COPY gradle gradle
    COPY gradle.properties .
    COPY settings.gradle.kts .
    COPY build.gradle .
    COPY config config
    COPY src src
    RUN --mount type=cache,target=.gradle
    RUN --mount type=cache,target=~/.gradle
    RUN --secret BUILDLESS_APIKEY ./gradlew dependencies
    SAVE IMAGE --push "$builder"

build-with-gradle:
    FROM +gradle-commons
    RUN --secret BUILDLESS_APIKEY ./gradlew clean build --no-configuration-cache

run-with-gradle:
    FROM +build-with-gradle
    COPY run-with-gradle.sh .
    RUN --secret BUILDLESS_APIKEY ./run-with-gradle.sh

build-with-maven:
    ARG builder
    COPY mvnw .
    COPY .mvn .mvn
    COPY pom.xml .
    COPY config config
    COPY src src
    RUN ./mvnw clean verify
    SAVE IMAGE --push "$builder"

run-with-maven:
    FROM +build-with-maven
    COPY run-with-maven.sh .
    RUN ./run-with-maven.sh
