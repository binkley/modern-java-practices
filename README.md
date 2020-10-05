<a href="LICENSE.md">
<img src="https://unlicense.org/pd-icon.png" alt="Public Domain" align="right"/>
</a>

# Modern Java Build Practices

[![build](https://github.com/binkley/modern-java-practices/workflows/build/badge.svg)](https://github.com/binkley/modern-java-practices/actions)
[![issues](https://img.shields.io/github/issues/binkley/modern-java-practices.svg)](https://github.com/binkley/modern-java-practices/issues/)
[![Public Domain](https://img.shields.io/badge/license-Public%20Domain-blue.svg)](http://unlicense.org/)

**Modern Java Build Practices** is an article on bootstrapping modern
JVM-based projects with sample builds for Gradle and Maven, and focus on
_hygiene_ and best practices.

---

## TOC

* [Goals](#goals)
* [Project setup](#project-setup)
* [Use Gradle or Maven](#use-gradle-or-maven)
* [Keep local consistent with CI](#keep-local-consistent-with-ci)
* [Keep build current](#keep-build-current)
* [Generate code](#generate-code)
* [Use linting](#use-linting)
* [Use static code analysis](#use-static-code-analysis)
* [The test pyramid](#the-test-pyramid)
* [Leverage unit testing and coverage](#leverage-unit-testing-and-coverage)
* [Use mutation testing](#use-mutation-testing)
* [Use integration testing](#use-integration-testing)
* [Use contract testing when appropriate](#use-contract-testing-when-appropriate)
* [Shift security left](#shift-security-left)
* [TODOs](#todos)

This is a "work in progress". Much of it is bullet points, intending to flesh
these out to full-written sections.

---

## Goals

This project has simple goals:

* Quick solutions for raising project quality and security in your build
* Starters for Modern use of the JVM
* Focused on Gradle or Maven
* Agnostic on language (Java, Kotlin, et al)

### Alternative starter tools

You may find other starters more helpful, depending on your circumstances. I
recommended you review them, and decide what works best for you. Some examples
include:

* [JHipster](https://www.jhipster.tech/)
* [Spring Start](https://start.spring.io/)

This article should provide enough information to update generated projects.

---

## Project setup

**TODO**: Pull IDE-related topics to a separate section

* Provide a *good* README. See
  [_Elegant READMEs_](https://www.yegor256.com/2019/04/23/elegant-readme.html)
    * DO follow recommendations, for example, _badges_ (see below)
* Use build wrappers committed into the project root:
    * [`./gradlew`](https://docs.gradle.org/current/userguide/gradle_wrapper.html)
    * [`./mvnw`](https://github.com/takari/maven-wrapper)
* Run CI on push to a shared repository. For example, use GitHub actions
  (TODO: What is GitLabs equivalent?)
    * Use caches for dependency downloads
    * Exact details depend on Gradle vs Maven
* Build plugin customizations goes in `config/` (see [Lombok](#lombok) for an
  exception)
* Do not commit IDE files except in specific circumstances
    * Discuss `.editorconfig`
    * Discuss IDE config sharing options
* Pick a common code style, and stay consistent; update tooling to complain on
  style violations
    * Discuss variances in style -- Sun, Google, etc
    * See [Use linting](#use-linting)
* IDE plugins:
    * Team consistency
    * Help for Gradle/Maven plugins
    * How to discuss non-IntelliJ Plugins?

---

## Use Gradle or Maven

Projects using Ant should be updated. The choice between Maven and Gradle
depends on the team, and other factors. Ant is outdated, and does not support
modern tooling.  **Consider Ant builds no longer supported, and a form of
[Tech Debt](https://www.martinfowler.com/bliki/TechnicalDebt.html).**

There are alternative build choices for specific projects and circumstances
such as [Buck](https://buck.build) (related to [Bazel](https://bazel.build)),
et al. This article focuses on Gradle and Maven which are considered
"standard" in the JVM community, wide-spread in use, and with much direct and
indirect support for problems.

Throughout when covering both Gradle and Maven, Gradle will be discussed
first, then Maven. This is no expressing a preference!  It is neutral
alphabetical order.

---

## Keep local consistent with CI

* [Batect](https://batect.dev/)
    * **TODO**: **BLOCKED** pending a released AdoptOpenJDK 15 Docker image
* Do not use a JDK older than version 11
    * **TODO**: Discuss OpenJDK
    * **TODO**: Discuss Oracle roadmap on Java
    * **TODO**: Discuss tradeoffs between LTS version and newer JDK versions
* [jEnv](https://www.jenv.be/) or equivalent

---

## Keep build current

### OpenJDK

* **TODO**: Discuss Oracle LTS, and role of OpenJDK
* **TODO**: Discuss [AdoptOpenJDK](https://adoptopenjdk.net/)
* Avoid Java 8 or older: No longer supported, etc.
* Java 11 is "old" (this is a relative term) but solid and supported
* Java 15 is the current LTS version

These demonstration projects use Java 11 as tooling has not yet caught up to
the recently released Java 15.

### Keep plugins and dependencies up-to-date

* [Gradle](https://github.com/ben-manes/gradle-versions-plugin)
* [Maven](https://www.mojohaus.org/versions-maven-plugin/)
* Team agreement on releases only, or non-release dependencies

---

## Generate code

Yada, yada, yada.

(Mention Kotlin and other more modern languages which obviate much of this
need.)

### Lombok

* [Lombok](https://projectlombok.org/)
* `@Generated` for lying to JaCoCo

#### Lombok configuration

[Configure Lombok](https://projectlombok.org/features/configuration) in
`src/lombok.config` rather than the project root or a separate `config`
directory. At a minimum:

```
config.stopBubbling = true
lombok.addLombokGeneratedAnnotation = true
lombok.anyConstructor.addConstructorProperties = true
lombok.extern.findbugs.addSuppressFBWarnings = true
```

Lines:

1. `stopBubbling` tells Lombok that there are no more configuration files
   higher in the directory tree
2. `addLombokGeneratedAnnotation` helps JaCoCo ignore code generated by Lombok
3. `addConstructorProperties` helps JSON/XML frameworks such as Jackson
   (this may not be relevant for your project, but is generally harmless, so
   the benefit comes for free)
4. `addSuppressFBWarnings` helps SpotBugs ignore code generated by Lombok

---

## Use linting

"Linting" is static code analysis with an eye towards style and dodgy code
constructs. The term
[derives from early UNIX](https://en.wikipedia.org/wiki/Lint_(software)).

Linting for modern languages is simple: the compiler complains on your behalf.
This is the case, for example, Golang. Having common team agreements on style
and formatting is a boon for avoiding
[bikeshedding](https://en.wikipedia.org/wiki/Law_of_triviality), and aids in:

* Reading a code base, relying on a similar style throughout
* Code reviews, focusing on substantive over superficial changes
* Merging code, avoiding trivial or irrelevant conflicts

Code style and formatting are _entirely_ a matter of team discussion and
agreement. In Java, there is no recommended style, and `javac` is good at
parsing almost anything thrown at it. However, humans reading code are not as
well-equipped.

**Pick a team style, stick to it, and _enforce_ it with tooling.**

With Java, one needs to rely on external tooling for linting. The most popular
choice is:

* [CheckStyle](https://checkstyle.sourceforge.io/)
    * [Gradle plugin](https://docs.gradle.org/current/userguide/checkstyle_plugin.html)
    * [Maven plugin](https://maven.apache.org/plugins/maven-checkstyle-plugin/index.html)

However, unlike built-in solutions, Checkstyle will not auto-format code for
you.

The demonstration projects assume [checkstyle configuration] is located in
[`config/checkstyle/checkstyle.xml`](./config/checkstyle/checkstyle.xml).  
This is the default location for Gradle, and configured in Maven.

The Checkstyle configuration sample is stock
[`sun_checks.xml`](https://github.com/checkstyle/checkstyle/blob/master/src/main/resources/sun_checks.xml)
with the addition of support for `@SuppressWarnings(checkstyle:...)`.

---

## Use static code analysis

* [SpotBugs](https://spotbugs.github.io/)

---

## The test pyramid

* [_TestPyramid_](https://martinfowler.com/bliki/TestPyramid.html)
* [_The Practical Test
  Pyramid_](https://martinfowler.com/articles/practical-test-pyramid.html)

---

## Leverage unit testing and coverage

* [JaCoCo](https://www.jacoco.org/jacoco/)
* "Ratchet" to fail build when coverage drops
* Fluent assertions -- lots of options in this area,
  [AssertJ](https://assertj.github.io/doc/) solid choice

---

## Use mutation testing

* [PITest](http://pitest.org/)

---

## Use integration testing

* [TestContainers](https://www.testcontainers.org/)

---

## Use contract testing when appropriate

---

## Shift security left

* [Find Security Bugs](https://find-sec-bugs.github.io/) &mdash; a plugin for
  SpotBugs
* [DependencyCheck](https://owasp.org/www-project-dependency-check/)

---

## TODOs

* Move to JDK 15 from 11 when tooling is ready
* Example _Integration Test_
* Discuss spotless plugin for Gradle and Maven -- update section on linting
