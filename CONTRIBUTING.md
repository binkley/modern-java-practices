# Maintainance

Notes for maintaining this repository:

Use the helper scripts, and see that they:
1. **Work.**<br>
   Working scripts is the #1 thing to help others.
2. **Work in CI and make sense there.**<br>
   A top goal for you: your local build should mirror the build in CI.
   Check the GitHub actions.
3. **Make sense for the project.**<br>
   An example is moving from Batect to Earthly.
   Scripts should migrate from (the archived) Batect.

# Contributing

Several scripts in the project root are to aid in contributing.

- [`build-as-ci-does.sh`](./build-as-ci-does.sh) &mdash;
  Recreate locally the build used by CI in GitHub actions using Batect and
  Earthly (both use Docker):
  * Run a clean full build for Gradle
  * Run the Gradle-built demo program
  * Run a clean full build for Maven
  * Run the Maven-built demo program
  Helpful when CI has steps that local developers do not, and you want to 
  reproduce or explore locally a CI problem. The script should match the 
  actions your CI takes on pushes (this project uses GitHub actions).
- [`coverage`](./coverage)
  Checks if the local code passes at given levels of code coverage.
  The script is focused on Maven, but with edits would do the same for Gradle.
  This supports the ["ratchet"
  pattern](https://robertgreiner.com/continuous-code-improvement-using-ratcheting/).
- [`run-with-gradle.sh`](./run-with-gradle.sh)
  If you are a Gradle project, you will likely rename this to just `run` or 
  similar.
- [`run-with-maven.sh`](./run-with-maven.sh)
  If you are a Maven project, you will likely rename this to just `run` or
  similar.
- Use the
  [`wiki-outline.py`](https://raw.githubusercontent.com/wiki/binkley/modern-java-practices/etc/wiki-outline.py)
  script in the wiki repo to get a Table-of-Contents view from the command
  line.
