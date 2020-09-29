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

* Provide a *good* README.  See
  [_Elegant READMEs_](https://www.yegor256.com/2019/04/23/elegant-readme.html)
  * DO follow recommendations, for example, _batches_ (see below)
* GitHub actions (TODO: What is GitLabs equivalent?)
  - Use caches for dependency downloads
  - Exact details depend on Gradle vs Maven
* Build wrappers (
  [`./gradlew`](https://docs.gradle.org/current/userguide/gradle_wrapper.html),
  [`./mvnw`](https://github.com/takari/maven-wrapper)) -- see
  [Use Gradle or Maven](#use-gradle-or-maven)
* Build JVM and plugin customizations goes in `config/`
* Discuss tradeoffs with multi-module vs multi-repo projects
* Do not commit IDE files except in specific circumstances
  * Discuss `.editorconfig`
  * Discuss IDE config sharing options
* Pick a common code style, and stay consistent; update tooling to complain
  on style violations
  * Discuss variances in style -- Sun, Google, etc
* IDE plugins:
  * Team consistency
  * Help for Gradle/Maven plugins
  * How to discuss non-IntelliJ Plugins?

## Use Gradle or Maven

Projects using Ant should be updated.  The choice between Maven and Gradle
depends on the team and other factors.  Ant is rather outdated, does not
support modern tooling, and no longer updated.

There are other options particular to specific projects such as
[Buck](https://buck.build) (related to [Bazel](https://bazel.build)), et al.
This article focuses on Gradle and Maven, which are by far more wide spread.

## Keep local consistent with CI

* [Batect](https://batect.dev/)
* Do not use a JDK older than version 11
  * Discuss OpenJDK
  * Discuss Oracle readmap on Java
  * Discuss tradeoffs between LTS version and newer JDK versions
* [jEnv](https://www.jenv.be/) or equivalent

## Keep build current

* OpenJDK
  * Discuss [AdoptOpenJDK](https://adoptopenjdk.net/)
  * Avoid Java 8, it is no longer supported
  * Java 11 is "old" but supported
  * Java 15 is the current supported version
* Discuss each "versions" update plugin
* Team agreement on releases only, or non-release dependencies

## Generate code

* [Lombok](https://projectlombok.org/) (mention `@Generated` for lying to
  JaCoCo)
* (Brief mention of Kotlin)?

## Use linting

Linting for Kotlin is brain-dead simple.  What about Java, Scala, Clojure?

## Use static code analysis

* [SpotBugs](https://spotbugs.github.io/)

## Leverage unit testing

* [JaCoCo](https://www.jacoco.org/jacoco/)
* "Ratchet" to fail build when coverage drops
* Fluent assertions -- lots of options in this area,
  [AssertJ](https://assertj.github.io/doc/) solid choice

## Use mutation testing

* [PITest](http://pitest.org/)

## Use integration testing

* [TestContainers](https://www.testcontainers.org/)

## Shift security left

* [DependencyCheck](https://owasp.org/www-project-dependency-check/)
