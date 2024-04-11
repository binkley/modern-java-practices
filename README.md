<a href="./LICENSE">
<img src="./images/public-domain.svg" alt="Public Domain"
align="right" width="20%" height="auto"/>
</a>

[**GO SEE THE WIKI!**](https://github.com/binkley/modern-java-practices/wiki)

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
* [Leverage unit testing and coverage](https://github.com/binkley/modern-java-practices/wiki/Leverage-unit-testing-and-coverage)
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

## Reusing this project

See
[_Reusing this project_](https://github.com/binkley/modern-java-practices/wiki/Reusing-this-project)
in the wiki.

---

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

## The JDK

See [_The JDK_](https://github.com/binkley/modern-java-practices/wiki/The-jdk)
in the wiki.

---

## Use Gradle or Maven

See [_Use Gradle or Maven_](https://github.com/binkley/modern-java-practices/wiki/Use-gradle-or-maven)
in the wiki.

---

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

## Generate code

See [_Generate
code_](https://github.com/binkley/modern-java-practices/wiki/Generate-code)
in the wiki.

---

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

See [_Leverage unit testing and
coverage_](https://github.com/binkley/modern-java-practices/wiki/Leverage-unit-testing-and-coverage)
in the wiki.

---

## Use mutation testing

See [_Use mutation
testing_](https://github.com/binkley/modern-java-practices/wiki/Use-mutation-testing)
in the wiki.

---

## Use integration testing

See [_Use integration
testing_](https://github.com/binkley/modern-java-practices/wiki/Use-integration-testing)
in the wiki.

---

## Going further

See [_Going
further_](https://github.com/binkley/modern-java-practices/wiki/Going-further)
in the wiki.

---

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
