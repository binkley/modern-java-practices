<a href="LICENSE.md">
<img src="https://unlicense.org/pd-icon.png" alt="Public Domain"
align="right"/>
</a>

# Getting more from your team builds

For development teams to support the business and production the most:

* _Shift problems left_: This means teams should find issues in development
  before they impact QA or production
* _Bake quality in_: Quality of code and execution are mainstays. Issues in
  production should be rare, and surprising, something usually found earlier
  in the development process
* _Treat security as a given_: Development should find security issues as
  early as sensible; finding these problems in production is not best
* _Use standards when possible_: Standards are industry-tested, and new team
  members nor managers will not be caught by surprise when using standards

## How does the local build reflect these principles?

**The key takeaway is to _shift problems left_.**

The demonstration build scripts in this project focus on:

* Bootstrapping projects and developers quickly, so teams do not work on
  addressing build shortcomings later on. They should be naturally led towards
  the right directions. Later build changes should be focused on adding
  additional features, not on paying down
  [technical debt](https://www.martinfowler.com/bliki/TechnicalDebt.html)
* Using the right version of the JDK, which impacts which version of Java to
  pick (or another JVM language, such as Kotlin). This is important for
  licensing, project lifetime, and project lifecycle costs
* Gradle and Maven. These are the two most common choices for project builds
  in Java or other JVM languages, and have the widest support. The vast
  majority of Java/JVM developers know these already
* Supporting CI (continuous integration) on GitHub, or related systems (such
  as GitLab or Jenkins) off to a good start
* Keeping local builds as similar to CI as feasible, so problems happen
  locally before they happen in CI or later, and before those problems are
  shared with the whole team or wider audiences
* Preferring to generate code over writing code. Generated code is
  "battle-hardened", the generation widely tested by many, and it is easier
  for teams to change direction than with hand-written code spread throughout
  a codebase. For Java folks, the mantra is: do not write
  `equals`/`hashCode` by hand, and avoid the mistakes
* Maintaining a consistent code style across the codebase with "linting"
  (automated style checking). Linting enforces consist code style, making code
  reviews (PRs) easier, and aids out-of-team tooling (_eg_, SonarQube)
* Leveraging static code analysis tools, which find many bugs and security
  issues during build, before hitting CI and beyond. Next to unit testing,
  this is a mainstay in maintaining code quality, and fighting defects
* Shifting security "left" (relative to the whole path to production).  
  This means find known security issues during local builds before code
  changes are committed to the team shared codebase. Not all security issues
  can be found this way, but security tooling goes a long ways
* Leveraging full codebase test coverage. Local unit testing is a cornerstone
  of quality for well-understood business concerns, and key to finding code
  which misunderstands business concerns. High levels of coverage also lowers
  the cost of refactoring as teams update code for new features
* Applying modern "mutation" or "fuzz" testing, meaning, trying the codebase
  in ways not anticipated, and ferreting out unexpected problems.  
  Mutation testing is an especially good, automated technique to find issues,
  and to "test your tests"
* Running application-level "integration" tests across units of the codebase
  to test the whole codebase rather than individual classes/units. These tests
  are key in, for example, REST services or command-line tools
