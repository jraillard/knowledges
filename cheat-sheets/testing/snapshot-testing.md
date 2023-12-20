# Snapshot testing

Here's an explanation about the `snapshot testing` process.

No matter the used langage, the purpose is to capture and compare snapshots of the expected output from a system or either a component.

# Use cases

You might want to write snapshot tests in the following use cases : 
- Legacy code you don't know what it does and don't want to break on future evolutions
- Non-regression tests
- You're a testing addict and want to have every type of tests on your projects :dizzy_face:

:warning: Keep in mind that thoses tests **SHOULD NEVER (without risks)** be the only ones on you're project as they "just" comparing results between runs.

# How to write snapshot tests ?

In C# you have a nugget package called [Verify](https://github.com/VerifyTests/Verify?tab=readme-ov-file) that meet our goal.

:bulb: There's a package for multiple testing framework you could use such as `XUnit`, `NUnit` or `MSTest`.

Speaking about the test code base, only the `Assert` part of your test is affected. 

Instead of make some assertions, you `Verify()` the result and that's it :sparkles:.

:bulb: This means you can snapshot output from unit tests or end-to-end tests for instance.

Behind the scene here's what happens :

- On first run, **Verify** store the result into a `{testFileName}.verified` file

&rarr; This file is a basic json-like (allowing us to source control it easily :smiley:) file containing both input and output from the verified test.

- On next runs, **Verify** store the result into a `{testFileName}.received` file and compare it to the `{testFileName}.verified` file and if compare fails test would too

:clipboard: For TypeScript / JavaScript users, `Jest` already include [snapshot testing similar feature](https://jestjs.io/docs/snapshot-testing) natively.
