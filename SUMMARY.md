<a href="LICENSE.md">
<img src="https://unlicense.org/pd-icon.png" alt="Public Domain"
align="right"/>
</a>

# Getting more from your team builds

Teams should:

* _Shift problems left_: This means teams should find issues in development
  before they impact QA or production
* _Bake quality in_: Quality of code and execution are mainstays. Issues in
  production should be rare, and surprising, something usually found earlier
  in the development process
* _Treat security as a given_: Development should find security issues as
  early as sensible; finding these in production is not best
* _Use standards when possible_: Standards are industry-tested, and new team
  members nor managers will not be caught by surprise when using standards

If these are the principles, what follows?

**The key takeaway is to _shift problems left_.**

The demonstration build scripts in this project focus on:

* Bootstrapping project quickly, so teams do not work on addressing build
  shortcomings later on. Later build changes should focus on adding additional
  features, not on paying down
  from-the-start [technical debt](https://www.martinfowler.com/bliki/TechnicalDebt.html)
* Using the right version of the JDK. This is important for licensing and
  project lifecycle costs
* Focus on Gradle and Maven. These are the two most common choices for project
  builds in Java or other JVM languages, and have the widest support
* Getting CI on GitHub (or related systems, like GitLab or Jenkins) off to a
  good start with local builds integrating well
* Keeping local builds as similar to CI as reasonable, so problems happen
  locally before those problems are shared with the whole team or wider
  audiences
* Preferring to generate code over writing code. Generated code is
  "battle-hardened", and it is easier for teams to change direction with it
  than with hand-written code spread over a codebase
* Maintaining consistent code styles across the whole team with "linting".
  This enforces consist code style, making code reviews (PRs) easier, and
  aiding out-of-team tooling (_eg_, SonarQube)
* Leveraging static code analysis tool, which find many bugs and security
  issues during build, before hitting CI and beyond
* Shifting security "left" (relative to the whole path to production),
  meaning, finding known security issues before they are committed to the team
  shared codebase
* Leveraging full code test coverage. Local unit testing is a cornerstone of
  quality for well-understood business concerns, and key to finding code which
  misunderstands business concerns
* Applying modern "mutation" or "fuzz" testing, meaning, trying the codebase
  in ways not anticipated, and ferreting out unexpected problems
* Running low-level "integration" tests across units of the codebase to test
  the whole codebase rather than individual portions. This is key in, for
  example, REST services or command-line tools
