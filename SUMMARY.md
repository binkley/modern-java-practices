<a href="LICENSE.md">
<img src="https://unlicense.org/pd-icon.png" alt="Public Domain"
align="right"/>
</a>

# Getting more from your team builds

Teams should:

* _Bake quality in_: Quality of code and execution are mainstays. Issues in
  production should be rare, and surprising, something usually found earlier
  in the development process
* _Treat security as a given_: Development should find security issues as
  early as sensible; finding these in production is not best
* _Use standards when possible_: Standards are industry-tested, and new team
  members nor managers will not be caught by surprise when using standards

If these are the principles, what follows?

The key takeaway is to _shift problems left_.  "Shifting left" means having
local developer software builds find issues before:

* Changes are pushed to CI (continuous integration), which is shared with the
  whole development team (an maybe others), possibly impacting everyone
* Changes move past CI into QA or Production where issues impact a broader
  audience including internal users and external customers

This means, local developer software builds should find as many issues as
possible before changes are pushed to CI or Production, and local builds
should take advantage of standards.

## TODOs

* Bake out the high-level points from the TOC

## TOC

* [Introduction](#introduction)
* [You and your project](#you-and-your-project)
* [Getting your project started](#getting-your-project-started)
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
