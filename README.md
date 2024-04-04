<a href="./LICENSE">
<img src="./images/public-domain.svg" alt="Public Domain"
align="right" width="20%" height="auto"/>
</a>

# Modern Java/JVM Build Practices

[![Gradle build](https://github.com/binkley/modern-java-practices/actions/workflows/ci-earthly-gradle.yml/badge.svg)](https://github.com/binkley/modern-java-practices/actions)
[![Maven build](https://github.com/binkley/modern-java-practices/actions/workflows/ci-earthly-maven.yml/badge.svg)](https://github.com/binkley/modern-java-practices/actions)
[![pull requests](https://img.shields.io/github/issues-pr/binkley/modern-java-practices.svg)](https://github.com/binkley/modern-java-practices/pulls)
[![issues](https://img.shields.io/github/issues/binkley/modern-java-practices.svg)](https://github.com/binkley/modern-java-practices/issues/)
[![vulnerabilities](https://snyk.io/test/github/binkley/modern-java-practices/badge.svg)](https://snyk.io/test/github/binkley/modern-java-practices)
[![license](https://img.shields.io/badge/license-Public%20Domain-blue.svg)](http://unlicense.org/)

**Modern Java/JVM Build Practices** is an article-as-repo on building modern
Java/JVM projects using
[Gradle](https://docs.gradle.org/current/userguide/userguide.html) and
[Maven](https://maven.apache.org/what-is-maven.html), and a _starter project_
in Java (the advice works for non-Java languages on the JVM though details may
change).

> [!NOTE]
> I am in progress of moving sections of the `README.md` to individual pages
> in [the wiki](https://github.com/binkley/modern-java-practices/wiki), and
> make it easier for bringing advice up to date, and adding new approaches.
> Please forgive the shambles while this is in progress.

Regardless of what language(s) or build tool(s) you choose, and you
should treat your build and your pipeline as worthy of your attention just as
you would your project source code:
_If it doesn't build right for customers as it does for developers, you have
something to think about._

I'm showing you practices and tools that help you make your build and pipeline
to production as _first-class_ the same as your own source code.
An example of this philosophy for a non-Java language is [Clojure](https://www.clojure.org/guides/tools_build#_builds_are_programs).

Your focus, and the focus of this article, is _best build practices_ and
_project hygiene_, and helping you have local work that is identical in
production.
This project is _agnostic_ between Gradle and Maven: discussion in each section
covers both tools (alphabetical order, Gradle before Maven).
See [_My Final Take on Gradle (vs.
Maven)_](https://blog.frankel.ch/final-take-gradle/) for an opinionated view
(not my own).

This is not a JVM starter for only Java:
I use it for starting my Kotlin projects, and substitute complilation and code
quality plugins.
Any language on the JVM can find practices and tips.

> [!NOTE]
> _Scala_ and _Clojure_ have their own prefered build tools not covered here;
> however, the advice and examples for your **build pipeline** are intended to
> be just as helpful for those JVM languages.
> Groovy and Kotlin can use the examples directly (they both tend towards the
> _Gradle_ option on build tools).

As a _guide_, this project focuses on:

* A quick starter for JVM projects using Gradle or Maven.
  [Fork](https://github.com/binkley/modern-java-practices/fork) me,
  [clone](https://github.com/binkley/modern-java-practices.git) me, copy/paste
  freely!
  I am [_Public Domain_](http://unlicense.org/)
* Discuss&mdash;and illustrate (through code)&mdash;sensible default practices;
  highlight good build tools and plugins
* Document pitfalls that turned up.
  Some were easy to address after Internet search; some were challenging
  (see "Tips" sections)
* Do not be an "all-in-one" solution. You know your circumstances best.
  I hope this project helps you discover build improvements you love.
  Please share with others through
  [issues](https://github.com/binkley/modern-java-practices/issues) or
  [PRs](https://github.com/binkley/modern-java-practices/pulls)

### Two recurring themes

* _Shift problems left_ &mdash; Find issues earlier in your build&mdash;before
  you see them in production
* _Make developer life easier_ &mdash; Automate build tasks often done by
  hand: get your build to complain (_fail_) locally before sharing with your
  team, or fail in CI before deployment

### What is a _Starter_?

A project starter has several goals:
- Help a new project get up and running with minimal fuss.
- Show examples of _best practices_.
- Explain the _why_ for choices, and help you pick what makes most sense for
  your project.

This starter project is focused on _build_:
- Easy on-ramp for new folks to try out your project for themselves
- Support new contributors to your project that they become productive quickly
- Support current contributors in the build, get out of their way, and make
  everyday things easy

This starter project has minimal dependencies.
The focus is on Gradle and Maven plugins and configuration so that you and
contributors can focus on the code, not on setting up the build.

### Summing up

- _I'm not a great programmer; I'm just a good programmer with great habits._
  &mdash;
  [Kent Beck](https://www.goodreads.com/quotes/532211-i-m-not-a-great-programmer-i-m-just-a-good-programmer)
- _Make it work, make it right, make it fast_
  &mdash; [C2 Wiki](http://wiki.c2.com/?MakeItWorkMakeItRightMakeItFast)

> [!NOTE]
> **NB** &mdash; This is a _living document_.
> The project is frequently updated to pick up new dependency or plugin 
> versions, and improved practices; the `README.md` and
> [wiki](https://github.com/binkley/modern-java-practices/wiki) update
> recommendations.
> This is part of what _great habits_ looks like: you do not just show love
> for your developers and users, but enable them to feed back into projects
> and help others.
> See [_Reusing this
> project_](https://github.com/binkley/modern-java-practices/wiki/Reusing-this-project)
> for tips on pulling in updates.

(Credit to Yegor Bugayenko for [_Elegant
READMEs_](https://www.yegor256.com/2019/04/23/elegant-readme.html).)

---

<a title="Try it">
<img src="./images/try.png" alt="Run from a local script"
align="right" width="20%" height="auto"/>
</a>

## Try it

You should "kick the tires" and get a feel for what parts of this project
you'd like to pull into your own projects and builds.
You run across lots of projects:
Let's make this one helpful for you.

After cloning or forking this project to your machine, try out the local build
that makes sense for you:

```shell
$ ./gradlew build  # Local-only build
$ earthly +build-with-gradle  # CI build with Earthly
$ ./mvnw verify  # Local-only build
$ earthly +build-with-maven  # CI build with Earthly
```

Notice that you can run the build purely localy, or _in a container_?

I want to convince you that running your builds in a container fixes the "it
worked on my machine" problem, and show you how to pick up improvements for
your build that helps you and others be _awesome_.

See what the starter "run" program does:

```shell
$ ./run-with-gradle.sh
$ ./run-with-maven.sh
```

A "starter" program is the simplest of all possible ["smoke
tests"](https://en.wikipedia.org/wiki/Smoke_testing_(software)), meaning,
the minimal things _just work_, and when you check other things, maybe smoke
drifts from your computer as circuits burn out[^1].

[^1]: No, I'm just kidding.
Amazon or Microsoft or Google cloud would have quite different problems than
"white smoke" from computers[^2].

[^2]: Actually, this really happened me in a data center before the cloud.

---

<a title="Changes">
<img src="./images/changes.png" alt="Changes"
align="right" width="20%" height="auto"/>
</a>

## Recent significant changes

- **IN PROGRESS**: Move sections from `README.md` to the GitHub wiki.
  This is for breaking up an overlong (11k words) README into digestible
  sections.
- Batect: Remove support for Batect as the author has archived that project.
  Please use _Earthly_ for local containerized builds.
  I'll be researching other options, and updating to show those and examples.
  Advice remains the same: Run your local build in a container for
  reproducibility, and have CI do the same to exactly repeat your local
  builds.
- This project uses JDK 21.
  Here is [the previous commit using JDK 17](https://github.com/binkley/modern-java-practices/commit/039f6f45fade51da0c548bf5d61b8013423ab8b9)
- Gradle: build with Gradle 8.x.
- Gradle: remove use of `testsets` plugin for integration testing in favor of
  native Gradle.
  This is in support of Gradle 8 and may be helpful in seeing changes you need
  for Gradle 8 support.

---

<a title="Table of Contents">
<img src="./images/table-of-contents.png" alt="Table of Contents"
align="right" width="20%" height="auto"/>
</a>

## Table Of Contents

* [Try it](#try-it)
* [Recent significant changes](#recent-significant-changes)
* [Introduction](https://github.com/binkley/modern-java-practices/wiki#introduction)
* [Reusing this project](https://github.com/binkley/modern-java-practices/wiki/Reusing-this-project)
* [Contributing](#contributing)
* [You and your project](https://github.com/binkley/modern-java-practices/wiki/You-and-your-project)
* [Commits](https://github.com/binkley/modern-java-practices/wiki/Commits)
* [Getting your project
  started](https://github.com/binkley/modern-java-practices/wiki/Getting-your-project-started)
* [The JDK](https://github.com/binkley/modern-java-practices/wiki/The-jdk)
* [Use Gradle or
  Maven](https://github.com/binkley/modern-java-practices/wiki/Use-gradle-or-maven)
* [Setup your
  CI](https://github.com/binkley/modern-java-practices/wiki/Setup-your-ci)
* [Keep local consistent with CI](https://github.com/binkley/modern-java-practices/wiki/Keep-local-consistent-with-CI)
* [Maintain your
  build](https://github.com/binkley/modern-java-practices/wiki/Maintain-your-build)
* [Choose your code style](https://github.com/binkley/modern-java-practices/wiki/Choose-your-code-style)
* [Generate
  code](https://github.com/binkley/modern-java-practices/wiki/Generate-code)
* [Leverage the compiler](https://github.com/binkley/modern-java-practices/wiki/Leverage-the-compiler)
* [Use
  linting](https://github.com/binkley/modern-java-practices/wiki/Use-linting)
* [Use static code analysis](https://github.com/binkley/modern-java-practices/wiki/Use-static-code-analysis)
* [Shift security left](https://github.com/binkley/modern-java-practices/wiki/Shift-security-left)
* [Leverage unit testing and coverage](#leverage-unit-testing-and-coverage)
* [Use mutation testing](https://github.com/binkley/modern-java-practices/wiki/Use-mutation-testing)
* [Use integration testing](https://github.com/binkley/modern-java-practices/wiki/Use-integration-testing)
* [Debugging](https://github.com/binkley/modern-java-practices/wiki/Debugging)
* [Samples](#samples)
* [Going
  further](https://github.com/binkley/modern-java-practices/wiki/Going-further)
* [Problems](#problems)
* [Credits](#credits)

---

<a href="https://modernagile.org/" title="Modern Agile">
<img src="./images/modern-agile-wheel-english.png" alt="Modern Agile"
align="right" width="20%" height="auto"/>
</a>

## Introduction

See
[_Introduction_](https://github.com/binkley/modern-java-practices/wiki#introduction)
in the wiki.

---

<a href="https://github.com/binkley/modern-java-practices/fork" title="Reuse">
<img src="./images/reuse.png" alt="Reuse"
align="right" width="20%" height="auto"/>
</a>

## Reusing this project

See
[_Reusing this project_](https://github.com/binkley/modern-java-practices/wiki/Reusing-this-project)
in the wiki.

---

<img src="./images/Wikibooks-contribute-icon.svg" alt="Contributing"
align="right" width="20%" height="auto"/>
</a>

## Contributing

See [`CONTRIBUTING.md`](./CONTRIBUTING.md).
Please [file issues](https://github.com/binkley/modern-java-practices/issues),
or contribute [pull
requests](https://github.com/binkley/modern-java-practices/pulls)!
I'd love a conversation with you.

---

## Commits

See [_Commits_](https://github.com/binkley/modern-java-practices/wiki/Commits)
in the wiki.

---

<!-- TODO: Should this section be moved or removed? It is awkward here -->
## You and your project

See [_You and your
project_](https://github.com/binkley/modern-java-practices/wiki/You-and-your-project)
in the wiki.

---

## Getting your project started

See [_Getting your project
started_](https://github.com/binkley/modern-java-practices/wiki/Getting-your-project-started)
in the wiki.

---

<a href="https://adoptium.net/" title="Adoptium">
<img src="./images/adoptium.png" alt="Adoptium"
align="right" width="20%" height="auto"/>
</a>

## The JDK

See [_The JDK_](https://github.com/binkley/modern-java-practices/wiki/The-jdk)
in the wiki.

---

<!--- TODO: better formating for images vs text -->
<a href="https://maven.apache.org/" title="Maven">
<img src="./images/maven.png" alt="Maven"
align="right" width="15%" height="auto"/></a>
<a href="https://gradle.org/" title="Gradle">
<img src="./images/gradle.png" alt="Gradle"
align="right" width="15%" height="auto"/></a> 

## Use Gradle or Maven

See [_Use Gradle or Maven_](https://github.com/binkley/modern-java-practices/wiki/Use-gradle-or-maven)
in the wiki.

---

<a href="http://www.ambysoft.com/essays/whyAgileWorksFeedback.html"
title="Why Agile Software Development Techniques Work: Improved Feedback">
<img src="./images/bug-costs.jpg" alt="Length of Feedback Cycle"
align="right" width="20%" height="auto"/>
</a>

## Setup your CI

See [_Setup your
CI_](https://github.com/binkley/modern-java-practices/wiki/Setup-your-ci)
in the wiki.

---

## Keep local consistent with CI

See [_Keep local consistent with
CI_](https://github.com/binkley/modern-java-practices/wiki/Getting-your-project-started)
in the wiki.

---

<img src="./images/maintain-build.jpg" alt="Maintain build"
align="right" width="20%" height="auto"/>

## Maintain your build

See [_Maintain your
build_](https://github.com/binkley/modern-java-practices/wiki/Maintain-your-build)
in the wiki.

---

## Choose your code style

See [_Choose your code
style_](https://github.com/binkley/modern-java-practices/wiki/Choose-your-code-style)
in the wiki.

---

<img src="./images/coffee-grinder.png" alt="Coffee grinder" align="right"
width="20%" height="auto"/>

## Generate code

See [_Generate
code_](https://github.com/binkley/modern-java-practices/wiki/Generate-code)
in the wiki.

---

<img src="./images/gear.png" alt="Gear"
align="right" width="20%" height="auto"/>

## Leverage the compiler

See [_Leverage the
compiler_](https://github.com/binkley/modern-java-practices/wiki/Leverage-the-compiler)
in the wiki.

---

## Use linting

See [_Use
linting_](https://github.com/binkley/modern-java-practices/wiki/Use-linting)
in the wiki.

---

## Use static code analysis

See [_Use static code
analysis_](https://github.com/binkley/modern-java-practices/wiki/Use-static-code-analysis)
in the wiki.

---

## Shift security left

See [_Shift security
left_](https://github.com/binkley/modern-java-practices/wiki/Shift-security-left)
in the wiki.

---

## Leverage unit testing and coverage

* [JaCoCo](https://www.jacoco.org/jacoco/)
* Use the "ratchet" pattern to fail the build when coverage drops.
  Robert Greiner talks more on this in [_Continuous Code Improvement Using 
  Ratcheting_](https://robertgreiner.com/continuous-code-improvement-using-ratcheting/)
  This follows the agile ["Boy Scout"
  principle](https://dzone.com/articles/the-boy-scout-software-development-principle)
* Fluent assertions &mdash; lots of options in this area
    * [AssertJ](https://assertj.github.io/doc/) &mdash; solid choice
    * Built assertions from Junit makes is difficult for developers to
      distinguish "actual" values from "expected" values. This is a limitation
      from Java as it lacks named parameters.
      Other frameworks compatible with JUnit provide more fluent assertions such
      as AssertJ.
      Different choices make sense depending on your source language

Unit testing and code coverage are foundations for code quality.
Your build should help you with these as much as possible. 100% coverage may
seem absurd;
however, levels of coverage like this come with unexpected benefits such as
finding dead code in your project or helping refactoring to be simple.
An example: with high coverage (say 95%+, your experience will vary)
simplifying your covered code may lower your coverage as uncovered code becomes
more prominent in the total ratio.

Setup for needed plugins:

* For Gradle use the `java` plugin
* For Maven, use more recent versions of the
  [Maven Surefire Plugin](https://maven.apache.org/surefire/maven-surefire-plugin/)

(See [_suggestion : Ignore the generated
code_](https://github.com/hcoles/pitest/issues/347) for a Lombok/PITest issue.)

To see the coverage report (on passed or failed coverage), open:

* For Gradle, `build/reports/jacoco/test/html/index.html`
* For Maven, `target/site/jacoco/index.html`

This project also provides the coverage report as part of Maven's project
report.

The [`coverage`](./coverage.sh) script is helpful for checking your current
coverage state: try `./coverage -f all`.
Current limitations:
- Maven builds only
- Single module builds only

### Tips

* With Maven, _do use_ the available BOM (bill of materials) for JUnit.
  An example `pom.xml` block is:
  ```xml
    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.junit</groupId>
                <artifactId>junit-bom</artifactId>
                <version>${junit.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>
    ```
  This helps avoid dependency conflicts from other dependencies or plugins
* See [discussion on Lombok](#leverage-lombok-to-tweak-code-coverage) how to
  _sparingly_ leverage the `@Generated` annotation for marking code that JaCoCo
  should ignore
* Discuss with your team the concept of a "coverage ratchet". This means, once a
  baseline coverage percentage is agreed to, the build configuration will only
  raise this value, not lower it. This is fairly simple to do by periodically
  examining the JaCoCo report, and raising the build coverage percentage over
  time to match improvements in the report
* Unfortunately neither Gradle's nor Maven's JaCoCo plugin will fail your build
  when coverage _rises_!  This would be helpful for supporting the coverage
  ratchet
* You may find _mocking_ helpful for injection. The Java community is not of one
  mind on mocking, so use your judgment:
    * [Mockito](https://site.mockito.org/) is the "standard" choice, and is a
      dependency for the sample projects.
      For modern versions of Mockito, please use the `mockito-core` dependency
      rather than `mockito-inline`.
      See `TheFooTest.shouldRedAlertAsStaticMock` for an example.
      Note that this project has updated to Mockito 5.
      See [_v5.0.0_ release
      notes](https://github.com/mockito/mockito/releases/tag/v5.0.0) when
      updating from Mockito 4
    * [PowerMock](https://powermock.github.io/) provides additional features;
      however, Mockito normally covers use cases
    * Other Modern JVM languages &mdash; these languages may prefer different
      mocking libraries, _eg_, [MockK](https://mockk.io/) for Kotlin
    * You might consider complementary libraries to Mockito for specific
      circumstances, _eg_,
      [System Lambda](https://github.com/stefanbirkner/system-lambda)
      for checking STDOUT and STDERR, program exits, and use of system
      properties (_eg_, validate logging), also a dependency for the sample
      projects.  (*NB* &mdash; these are generally not parallelizable tests as
      they alter the state of the JVM. Another is the
      [JUnit Pioneer](https://junit-pioneer.org/) extension pack. If you need
      these, be cautious about using parallel testing features, and avoiding
      [Flaky Tests](https://hackernoon.com/flaky-tests-a-war-that-never-ends-9aa32fdef359))
* To open the report for JaCoCo, build locally and use the
  `<project root>/build/reports/jacoco/test/html/` path.
  The path shown in a Docker build is relative to the interior of the container

---

## Use mutation testing

See [_Use mutation
testing_](https://github.com/binkley/modern-java-practices/wiki/Use-mutation-testing)
in the wiki.

---

## Use integration testing

Here the project says "integration testing". Your team may call it by another
name. This means bringing up your application, possibly with
[fakes, stubs, mocks, spies, dummies, or doubles](http://xunitpatterns.com/Mocks,%20Fakes,%20Stubs%20and%20Dummies.html)
for external dependencies (databases, other services, _etc_), and running tests
against high-level functionality, but _not_ starting up external dependencies
themselves (_ie_, Docker, or manual command-line steps). Think of CI: what are
called here "integration tests" are those which do
_not_ need your CI to provide other services.

An example is testing `STDOUT` and `STDERR` for a command-line application.
(If you are in Spring Framework/Boot-land, use controller tests for your REST
services.)

Unlike `src/main/java` and `src/test/java`, there is no generally agreed
convention for where to put integration tests. This project keeps all tests
regardless of type in `src/test/java` for simplicity of presentation, naming
integration tests with "*IT.java". A more sophisticated approach may make sense
for your project.

If you'd like to keep your integration tests in a separate source root from unit
tests, consider these plugins:

* For Gradle, use [native Gradle to add new test
  sets](https://docs.gradle.org/current/userguide/java_testing.html#sec:configuring_java_integration_tests).
  (Previous versions of this project used the excellent
  [`testsets` plugin](https://github.com/unbroken-dome/gradle-testsets-plugin),
  however, it does not support Gradle 8)
* For Maven, use
  the [Maven Failsafe Plugin](https://maven.apache.org/failsafe/maven-failsafe-plugin/)

**Caution**: This project _duplicates_
[`ApplicationIT.java`](./src/test/java/demo/ApplicationIT.java) and
[`ApplicationTest.java`](./src/integrationTest/java/demo/ApplicationTest.java)
reflecting the split in philosophy between Gradle and Maven for integration
tests. Clearly in a production project, you would have only one of these.

### Tips

* For Maven projects, Apache maintains Failsafe and Surefire plugins as a pair,
  and share the same version numbers.
  This project uses a shared `maven-testing-plugins.version` property
* Baeldung
  has [a good introduction article](https://www.baeldung.com/maven-failsafe-plugin)
  on Maven Failsafe

---

## Going further

Can you do more to improve your build, and shift problems left (before they hit
CI or production)?
Of course!
Below are some topics to discuss with your team about making them part of the
local build.

### The Test Pyramid

<a href="https://martinfowler.com/bliki/TestPyramid.html"
title="TestPyramid">
<img src="./images/test-pyramid.png" alt="The test pyramid"
align="right" width="20%" height="auto"/>
</a>

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

There are alternatives to the "test pyramid" perspective. Consider
[swiss cheese](https://blog.korny.info/2020/01/20/the-swiss-cheese-model-and-acceptance-tests.html)
if it makes more sense for your project.
The build techniques still apply.

**NB** &mdash; What this article calls
["integration tests"](#use-integration-testing) may have a different name for
your team.
You may have "system tests" for example.

### Use automated live testing when appropriate

"Live testing" here means spinning up a database or other remote service for
local tests, and not
using [fakes, stubs, mocks, spies, dummies, or
doubles](http://xunitpatterns.com/Mocks,%20Fakes,%20Stubs%20and%20Dummies.html).
In these tests, your project calls on _real_ external dependencies, albeit
dependencies spun up locally rather than in production or another environment.
These might be call "out of process" tests.

This is a complex topic, and this document is no guide on these. Some
potentially useful resources to pull into your build:

* [Flyway](https://flywaydb.org/) &mdash; Version your schema in production, and
  version your test data
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

### Provide User Journey tests when applicable

Another dimension to consider for local testing: _User Journey_ tests.

* [_Why test the user
  journey?_](https://www.thoughtworks.com/insights/blog/why-test-user-journey)

---

<img src="./images/debugging.png" alt="Debugging in the container"
align="right" width="20%" height="auto"/>

## Debugging

> [!NOTE]
> This section is in progress, and needs instructions and examples for using
> "debug" from container builds using Earthly.

---

<img src="./images/sample.svg" alt="Sample"
align="right" width="20%" height="auto"/>

## Samples

These samples are external projects, are at varying states of maturity, and
are frequently updated (espcially for dependency versions).

### Kotlin

- [KUnits](https://github.com/binkley/kunits) (Maven) is a pleasure project to 
  represent units of measurement in Kotlin
- [Kotlin Rational](https://github.com/binkley/kotlin-rational) (Maven) 
  explores a math library for rationals (fractions) akin to `BigDecimal`
- [Magic Bus](https://github.com/binkley/kotlin-magic-bus) (Gradle) is a 
  library for using messaging patterns within a single application (it talks 
  to itself)

### Spring Boot

- [Spring Boot HATEOAS
  Database](https://github.com/binkley/kotlin-spring-boot-hateoas-database)
  (Maven) looks at Spring Boot features for Open API (Swagger), REST APIs, 
  HATEOAS, GraphQL, Prometheus, _et al_

## Problems

<a href="https://xkcd.com/303/" title="Compiling">
<img src="./images/compiling.png" alt="Compiling"
align="right" width="20%" height="auto"/>
</a>

### Why is my local build slow?

Both Gradle and Maven have tools to track performance time of steps in your
build:

* [Gradle build scans](https://scans.gradle.com/) &mdash; Not limited to
  Enterprise licenses, just build with `./gradlew --scan <tasks>` and follow the
  link in the output.
  <a
  href="https://cdn.jsdelivr.net/gh/binkley/modern-java-practices/docs/profile-run/gradle-profile.html"
  title="A sample Gradle profile for this project" type="text/html">
  See a sample Gradle profile for this project</a>.
* [Maven profiler](https://github.com/jcgay/maven-profiler) &mdash; run
  with `./mvnw -Dprofile <goals>` and open the local link in the output. This
  project includes the setup for [Maven extensions](.mvn/extensions.xml).
  <a
  href="https://cdn.jsdelivr.net/gh/binkley/modern-java-practices/docs/profile-run/maven-profile.html"
  title="A sample Maven profile for this project" type="text/html">
  See a sample Maven profile for this project</a>.

**TODO**: Fix the sample profile links to display as pages, not as raw HTML.

### My local build is still too slow

Congratulations!  You care, and you notice what is happening for your team.  
Local build time is _important_: gone are the days when a multi-hour, or even
30+ minute build, are viewed in most cases as the "cost of doing business".
And "compiling" is rarely any longer where your project takes most local build
time.

Use the Gradle or Maven instructions
in [keep your build fast](#keep-your-build-fast) to profile your build, and spot
where it spends time.

If you find your local build is taking too long, consider testing moving these
parts to CI with the cost to you of issues arising from delayed feedback:

* [Jdeps](#keep-your-build-clean)
* [DependencyCheck](#shift-security-left)
* [Integration tests](#use-integration-testing)
* [PITest](#use-mutation-testing)

_But beware_!  Your local build is now drifting away from CI, so you are pushing
problems off later in your build pipeline. Not everyone pays close attention to
CI failures, that is until something bad happens in production.

*IMPORTANT* &mdash; if you disable tools like the above in the _local_ build,
ensure you retain them in your _CI_ build. Your goal in this case is speed up
the feedback cycle locally while retaining the benefits of automated tooling.
You are making a bet: problems these tools find come up rarely (but can be
catastrophic when they do), so time saved locally repays time lost waiting for
CI to find these problems.

In the Gradle and Maven samples in this repository, _DependencyCheck_ and
_Mutation testing_ are typically the slowest steps in a local build;
_Integration tests_ are fast only because this project has very few (1), and are
samples only.
[YMMV](http://www.catb.org/jargon/html/Y/Your-mileage-may-vary.html)

Every project is different; your team and stakeholders need to judge the value
of quicker feedback to programmers of these concerns, and quicker feedback from
a faster local build. There is no "one size fits all" recommendation.

### It fails in CI, but passes locally

As much as you would like local builds to be identical to CI, this can still
happen for reasons of environment. Examples can include:

- Credentials needed in CI have changed: Update your CI configuration
- Network routing has changed, and CI is in a different subnet from local:
  Talk with your Infrastructure team
- CI includes steps to push successful builds further down the line to other
  environments, and something there went wrong: Talk with your Infrastructure
  team
- Dependencies break in CI: If CI uses an internal dependency repository, check
  in with the maintainers of the repository

## Credits

Many thanks to:

* [Kristoffer Haugsbakk](https://github.com/LemmingAvalanche) &mdash; 
  _Proofreading_
* [Sergei Bukharov](https://github.com/Bukharovsi) &mdash; _PMD enhancements_

All suggestions and ideas welcome!
Please [file an
issue](https://github.com/binkley/modern-java-practices/issues). ☺
