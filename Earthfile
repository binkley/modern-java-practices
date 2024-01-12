VERSION --global-cache 0.7
FROM eclipse-temurin:21.0.1_12-jdk-jammy
WORKDIR /code
RUN apt-get update \
    && apt-get install -y zip unzip \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

gradle-commons:
    COPY gradlew .
    COPY gradle/wrapper gradle/wrapper
    COPY gradle.properties .
    COPY settings.gradle.kts .
    COPY build.gradle .
    COPY config config
    CACHE --sharing=shared --id gradle-common /root/.gradle
    CACHE --sharing=shared --id gradle-cache ./.gradle
    SAVE IMAGE --cache-hint

gradle-dependencies:
    FROM +gradle-commons
    COPY gradle/libs.versions.toml gradle/
    COPY gradle/verification-* gradle/
    RUN --secret BUILDLESS_APIKEY ./gradlew dependencies --no-configuration-cache --no-daemon
    SAVE IMAGE --cache-hint

build-with-gradle:
    FROM +gradle-dependencies
    COPY src src
    CACHE --sharing=shared --id gradle-target ./build
    RUN --secret BUILDLESS_APIKEY ./gradlew build test integrationTest --no-configuration-cache --no-daemon --scan

run-with-gradle:
    FROM +build-with-gradle
    COPY run-with-gradle.sh .
    RUN --secret BUILDLESS_APIKEY ./run-with-gradle.sh

maven-commons:
    COPY mvnw .
    COPY .mvn .mvn
    COPY .mvn/settings.xml /root/.m2/settings.xml
    COPY config config
    CACHE --sharing=shared --id maven-common /root/.m2/repository

maven-dependencies:
    FROM +maven-commons
    COPY pom.xml .
    COPY src src
    RUN --secret BUILDLESS_APIKEY ./mvnw -DskipTest -Dmaven.test.skip=true clean package dependency:collect
    SAVE IMAGE --cache-hint

build-with-maven:
    FROM +maven-dependencies
    CACHE --sharing=shared --id maven-target ./target
    RUN --secret BUILDLESS_APIKEY ./mvnw verify

run-with-maven:
    FROM +build-with-maven
    COPY run-with-maven.sh .
    RUN --secret BUILDLESS_APIKEY ./run-with-maven.sh
