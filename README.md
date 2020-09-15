<a href="LICENSE.md">
<img src="https://unlicense.org/pd-icon.png" alt="Public Domain" align="right"/>
</a>

# Modern Java/JVM Build Practices

## TOC

* [Project setup](#project-setup)
* [Use Gradle or Maven](#use-gradle-or-maven)
* [Keep local consistent with CI](#keep-local-consistent-with-ci)
* [Keep build current](#keep-build-current)
* [Generate code](#generate-code)
* [Use linting](#use-linting)
* [Use static code analysis](#use-static-code-analysis)
* [Leverage unit testing](#leverage-unit-testing)
* [Use mutation testing](#use-mutation-testing)
* [Use integration testing](#use-integration-testing)
* [Shift security left](#shift-security-left)

## Project setup

* Good README (find Yegor's post on this)
* GitHub actions
* Build wrappers (`./gradlew`, `./mvnw`) -- see
  [Use Gradle or Maven](#use-gradle-or-maven)
* Build JVM and plugin customizations goes in `config/`
* Discuss tradeoffs with multi-module vs multi-repo projects
* Do not commit IDE files except in specific circumstances.  Discuss
  `.editorconfig`
* Pick a common code style, and stay consistent; update tooling to complain
  on style violations
* IDE plugins:
  * Team consistency
  * Help for Gradle/Maven plugins

## Use Gradle or Maven

Projects using Ant should be updated.  The choice between Maven and Gradle
depends on the team and other factors.  Ant is rather outdated, does not
support modern tooling, and no longer updated.

## Keep local consistent with CI

* Batect
* Do not use a JDK older than version 11
* Discuss tradeoffs between LTS version and newer JDK versions
* jEnv or equivalent

## Keep build current

* OpenJDK
* DependencyUpdate or Versions plugins
* Team agreement on releases only, or non-release dependencies

## Generate code

* Lombok (mention @Generated to lie to JaCoCo)
* (Brief mention of Kotlin)?

## Use linting

## Use static code analysis

* SpotBugs

## Leverage unit testing

* JaCoCo
* "Ratchet" to fail build when coverage drops
* Fluent assertions -- lots of options in this area, AssertJ solid choice

## Use mutation testing

* PITest

## Use integration testing

* TestContainers

## Shift security left

* DependencyCheck
