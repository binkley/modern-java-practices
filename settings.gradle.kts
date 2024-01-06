pluginManagement {
    repositories {
        maven("https://gradle.pkg.st")
    }
}

plugins {
    id("build.less") version "1.0.0-rc2"
    id("org.gradle.toolchains.foojay-resolver-convention") version "0.7.0"
}

dependencyResolutionManagement {
    repositoriesMode = RepositoriesMode.FAIL_ON_PROJECT_REPOS

    repositories {
        pkgst()
    }
}

rootProject.name = "modern-java-practices"

enableFeaturePreview("STABLE_CONFIGURATION_CACHE")
enableFeaturePreview("GROOVY_COMPILATION_AVOIDANCE")
