<a href="LICENSE.md">
<img src="https://unlicense.org/pd-icon.png" alt="Public Domain" 
align="right"/>
</a>

# Modern Java/JVM Build Practices

[![build](https://github.com/binkley/modern-java-practices/workflows/build/badge.svg)](https://github.com/binkley/modern-java-practices/actions)
[![issues](https://img.shields.io/github/issues/binkley/modern-java-practices.svg)](https://github.com/binkley/modern-java-practices/issues/)
[![Public Domain](https://img.shields.io/badge/license-Public%20Domain-blue.svg)](http://unlicense.org/)

**Modern Java Build Practices** is an article on modern Java/JVM projects with
sample builds for Gradle and Maven with a focus on _hygiene_ and best build
practices.

Try out the Gradle and Maven builds:

```
$ ./gradlew build
# Output ommitted
$ ./mvnw verify
# Output omitted
```

**NB** &mdash; This is a "work in progress". Some sections are still bullet
points

---

## TOC

* [TODOs](#todos)
* [Introduction](#introduction)
* [Your project](#your-project)
* [Getting started](#getting-started)
* [The JDK](#the-jdk)
* [Use Gradle or Maven](#use-gradle-or-maven)
* [Setup your CI](#setup-your-ci)
* [Keep local consistent with CI](#keep-local-consistent-with-ci)
* [Keep build current](#keep-build-current)
* [Generate code](#generate-code)
* [Use linting](#use-linting)
* [Use static code analysis](#use-static-code-analysis)
* [Shift security left](#shift-security-left)
* [Leverage unit testing and coverage](#leverage-unit-testing-and-coverage)
* [Use mutation testing](#use-mutation-testing)
* [Use integration testing](#use-integration-testing)
* [Going further](#going-further)

---

## TODOs

**TODOs** will go away when this article is done.

* Article link when published
* Move to JDK 15 from 11 when tooling is ready
* GitLabs equivalent for GitHub actions for CI
* How to automate the `-C` (checksum) flag in Maven? See
  [_Maven Artifact Checksums -
  What?_](https://dev.to/khmarbaise/maven-artifact-checksums---what-396j)
* CPD for Gradle -- see https://github.com/aaschmid/gradle-cpd-plugin. CPD
  works for Maven

---

## Introduction

Hi!  I want you to have _awesome builds_ 🟢. If you're on a Java or a JVM
project (Kotlin, Scala, Clojure, JRuby, _et al_), this article is for you.

My purpose is to highlight and provide guidance for building modern Java/JVM
projects with Gradle or Maven. This article focuses on Java, but most points
apply to _any_ JVM language build (linting is an example exception).

This project has simple goals:

* Starter build scripts for Modern Java/JVM builds in Gradle and Maven
* Quick solutions for raising project quality and security in your build,
  including improving existing builds
* Shift _to the left_ (meaning early in the development cycle) as many issues
  as possible, so you get feedback earlier while still having a fast local
  build. Time spent fixing issues locally is better than waiting on CI to
  fail, or worse, for production to fail
* The focus is on Gradle and Maven

I want to help with the question: I am at Day 1 on my project ("day 0" for
those pedants like myself ☺): How do I get a build going that supports real
coding? If I'm at "Day X", how do I improve my build?

For Java/JVM projects, **use Gradle or Maven**. I don't discuss alternative
build tools: the
[data](https://www.jrebel.com/blog/2020-java-technology-report#build-tool)
is overwhelming, and for good reason. Unless you are in a complex monorepo
culture (Google, _etc_), or mandates from above, you need to select a build
tool. However, for projects not using Gradle or Maven, you will still find
improvements for your build herein.

This article aids you to spin up a new _Gradle_ or _Maven_ project directly
for a Java/JVM project. You may
find [Spring Initializr](https://start.spring.io),
[`mn` from Micronaut](https://micronaut.io/), or
[JHipster](https://www.jhipster.tech/) (among many others) more to your
liking: they provide you with starter Gradle or Maven scripts specific for
those frameworks. That's great! I still want to help you improve your build
beyond "getting started". You pick and choose build features to add to your
starter project, whatever makes most sense for your project.

**The goal**: [_Make people awesome_](https://modernagile.org/) (that means
_you_). I've tried a lot of things with Gradle and Maven builds, and want to
share lessons learned with you.

<a id="spring-boot">[*]</a> Calling out Spring Boot. Spring does a
particularly nice job for project setup for that ecosystem, leveraging
benefits of Gradle and Maven. This article will help you improve the starter
builds from Spring.

---

## Your project

There are several helpful steps in setting up a new project, or in
refurbishing an existing project. Some things to strive for in your projects:

* Visitors and new developers get off to a quick start, and can understand
  what the build does (if they are interested)
* Users of your project trust it&mdash;the build does what it says on the
  tin&mdash;, and they feel safe relying on your project
* You don't get peppered with questions that are answered "in the source"
  &mdash;because not everyone wants to read the source, and you'd rather be
  coding than answering questions ☺
* Coding should feel easy. Problems you solve are _real_ problems, not
  nuisances because of tools or plugins. Your code demonstrably provides value
  to others, and the build supports you
* Your code passes all the "smell tests": no simple complaints, and you aren't
  embarrassed when folks look over the code. Hey! You're a professional, and
  it shows. (This is one of my personal fears as a programmer)

## Getting started

To get a project off to a good start, consider these items. Even for existing
projects, you an address these as you go along or while refurbishing an
existing project:

* **Team agreement comes first**. Make sure everyone is onboard and clear on
  what build standards are, and understands&mdash;at least as an
  outline&mdash;what the build does for them
* Provide a *good* `README.md`. This saves you a ton of time in the long run.
  This is your _most important_ step. A good resource is Yegor's
  [_Elegant READMEs_](https://www.yegor256.com/2019/04/23/elegant-readme.html)
    * [Intelligent laziness is a virtue](http://threevirtues.com/). Time
      invested in good documentation pays off
    * A good [`README.md`](./README.md) answers visitors questions, so you
      don't spend time answering trivial questions, and explains/justifies
      your project to others.
      Fight [Conway's Law](https://en.wikipedia.org/wiki/Conway%27s_law)
      with communication!
* Pick **Gradle** or **Maven**, and use only one. This project provides both
  to demonstrate equivalent builds for each.
  See [Use Gradle or Maven](#use-gradle-or-maven) for more discussion
* Use build wrappers committed into the project root. These run Gradle or
  Maven, and coders should always invoke `./gradlew` or `./mvnw` (use shell
  _aliases_ if these grow tiresome to type)
    * Build wrappers are shell scripts to run Gradle or Maven. The wrapper
      takes care of downloading needed tools without getting in the way. New
      contributors and developers can start right away; they do not need to
      install more software
    * For Gradle, use
      [`./gradlew`](https://docs.gradle.org/current/userguide/gradle_wrapper.html)
      (part of Gradle)
    * For Maven, use [`./mvnw`](https://github.com/takari/maven-wrapper)
      (in progress with Apache to bundle as part of Maven)
* Always run CI on push to a shared repository. It's a sad panda when someone
  is excited about their commit, and then the commit breaks the other
  developers
    * In CI, use caches for dependency downloads; this speeds up the feedback
      cycle from CI (see [below](#setup-your-ci))
    * When sensible, move code quality and security checks into local builds
      before changes hit CI (see [below](#setup-local-ci))
* Pick a common code style, and stay consistent; update tooling to complain on
  style violations
    * The team should agree on a common code style, _eg_, SUN, Google, _et al_
    * See [Use linting](#use-linting)

---

## The JDK

For any Java/JVM project, the first decision is _which version of Java
(the JDK)_ to use? Some guidelines:

* Avoid Java 8 and older: These are no longer supported unless one
  buys [paid support contracts from Oracle](https://www.oracle.com/java/technologies/java-se-support-roadmap.html)
* Java 11 is "old" in a relative sense. If your project is critical, you may
  still need a paid support contract from Oracle depending on your
  circumstances.  [_IANAL_](https://en.wikipedia.org/wiki/IANAL)
* Java 15 is the current LTS ("long-term support") version

In this project, you'll see the choice of Java 11. Better would be Java 15,
however, some tooling is still catching up, and it would be poor form for the
demonstrations to break for those not using a current Java release.

In general, you will find that [AdoptOpenJDK](https://adoptopenjdk.net/)
is a go-to choice for obtaining the JDK.

### Managing your Java environment

One of the best tools for managing your Java environment in projects is
[jEnv](https://www.jenv.be/). It supports both "global" (meaning you, the
user) and "project" choices (particular to a directory and its children) in
which JDK installation to use. You may notice the
[`.java-version`](./.java-version) file: this is a per-project file for jEnv
to pick the project Java version.

For those on Windows, you may need to use WSL2 to use jEnv.

---

## Use Gradle or Maven

The choice between Gradle and Maven depends on your team, your broader
ecosystem, and your project needs. In summary:

* Gradle &mdash; written in Goovy or Kotlin; dynamic, imperative, and mutable;
  requires debugging your build on occasion, but less verbose than Maven's
  XML. Use of "parent Gradle" projects is possible but challenging. You can
  locally extend your build script either _inline_ with build code, with
  project plugins, or with plugins from a separate project (perhaps shared
  across project for your team). If interested in custom plugins,
  [read more here](https://docs.gradle.org/current/userguide/custom_plugins.html)
* Maven &mdash; written in XML; declarative and immutable; verbose but
  specific; it either works or not. Use of "parent Maven" projects is simple
  with built-in support. You can locally extend your build with plugins from a
  separate project (perhaps shared across project for your team). If
  interested in custom plugins,
  [read more here](https://maven.apache.org/guides/plugin/guide-java-plugin-development.html)

This article offers **no preference between Gradle or Maven**. You need to
decide.

Projects using Ant **should migrate**. It is true that Ant is
well-maintained (the latest version dates from September 2020). However, you
will spend much effort in providing modern build tooling, and effort in
migrating is repaid by much smaller work in integrating modern tools. Data
point: consider the number of [Stackoverflow](https://stackoverflow.com/)
posts providing Gradle or Maven answers to those for Ant.  **Consider Ant
builds no longer well-supported, and a form of
[Tech Debt](https://www.martinfowler.com/bliki/TechnicalDebt.html).**

Throughout when covering both Gradle and Maven, Gradle will be discussed
first, then Maven. This is no expressing a preference!  It is neutral
alphabetical order.

### Tips

* The sample Gradle and Maven build scripts often specify specific versions of
  the tooling, separate from the plugin versions. This is intentional. You
  should be able to update the latest tool version even when the plugin has
  not yet caught up
* Gradle uses advanced terminal control, so you cannot always see what is
  happening. To view Gradle steps plainly when debugging your build, use:
  ```
  $ ./gradlew <your tasks> | cat
  ```
  or save the output to a file:
  ```
  $ ./gradlew <your tasks> | tee -o some-file
  ```
* Maven colorizes output, but does not use terminal control to overwrite
  output

---

## Setup your CI

Your CI is your "source of truth" for successful builds. Your goal:
_Everyone trusts a "green" CI build is solid_.

When using GitHub, a simple starting point is
[`ci.yml`](./.github/workflows/ci.yml).  (GitLabs is similar, but as this
project is hosted in GitHub, there is not a simple means to demonstrate CI at
GitLabs). This sample GitHub workflow builds with Gradle, and then with Maven.

---

## Keep local consistent with CI

### Setup local CI

[Batect](https://batect.dev/) is a cool tool from Charles Korn. With some
setup, it runs your build in a "CI-like" local environment via Docker. This is
one of your first lines of defence against "it runs on my box".

You would not run Batect in your CI pipeline itself: use GitHub Actions
(or GitLab equivalent). Batect is for your local build.

See [`batect.yml`](./batect.yml) to configure. For this project, there are
demonstration targets:

```
$ ./batect build-gradle
# output ommitted
$ ./batect build-maven
# output ommitted
```

### Tips

* A simple way in CI to disable ASCII control sequences from colorizing or
  Gradle's overwriting of lines (the control sequences can make for
  hard-to-read CI logs) is to use the environment setting:
  ```
  TERM=dumb
  ```
  For example, with Gradle, this will log all the build steps without
  attempting to overwrite earlier steps with later ones

---

## Keep build current

An important part of _build hygiene_ is keeping your build system, plugins,
and dependencies up to date. This might be simply to address bug fixes
(including bugs you weren't aware of), or might be mission-critical security
fixes. The best policy is: _Stay current_. Others will have
found&mdash;reported problems&mdash;, and 3<sup>rd</sup>-parties will have
addressed these. Leverage the power of [_Linus'
Law_](https://en.wikipedia.org/wiki/Linus%27s_law) ("given enough eyeballs,
all bugs are shallow").

### Keep plugins and dependencies up-to-date

* [Gradle](https://github.com/ben-manes/gradle-versions-plugin)
* [Maven](https://www.mojohaus.org/versions-maven-plugin/)
* Team agreement about releases only, or if non-release plugins and
  dependencies are acceptable

Example use which shows outdated plugins and dependencies, but does not modify
any project files:

```
$ ./gradlew dependencyUpdates
# output ommitted
$ ./mvnw versions:display-property-updates
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
to manage dependencies for you. This unfortunately does not help with plugins
at all, nor with dependencies that Spring Boot does not know about.

This project uses a 3-file solution for Gradle versioning:

* [`gradle.properties`](./gradle.properties) is the sole source of truth for
  version numbers, both plugins and dependencies
* [`settings.gradle`](./settings.gradle) configures plugin versions using the
  properties
* [`build.gradle`](./build.gradle) uses plugins without needing version
  numbers, and dependencies refer to their property versions

So to adjust a version, edit `gradle.properties`. To see this approach in
action for dependencies, try:

```
$ grep junitVersion gradle.properties setttings.gradle build.gradle
gradle.properties:junitVersion=5.7.0
build.gradle:    testImplementation "org.junit.jupiter:junit-jupiter:$junitVersion"
build.gradle:    testImplementation "org.junit.jupiter:junit-jupiter-params:$junitVersion"
```

To update Gradle:

```
$ $EDITOR gradle.properties  # Change gradleWrapperVersion property
$ ./gradlew wrapper  # Update
$ ./gradlew wrapper  # Confirm
```

With Gradle, there is no "right" solution for hygienic versioning.

---

## Generate code

When sensible, prefer to generate rather than write code. Here's why:

* [Intelligent laziness is a virtue](http://threevirtues.com/)
* Tools always work, unless they have bugs, and you can fix bugs.  
  Programmers make typos, and fixing typos is a challenge when not obvious.
  Worse are [_thinkos_](https://en.wiktionary.org/wiki/thinko); code
  generation does not "think", so is immune to this problem
* Generated code does need code review, only the source input for generation
  needs review, and this is usually shorter and easier to understand.  
  Your hand-written code needs review
* Generated code is usually ignored by tooling such as linting or code
  coverage (and there are simple workarounds when this is not the case). Your
  hand-written code needs tooling to shift problems left

Note that many features for which in Java one would use code generation
(_eg_, Lombok's [`@Getter`](https://projectlombok.org/features/GetterSetter)
or [`@ToString`](https://www.projectlombok.org/features/ToString)), can be
built-in language features in other languages such as Kotlin (_eg_,
[properties](https://kotlinlang.org/docs/reference/properties.html)
or [data classes](https://kotlinlang.org/docs/reference/data-classes.html)).

### Lombok

[Lombok](https://projectlombok.org/) is by far the most popular tool in Java
for code generation. Lombok is an _annotation processor_, that is, a library (
jar) which cooperates with the Java compiler.  ([_An introductory guide to
annotations and annotation
processors_](https://blog.frankel.ch/introductory-guide-annotation-processor/#handling-annotations-at-compile-time-annotation-processors)
is a good article if you'd like to read more on how annotation processing
works.)

Lombok covers many common use cases, and does not have runtime dependencies,
and there are plugins for popular IDEs to understand Lombok's code generation,
and tooling integration such as provided by JaCoCo code coverage (see
[below](#leverage-lombok-to-tweak-code-coverage)).

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

The demonstration projects assume checkstyle configuration at
[`config/checkstyle/checkstyle.xml`](./config/checkstyle/checkstyle.xml).  
This is the default location for Gradle, and configured for Maven in this
project.

The Checkstyle configuration used is stock
[`sun_checks.xml`](https://github.com/checkstyle/checkstyle/blob/master/src/main/resources/sun_checks.xml)
with the addition of support for `@SuppressWarnings(checkstyle:...)`.

### Tips

* If you use Google Java coding conventions, consider
  [Spotless](https://github.com/diffplug/spotless) which can autoformat your
  code.

---

## Use static code analysis

Important in your build is _static code analysis_. This is analysis of your
source and compiled bytecode which finds known
[issues](https://spotbugs.readthedocs.io/en/latest/bugDescriptions.html)
ranging among other things:

* Idioms that your team finds poor or hard to read
* Dangerous anti-patterns (_eg_, missing `null` checks)
* Insecure code (see [Shift security left](#shift-security-left))
* Outdated code use (_eg_, Java 5 patterns better expressed with Java 11
  improvements)

The demonstration builds use these to help you:

* [PMD](https://pmd.github.io/latest/)
* [SpotBugs](https://spotbugs.github.io/)

---

## Shift security left

* [Find Security Bugs](https://find-sec-bugs.github.io/) &mdash; a plugin for
  SpotBugs
* [DependencyCheck](https://owasp.org/www-project-dependency-check/)

Use checksums and signatures: verify what your project downloads!  When you
publish for consumption by others: provide MD5 (checksum) files in your
upload!  Be a good netizen.

* For Gradle, read more at [_Verifying
  dependencies_](https://docs.gradle.org/current/userguide/dependency_verification.html)
* For Maven, _always_ run with the `--strict-checksums` (or `-C`) flag. See
  [_Maven Artifact Checksums -
  What?_](https://dev.to/khmarbaise/maven-artifact-checksums---what-396j) for
  more information. This is easy to forget about at the local command line. An
  alias helps:
  ```
  $ alias mvnw=`./mvnw --strict-checksums`
  ```
  However, for CI, this is easy!  The [Batect configuration](./batect.yml)
  on this project says:
  ```yaml
  build-maven:
    description: Build and test with Maven
    run:
      container: build-env
      command: ./mvnw --strict-checksums clean verify
  ```
  and the GitHub action says:
  ```yaml
  - name: Build and test with Maven
    run: ./mvnw --strict-checksums verify
  ```
  ([Batect](#keep-local-consistent-with-ci)
  and [GitHub Actions](#setup-your-ci) are discussed both above.)

### Tips

* With GitHub actions, consider adding a tool such
  as [Dependabot](https://dependabot.com/)
* Unfortunately, the Gradle ecosystem is not a mature as the Maven one in this
  regard. For example, if you enable checksum verifications in Gradle, many or
  most of your plugin and dependency downloads fail

---

## Leverage unit testing and coverage

* [JaCoCo](https://www.jacoco.org/jacoco/)
* "Ratchet" to fail build when coverage drops
* Fluent assertions -- lots of options in this area
    * [AssertJ](https://assertj.github.io/doc/) &mdash; -- solid choice
    * Built assertions from Junit make is difficult for developers to
      distinguish "actual" values from "expected" values. This is a limitation
      from Java as it lacks named parameters

Unit testing and code coverage are foundations for code quality. Your build
should help you with these as much as possible.

Plugins:

* For Gradle this is part of the "java" plugin
* For Maven, use
  the [Maven Surefire Plugin](https://maven.apache.org/surefire/maven-surefire-plugin/)

(See [_suggestion : Ignore the generated
code_](https://github.com/hcoles/pitest/issues/347) for a Lombok/PITest
issue.)

To see the coverage report (on passed or failed coverage), open:

* For Gradle, `build/reports/jacoco/test/html/index.html`
* For Maven, `target/site/jacoco/index.html`

### Tips

* See [discussion on Lombok](#leverage-lombok-to-tweak-code-coverage) how to _
  sparingly_ leverage the `@Generated` annotation for marking code that JaCoCo
  should ignore
* Discuss with your team the concept of a "coverage ratchet". This means, once
  a baseline coverage percentage is agreed to, the build configuration will
  only raise this value, not lower it. This is fairly simple to do by
  periodically examining the JaCoCo report, and raising the build coverage
  percentage over time to match improvements in the report
* Unfortunately neither Gradle's nor Maven's JaCoCo plugin will fail your
  build when coverage _rises_!  This would be helpful for supporting the
  coverage ratchet

---

## Use mutation testing

Unit testing is great for testing your production code. But have you thought
about testing your unit tests? What that means is, how are you sure your tests
really check what you meant them to? Fortunately, there is an automated way to
do just that, no code from you required, only some build configuration.

Mutation testing is a simple concept: Go "break" some production code, and see
if any unit tests fail. Production bytecode is changed during the build&mdash;
for example, an `if (x)` is changed to `if (!x)`&mdash;, and the unit tests
run. With good code coverage, there should now be a failing unit test.

The best option for Java/JVM mutation testing is [PITest](http://pitest.org/).
It is under active development, does some rather clever things with the
production bytecode, and has Gradle and Maven plugins. The main drawback is
that PITest is _noisy_, so there will be more build output than you might
expect.

After running a build using PITest, to see the mutation report (on passed or
failed mutation coverage), open:

* For Gradle, `build/reports/pitest/index.html`
* For Maven, `target/pit-reports/index.html`

### Tips

* Without further configuration, PITest defaults to mutating classes using
  your _project group_ as the package base. Example: Set the _project group_
  to "demo" for either Gradle or Maven if your classes are underneath the
  "demo.*" package namespace, otherwise PITest may complain that there are no
  classes to mutate, or no unit tests to run

---

## Use integration testing

Here the project says "integration testing". Your team may call it by another
name. This means bringing up your application, possibly with
[fakes, stubs, mocks, spies, dummies, or doubles](http://xunitpatterns.com/Mocks,%20Fakes,%20Stubs%20and%20Dummies.html)
for external dependencies (databases, other services, _etc_), and running
tests against high-level functionality, but _not_ starting up external
dependencies themselves (_ie_, Docker, or manual comman-line steps).  
Think of CI: what are called here "integration tests" are those which do
_not_ need your CI to provide other services.

An example is testing `STDOUT` and `STDERR` for a command-line application.
(If you are in Spring Framework/Boot-land, use controller tests for your REST
services.)

Unlike `src/main/java` and `src/test/java`, there is no generally agreed
convention for where to put integration tests. This project keeps all tests
regardless of type in `src/test/java` for simplicity of presentation, naming
integration tests with "*IT.java". A more sophisticated approach may make
sense for your project

If you'd like to keep your integration tests in a separate source root from
unit tests, consider these plugins:

* For Gradle, use [_Gradle TestSets
  Plugin_](https://github.com/unbroken-dome/gradle-testsets-plugin)
* For Maven, use
  the [Maven Failsafe Plugin](https://maven.apache.org/failsafe/maven-failsafe-plugin/)

### Tips

* Failsafe shares the version number with Surefire. This project uses a
  shared `maven-testing-plugins.version` property
* Baeldung
  has [a good introduction article](https://www.baeldung.com/maven-failsafe-plugin)
  on Maven Failsafe
* There are alternatives to the "test pyramid" perspective. Consider
  [swiss cheese](https://blog.korny.info/2020/01/20/the-swiss-cheese-model-and-acceptance-tests.html)
  if it makes more sense for your project. The build techniques still apply

---

## Going further

Can you do more to improve your build, and shift problems left (before they
hit CI)? Of course!  Below are some topics to discuss with your team about
making them part of the local build.

### The Test Pyramid

**TODO**: Small, right-side, floating image of the test pyramid

What is the "Test Pyramid"? This is an important conceptual framework for
validating your project at multiple levels of interaction. Canonical resources
describing the test pyramid include:

* [_TestPyramid_](https://martinfowler.com/bliki/TestPyramid.html)
* [_The Practical Test
  Pyramid_](https://martinfowler.com/articles/practical-test-pyramid.html)

As you move your testing "to the left" (helping local builds cover more
concerns), you'll want to enhance your build with more testing at different
levels of interaction. These are not covered in this article, so research is
needed.

**NB** &mdash; What this article calls
["integration tests"](#use-integration-testing) may have a different name for
your team.

### Use automated live testing when appropriate

"Live testing" here means spinning up a database or other remote service for
local tests, and not
using [fakes, stubs, mocks, spies, dummies, or doubles](http://xunitpatterns.com/Mocks,%20Fakes,%20Stubs%20and%20Dummies.html)
. In these tests, your project calls on _real_ external dependencies, albeit
dependencies spun up locally rather than in production or another environment.

This is a complex topic. Some potentially useful resources to pull into your
build:

* [Flyway](https://flywaydb.org/) &mdash; Version your schema in production,
  and version your test data
* [LocalStack](https://github.com/localstack/localstack) &mdash; Local testing
  for AWS services
* [TestContainers](https://www.testcontainers.org/) &mdash; Local Docker for
  real database instances, or any Docker-provided service

### Use contract testing when appropriate

Depending on your program, you may want additional testing specific to
circumstances. For example, with REST services and Spring Cloud, consider:

* [_Consumer Driven Contracts_](https://spring.io/guides/gs/contract-rest/)

There are many options in this area. Find the choices which work best for you
and your project.  
