VERSION 0.8
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /code

# build-with-gradle builds and tests with Gradle, and saves the build/ directory
build-with-gradle:
    COPY gradlew .
    COPY gradle gradle
    COPY gradle.properties .
    COPY settings.gradle .
    COPY build.gradle .
    COPY config config
    COPY src src
    RUN --secret OWASP_NVD_API_KEY ./gradlew clean build

    # For CI so that GitHub can copy artifacts:
    # Just copy everything rather than maintain a whitelist of files/dirs.
    SAVE ARTIFACT --keep-ts build AS LOCAL build

# run-with-gradle runs the demo program with Gradle, building if needed
run-with-gradle:
    FROM +build-with-gradle
    COPY run-with-gradle.sh .
    RUN ./run-with-gradle.sh

# build-with-maven builds and tests with Maven, and saves the target/ directory
build-with-maven:
    COPY mvnw .
    COPY .mvn .mvn
    COPY pom.xml .
    COPY config config
    COPY src src
    RUN --secret OWASP_NVD_API_KEY ./mvnw --no-transfer-progress clean verify

    # For CI so that GitHub can copy artifacts:
    # Just copy everything rather than maintain a whitelist of files/dirs.
    SAVE ARTIFACT --keep-ts target AS LOCAL target

# run-with-maven runs the demo program with Maven, building if needed
run-with-maven:
    FROM +build-with-maven
    COPY run-with-maven.sh .
    RUN ./run-with-maven.sh

# build executes both +build-with-gradle and +build-with-maven targets
build:
    BUILD +build-with-gradle
    BUILD +build-with-maven

# run executes both +run-with-gradle and +run-with-maven targets
run:
    BUILD +run-with-gradle
    BUILD +run-with-maven
