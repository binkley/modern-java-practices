<a href="LICENSE.md">
<img src="https://unlicense.org/pd-icon.png" alt="Public Domain"
align="right"/>
</a>

**Summary**: _Your teams' builds impact the business and organization_

# Getting more from your team builds

**TODO**: Tidy up the reference. Right now it is just "hanging out"

<a
href="https://flowdays.net/de/blog-de/2016/2/23/the-rfp-is-dead-meet-the-lean-proposal-canvas"
title="Der RFP ist tot: Hallo Lean-Agile Evaluation &mdash; flowdays - Die
agile Genossenschaft">
<img src="./images/bug-costs.jpg"
alt="Der RFP ist tot: Hallo Lean-Agile Evaluation &mdash; flowdays - Die agile
Genossenschaft"
align="right" width="30%" height="auto"/>
</a>

Getting your teams off to a good start is one of the key goals in spinning up
a new project. The same advice applies to refurbishing existing projects.

The most foundational technical component of a project is the _local build_.
It is so foundational, it is often overlooked even when it holds back faster
delivery.

The local build is how your developers come to trust the work they do before
sharing it with the rest of the team, or with other outside teams. That the
local build is "solid" is assumed by everyone, but when the local build is on
poor foundations, it leaves the project team &mdash; and others &mdash; in a
confused state. Often at project start, the local build is a hodgepodge of "it
worked on my machine": enough to showcase project start, but with unexplained
local pitfalls along the path to success as work proceeds.

Your teams' local builds from the outset should support key organization and
business goals such as Features, Maturity, Quality, and Security, and enhance
team productivity as developers add new business features.

This article addresses concerns of team local Java/JVM builds with a focus on
organization and business value. To get the most from productive development
teams, reuse of projects, and support of business and production, the general
goals are:

* _Get off to a solid start_: Starting from the first Sprint, use the tools
  that provide value and safety, and speed up developers:
  _Technical excellence_ matters. The local build is the _first_ thing that
  teams provide. The local build should let teams discuss how they reach
  functional and non-functional organization and business goals

* _Avoid later slowdowns_: Avoid
  [technical debt](https://www.martinfowler.com/bliki/TechnicalDebt.html)
  from the start, before it has a chance to build up. Technical debt is a
  major factor in slowing down new work. The local build is one of the keys to
  achieving this: _The local build is your first firewall in ensuring issues
  do not reach production_, and that "nuisances" do not grow into issues

<a href="https://github.com/binkley/html/blob/master/blog/on-pipelines"
title="On Pipelines">
<img src="./images/pipeline.png" alt="Production vs Dev pipeline"
align="right" width="30%" height="auto"/>
</a>

* _Shift problems left_:  Simply put, find problem _earlier_ in the
  development process. Picture teams' development pipelines running from local
  effort on the left to production on the right. The local build is the
  earliest possible place to find problems. Earlier work pays for itself in
  avoiding later work, or worse, production issues

* _Treat security as a given_: Developers should find security issues as early
  as sensible: in local builds on their machines. Finding security issues in
  production can be problematic at best, catastrophic at worst. Customers and
  business partners only remember when security fails, not when it works

<a href="https://martinfowler.com/bliki/TestPyramid.html"
title="TestPyramid">
<img src="./images/test-pyramid.png" alt="The test pyramid"
align="right" width="20%" height="auto"/>
</a>

* _Bake quality in_: Quality of code and execution are your mainstays. Issues
  in production should be rare, and unexpected, something you want found early
  in the development process (something "shifted left"). A solid local build
  is the first step in Quality, with local builds failing for bugs when
  possible while it is the cheapest to find and fix

* _Use standards and industry conventions when possible_: Standards and
  industry conventions are "battle tested", and neither new team members nor
  managers should be caught by surprise in reviewing your project's code when
  using standards. In other words, avoid reimplementations of existing work.
  Your local builds should reuse hard-won industry know-how. Standards lower
  your Cost, raise your Quality, and match your Security to current best
  knowledge  **TODO: Narrow this point to the _build_**

## Is this advice for you?

If your teams are individual or cross-team Java/JVM projects, the answer is
_Yes_.

If, for example, you are in an organization using a
large [monorepo](https://en.wikipedia.org/wiki/Monorepo) approach with build
tools such as [Bazel](https://www.bazel.build/), the answer is _Maybe_.  
In this case, you should be aware of the technical changes resulting from the
monorepo approach, and much of this advice _still_ applies: ask your technical
leadership to evaluate and adjust accordingly.

## How does the local build reflect these goals?

**The key takeaway is to _shift problems left_.**

The build scripts in
[this demonstration project](https://github.com/binkley/modern-java-practices)
focus on achieving these goals, with:

* Bootstrapping projects and developers quickly, so teams do not work on
  addressing build shortcomings later on. Teams should be led towards the
  right directions. Later build updates should be focused on additional
  features, not on paying down
  [technical debt](https://www.martinfowler.com/bliki/TechnicalDebt.html)
* Using the right version of the JDK. This means picking the right version of
  Java. This is important for licensing, project lifetime, and project
  lifecycle costs. This is key not just for Java, but other JVM languages,
  such as Kotlin
* Gradle and Maven. These are the two most common choices for project builds
  in Java or other JVM languages, and have the widest support. The vast
  majority of Java/JVM developers know these already. Pick one, and use your
  choice throughout the project lifecycle
* Supporting CI (continuous integration) on GitHub, or other CI systems (such
  as GitLab or Jenkins), and get off to a good start
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
