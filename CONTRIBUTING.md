# Contributing

Several scripts in the project root are to aid in contributing.

- [`build-as-ci-does.sh`](./build-as-ci-does.sh) &mdash;
  Recreate locally the build used by CI in GitHub actions using Batect
  (Docker):
  * Clean full build for Gradle
  * Run the Gradle-built demo program
  * Clean full build for Maven
  * Run the Maven-built demo program
- [`compare-tooling-versions.sh`](./compare-tooling-versions.sh`) &mdash;
  Crude comparison of tool and plugin versions between Gradle and Maven.
  Dependabot only creates PRs for the Maven build; Gradle needs updating by
  hand.
