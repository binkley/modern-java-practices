<a href="LICENSE.md">
<img src="https://unlicense.org/pd-icon.png" alt="Public Domain"
align="right"/>
</a>

# Getting more from your team builds

<a
href="https://flowdays.net/de/blog-de/2016/2/23/the-rfp-is-dead-meet-the-lean-proposal-canvas"
title="Der RFP ist tot: Hallo Lean-Agile Evaluation &mdash; flowdays - Die
agile Genossenschaft">
<img src="./images/bug-costs.jpg"
alt="Der RFP ist tot: Hallo Lean-Agile Evaluation &mdash; flowdays - Die agile
Genossenschaft"
align="right" width="30%" height="auto"/>
</a>

For development teams to most support the business and production, follow
these guidelines:

_Get off to a solid start_: Starting from Sprint #1, your teams should use the
tools to provide value and safety, and speed themselves up: _Technical
excellence_ matters. The local build is the _first_ thing that teams provide.
Teams should be able to discuss how the local build makes these goals
possible.

_Avoid later slowdowns_: Avoid
[technical debt](https://www.martinfowler.com/bliki/TechnicalDebt.html)
at the start, before it has a chance to build up. Technical debt is a major
factor in slowing down new work. The local build is one key to achieving
this: _The local build is your first firewall in ensuring issues do not reach
production_.

_Shift problems left_:  This means simply: find problem _earlier_ in the
development process. Picture teams' development pipelines running from local
effort on the left to production on the right. The local build is the earliest
possible place to find problems. Earlier work pays for itself in avoiding
later work, or worse, production issues.

_Treat security as a given_: Development should find security issues as early
as sensible, in your local builds when sensible; finding these problems in
production is not best. Customers and business partners only remember when
security fails.

_Bake quality in_: Quality of code and execution are mainstays. Issues in
production should be rare, and surprising, something usually found earlier in
the development process. A solid local build is the first step in Quality.

_Use standards when possible_: Standards are industry-tested, and neither new
team members nor managers are caught by surprise when using standards. Your
local builds should reuse hard-won industry know-how. Standards lower Cost,
and raise Quality.

## How does the local build reflect these goals?

**The key takeaway is to _shift problems left_.**

The build scripts
[in a demonstration project](https://github.com/binkley/modern-java-practices)
focus on:

* Bootstrapping projects and developers quickly, so teams do not work on
  addressing build shortcomings later on. They should be naturally led towards
  the right directions. Later build changes should be focused on adding
  additional features, not spending effort on paying down
  [technical debt](https://www.martinfowler.com/bliki/TechnicalDebt.html)
  with the local build
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
