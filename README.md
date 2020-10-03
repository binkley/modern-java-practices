<a href="LICENSE.md">
<img src="https://unlicense.org/pd-icon.png" alt="Public Domain" align="right"/>
</a>

# Modern Java/JVM Build Practices

## TOC

* [Goals](#goals)
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

## Goals

This project has simple goals:

* Quick solutions for raising project quality and security in your build
* Starters for Modern use of the JVM
* Focused on Gradle or Maven
* Agnostic on language (Java, Kotlin, et al)

## Alternatives

You may find other starters more helpful, depending on your circumstances. I
recommended you review them, and decide what works best for you:

- [JHipster](https://www.jhipster.tech/)
- [Spring Start](https://start.spring.io/)

## Project setup

* Provide a *good* README. See
  [_Elegant READMEs_](https://www.yegor256.com/2019/04/23/elegant-readme.html)
    * DO follow recommendations, for example, _batches_ (see below)
* Build wrappers (
  [`./gradlew`](https://docs.gradle.org/current/userguide/gradle_wrapper.html)
  ,
  [`./mvnw`](https://github.com/takari/maven-wrapper)) -- see
  [Use Gradle or Maven](#use-gradle-or-maven)
* Run CI on push to a shared repository. For example, use GitHub actions
  (TODO: What is GitLabs equivalent?)
    - Use caches for dependency downloads
    - Exact details depend on Gradle vs Maven
* Build JVM and plugin customizations goes in `config/`
* Discuss tradeoffs with multi-module vs multi-repo projects
* Do not commit IDE files except in specific circumstances
    * Discuss `.editorconfig`
    * Discuss IDE config sharing options
* Pick a common code style, and stay consistent; update tooling to complain on
  style violations
    * Discuss variances in style -- Sun, Google, etc
* IDE plugins:
    * Team consistency
    * Help for Gradle/Maven plugins
    * How to discuss non-IntelliJ Plugins?

## Use Gradle or Maven

Projects using Ant should be updated. The choice between Maven and Gradle
depends on the team, and other factors. Ant is outdated, and does not support
modern tooling.  *Consider Ant builds no longer supported, and a form of Tech
Debt.*

There are alternative build choices for specific projects and circumstances
such as [Buck](https://buck.build) (related to [Bazel](https://bazel.build)),
et al. This article focuses on Gradle and Maven which are considered
"standard" in the JVM community, wide-spread in use, and with much direct and
indirect support for problems.

## Keep local consistent with CI

* [Batect](https://batect.dev/)
* Do not use a JDK older than version 11
    * **TODO**: Discuss OpenJDK
    * **TODO**: Discuss Oracle roadmap on Java
    * **TODO**: Discuss tradeoffs between LTS version and newer JDK versions
* [jEnv](https://www.jenv.be/) or equivalent

## Keep build current

* OpenJDK
    * **TODO**: Pull out JDK discussions to a separate section
    * **TODO**: Discuss [AdoptOpenJDK](https://adoptopenjdk.net/)
    * Avoid Java 8, it is no longer supported
    * Java 11 is "old" but supported
    * Java 15 is the currently supported version
* Discuss each "versions" update plugin
* Team agreement on releases only, or non-release dependencies

## Generate code

* [Lombok](https://projectlombok.org/) (mention `@Generated` for lying to
  JaCoCo)
* (Brief mention of Kotlin)?

## Use linting

Linting for Kotlin is brain-dead simple. What about Java, Scala, Clojure?

## Use static code analysis

* [SpotBugs](https://spotbugs.github.io/)

Shift security _left_ with:

* [Find Security Bugs](https://find-sec-bugs.github.io/)

## Leverage unit testing

* [JaCoCo](https://www.jacoco.org/jacoco/)
* "Ratchet" to fail build when coverage drops
* Fluent assertions -- lots of options in this area,
  [AssertJ](https://assertj.github.io/doc/) solid choice

## Use mutation testing

* [PITest](http://pitest.org/)

## Use integration testing

* [TestContainers](https://www.testcontainers.org/)

## Shift security _left_

* [DependencyCheck](https://owasp.org/www-project-dependency-check/)
