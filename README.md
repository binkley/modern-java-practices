<a href="LICENSE.md">
<img src="https://unlicense.org/pd-icon.png" alt="Public Domain" align="right"/>
</a>

# Modern Java Build Practices

[![build](https://github.com/binkley/modern-java-practices/workflows/build/badge.svg)](https://github.com/binkley/modern-java-practices/actions)
[![issues](https://img.shields.io/github/issues/binkley/modern-java-practices.svg)](https://github.com/binkley/modern-java-practices/issues/)
[![Public Domain](https://img.shields.io/badge/license-Public%20Domain-blue.svg)](http://unlicense.org/)

**Modern Java Build Practices** is an article on bootstrapping modern
JVM-based projects with sample builds for Gradle and Maven, and focus on
_hygiene_ and best practices.  **TODO**: Link to article when it is published.

**NB** &mdash; This is a "work in progress". Much of it is bullet points,
intending to flesh these out to full-written sections.

**NB** &mdash; This sample project has both Gradle and Maven builds. Most
IDEs, _eg_, IntelliJ, may have issues with more than one way to build the
code; [command-line](#project-setup)
and [Batect](#keep-local-consistent-with-ci) usage work as expected.

**NB** &mdash; The sample Gradle and Maven build scripts often specify
specific versions of the tooling, separate from the plugin versions. This is
intentional. You should be able to update a tooling version to the latest even
when the plugin has not yet caught up.

Try out the builds:

```
$ ./gradlew build
# Output ommitted
$ ./mvnw verify
# Output omitted
```

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

### Tips

* Gradle uses advanced terminal control, so you cannot always see what is
  happening. To view Gradle steps plainly when debugging your build, use:
  ```
  $ ./gradlew <your tasks> | cat
  ```
  or save the output to a file:
  ```
  $ ./gradlew <your tasks> | tee -o some-file
  ```

---

## Keep local consistent with CI

### Setup CI

When using GitHub, a simple starting point is
[`ci.yml`](./.github/workflows/ci.yml).  (GitLabs is similar, but as this
project is hosted in GitHub, there is not a simple means to demonstrate CI at
GitLabs). This sample GitHub workflow builds with Gradle, and then with Maven.

### Setup local CI

[Batect](https://batect.dev/) is a cool tool from Charles Korn. With some
setup, it runs your build in a "CI-like" local environment via Docker. This is
one of your first lines of defence against "it runs on my box".

See [`batect.yml`](./batect.yml) to configure. For this project, there are
demonstration targets:

```
$ ./batect build-gradle
# output ommitted
$ ./batect build-maven
# output ommitted
```

**TODO:** Do these points go elsewhere?

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
* Team agreement on releases only, or if non-release plugins and dependencies
  are acceptable

Example use which shows outdated plugins and dependencies, but does not modify
any project files:

```
$ ./gradlew dependencyUpdates
# output ommitted
$ ./mvnw versions:diplay-property-updates
# output ommitted
```

In this project, version numbers for Gradle are kept in
[`gradle.properties`](./gradle.properties), and for Maven in
[the POM](./pom.xml).

#### More on Gradle version numbers

Your simplest approach to Gradle is to keep everything in `build.gradle`.  
Even this unfortunately still requires a `settings.gradle` to define the
project artifact name, and leaves duplicate version numbers for related
dependencies scattered through `build.gradle`.

Another approach is to rely on a Gradle plugin such as that from Spring Boot
to manage dependecies for you. This unfortunately does not help with plugins
at all, nor with dependencies that Spring Boot does not know about.

This project uses a 3-file solution:

* [`gradle.properties`](./gradle.properties) is the sole source of truth for
  version numbers, both plugins and dependencies
* [`settings.gradle`](./settings.gradle) configures plugin versions using the
  properties
* [`build.gradle`](./build.gradle) uses plugins without needing version
  numbers, and dependencies refer to their version symbolically

So to adjust a version, edit `gradle.properties`. To see this approach in
action for dependencies, try:

```
$ grep junitVersion gradle.properties setttings.gradle build.gradle
gradle.properties:junitVersion=5.7.0
build.gradle:    testImplementation "org.junit.jupiter:junit-jupiter:$junitVersion"
build.gradle:    testImplementation "org.junit.jupiter:junit-jupiter-params:$junitVersion"
```

With Gradle, there really is no "right" solution to this problem.

---

## Generate code

When sensible, prefer to generate rather than write code for several reasons:

* [Intelligent laziness is a virtue](http://threevirtues.com/)
* Tools always work, unless they have bugs, and you can fix bugs.  
  Programmers make typos, and fixing typos is a challenge when not obvious;
  worse are [_thinkos_](https://en.wiktionary.org/wiki/thinko).
* Generated code does need code review, only the source input for generation
  needs review, and this is usually shorter and easier to understand
* Generated code is usually ignored by tooling such as linting or code
  coverage (and there are simple workarounds when this is not the case)

Note that many features for which in Java one would use code generation
(_eg_, Lombok's [`@Getter`](https://projectlombok.org/features/GetterSetter)
or [`@ToString`](https://www.projectlombok.org/features/ToString)), can be
built-in language features in other languages such as Kotlin (_eg_,
[properties](https://kotlinlang.org/docs/reference/properties.html)
or [data classes](https://kotlinlang.org/docs/reference/data-classes.html)).

### Lombok

[Lombok](https://projectlombok.org/) is by far the most popular tool in Java
for code generation. It covers many common use cases, and does not have
runtime dependencies. Also, there are plugins for popular IDEs to understand
Lombok's code generation, and tooling integration such as for JaCoCo code
coverage.

#### Leverage Lombok to tweak code coverage

Be sparing in disabling code coverage!  JaCoCo knows about Lombok's
[`@Generated`](https://projectlombok.org/api/lombok/Generated.html), and will
ignore annotated code.

A typical use is for the `main()` method in a framework such as Spring Boot
or [Micronaut](https://micronaut.io/). For a _command-line program_, you will
want to test your `main()`.

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

**TODO**: Implemented for Gradle and Maven: needs discussion

* [PMD](https://pmd.github.io/latest/)
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
* Fluent assertions -- lots of options in this area
    * [AssertJ](https://assertj.github.io/doc/) &mdash; -- solid choice
    * Built assertions from Junit make is difficult for developers to
      distinguish "actual" values from "expected" values. This is a limitation
      from Java as it lacks named parameters

(See [_suggestion : Ignore the generated
code_](https://github.com/hcoles/pitest/issues/347) for a Lombok/PITest
issue.)

To see the coverage report (on passed or failed coverage), open:

* For Gradle, `build/reports/jacoco/test/html/index.html`
* For Maven, `target/site/jacoco/index.html`

---

## Use mutation testing

* [PITest](http://pitest.org/)

To see the mutation report (on passed or failed coverage), open:

* For Gradle, `build/reports/pitest/index.html`
* For Maven, `target/pit-reports/index.html`

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

**TODO**: How to automate the `-C` (checksum) flag in Maven? See
[_Maven Artifact Checksums -
What?_](https://dev.to/khmarbaise/maven-artifact-checksums---what-396j).

---

## TODOs

* Move to JDK 15 from 11 when tooling is ready
* Example _Integration Test_
* Discuss the spotless plugin for Gradle and Maven -- update section on
  linting
