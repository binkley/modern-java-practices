<a href="./LICENSE">
<img src="./images/public-domain.svg" alt="Public Domain"
align="right" width="10%" height="auto"/>
</a>

_Jump to [the WIKI](https://github.com/binkley/modern-java-practices/wiki)
for latest book chapters._<br>
_Jump to [the project card wall](https://github.com/users/binkley/projects/1)
to see upcoming changes._

# Modern Java/JVM Build Practices

<a href="https://modernagile.org/" title="Modern Agile">
<img src="./images/modern-agile-wheel-english.png" alt="Modern Agile"
align="right" width="20%" height="auto"/>
</a>

[![Gradle build](https://github.com/binkley/modern-java-practices/actions/workflows/ci-earthly-gradle.yml/badge.svg)](https://github.com/binkley/modern-java-practices/actions)
[![Maven build](https://github.com/binkley/modern-java-practices/actions/workflows/ci-earthly-maven.yml/badge.svg)](https://github.com/binkley/modern-java-practices/actions)
[![coverage](https://github.com/binkley/modern-java-practices/raw/master/images/jacoco.svg)](https://github.com/binkley/modern-java-practices/actions/workflows/ci.yml)
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

> [!IMPORTANT]
> See [the wiki](https://github.com/binkley/modern-java-practices/wiki) for
> all pages and sections.
> This README is only introduction, motivation, and project status.
> You can use the [table of contents](#table-of-contents) below to quickly
> jump to bits that interest you.

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

But ... you **must** judge and measure the advice here against your own
systems and processes.
Some things (many or most things) may work for you:
keep an eye for things that do not work for you.

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

Notice that you can run the build purely locally, or _in a container_?

I want to convince you that running your builds in a container fixes the "it
worked on my machine" problem, and show you how to pick up improvements for
your build that helps you and others be _awesome_.

> [!NOTE]
> This project uses NVD to check for CVEs with your dependencies which can
> take a long time to download.
> You can speed up your build time by [requesting an NVD API
> key](https://nvd.nist.gov/developers/request-an-api-key) (it can take quite
> a while to fetch the CVEs list or update it, and may fail with 403 or 404
> without a key).
>
> When you request a key, NVD sends you an email to confirm your identity, and
> then share an API key web page.
> See [_Shift security
> left_](https://github.com/binkley/modern-java-practices/wiki/Shift-security-left)
> for more details.

See what the starter "run" program does:

Both Gradle and Maven (after building if needed) should print:
```
TheFoo(label=I AM FOOCUTUS OF BORG)
```

A "starter" program is the simplest of all possible ["smoke
tests"](https://en.wikipedia.org/wiki/Smoke_testing_(software)), meaning,
the minimal things _just work_, and when you check other things, maybe smoke
drifts from your computer as circuits burn out[^1].

[^1]: No, I'm just kidding.
Amazon or Google or Microsoft cloud would have quite different problems than
"white smoke" from computers[^2].

[^2]: Actually, this really happened me in a data center before the cloud.
We had to get out a fire extinguisher.

---

<a title="Changes">
<img src="./images/changes.png" alt="Changes"
align="right" width="20%" height="auto"/>
</a>

## Recent significant changes

- Move sections from `README.md` to the GitHub wiki.
  This is for breaking up an overlong (14k+ words) README into digestible
  sections.
- Earthly and Batect: Remove support for Batect as the author has archived
  that project.
  Please use _Earthly_ for local containerized builds.
  So your local command line is:
  ```bash
  $ earthly +build-with-gradle
  # OR
  $ earthly +build-with-maven
  ```
  I'll be researching other options, and updating to show those and examples.
  Advice remains the same: Run your local build in a container for
  reproducibility, and have CI do the same to exactly repeat your local
  builds.
- This project uses JDK 21.
  This project has no sample code relying on recent/modern versions of Java or
  the JVM; however, moving between versions _does_ need changes to build
  scripts and supporting files.
  Here is [the last commit using JDK 17](https://github.com/binkley/modern-java-practices/commit/039f6f45fade51da0c548bf5d61b8013423ab8b9)
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

* [Recent significant changes](#recent-significant-changes)
* [Introduction](https://github.com/binkley/modern-java-practices/wiki#introduction)
* Using this project
   * [Try it](#try-it)
   * [You and your
     project](https://github.com/binkley/modern-java-practices/wiki/You-and-your-project)
   * [Reusing this
     project](https://github.com/binkley/modern-java-practices/wiki/Reusing-this-project)
   * [Contributing](#contributing)
* [What is a build
  pipeline?](https://github.com/binkley/modern-java-practices/wiki/What-is-a-build-pipeline)
* [Commits](https://github.com/binkley/modern-java-practices/wiki/Commits)
* [Cycle
  time](https://github.com/binkley/modern-java-practices/wiki/Cycle-time)
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
* [Choose your code
  style](https://github.com/binkley/modern-java-practices/wiki/Choose-your-code-style)
* [Generate
  code](https://github.com/binkley/modern-java-practices/wiki/Generate-code)
* [Leverage the
  compiler](https://github.com/binkley/modern-java-practices/wiki/Leverage-the-compiler)
* [Use
  linting](https://github.com/binkley/modern-java-practices/wiki/Use-linting)
* [Use static code
  analysis](https://github.com/binkley/modern-java-practices/wiki/Use-static-code-analysis)
* [Shift security
  left](https://github.com/binkley/modern-java-practices/wiki/Shift-security-left)
* [Leverage unit testing and
  coverage](https://github.com/binkley/modern-java-practices/wiki/Leverage-unit-testing-and-coverage)
* [Use mutation
  testing](https://github.com/binkley/modern-java-practices/wiki/Use-mutation-testing)
* [Use integration
  testing](https://github.com/binkley/modern-java-practices/wiki/Use-integration-testing)
* [Debugging](https://github.com/binkley/modern-java-practices/wiki/Debugging)
* [Performance
  problems](https://github.com/binkley/modern-java-practices/wiki/Performance-problems)
* [Other
  problems](https://github.com/binkley/modern-java-practices/wiki/Other-problems)
* [Samples](https://github.com/binkley/modern-java-practices/wiki/Samples)
* [Going
  further](https://github.com/binkley/modern-java-practices/wiki/Going-further)
* [Credits](#credits)

---

## Contributing

See [`CONTRIBUTING.md`](./CONTRIBUTING.md).
Please [file issues](https://github.com/binkley/modern-java-practices/issues),
or contribute [pull
requests](https://github.com/binkley/modern-java-practices/pulls)!
I'd love a conversation with you.

---

## Credits

Many thanks to:

* Dan Wallach for discussions on security
* [Kristoffer Haugsbakk](https://github.com/LemmingAvalanche)
* [Sam Gammon](https://github.com/sgammon)
* [Sergei Bukharov](https://github.com/Bukharovsi)

All suggestions and ideas welcome!
Please [file an
issue](https://github.com/binkley/modern-java-practices/issues). ☺
