# Mocks

When writing units test, you'll always come to a point where the method under test have some dependencies and therefore need to use something called `Mocks`.

:pray: First of all I would like to thank the following resources to shed light on this subject :
- @GuiFerreira for his clean explanation [right here](https://www.youtube.com/watch?v=D0dCa9XO4z0&t=3s)
- @Mark Seemann of his [article](https://learn.microsoft.com/en-us/archive/msdn-magazine/2007/september/unit-testing-exploring-the-continuum-of-test-doubles) from MSDN Magazine articles
- @GerardMeszaros for his [XUnit test patterns book](http://xunitpatterns.com/Test%20Double.html) that stand the basics of the Test double continuum.

First of all, after reading those resources, you'll find that `Mock` is a common used term for what should be more called `test doubles`.
They are multiple `test double types` and they all have one purpose.

| Test Double Type | Description |
| --- | --- |
Dummy |	The simplest, most primitive type of test double. Dummies **contain no implementation** and are mostly used when required as parameter values, but not otherwise utilized. `Nulls can be considered dummies, but real dummies are derivations of interfaces or base classes without any implementation at all`.
Stub |	A step up from dummies, stubs are minimal implementations of interfaces or base classes. `Methods returning void will typically contain no implementation at all, while methods returning values will typically return hard-coded values`.
Spy	| A test spy is similar to a stub, but besides giving clients an instance on which to invoke members, `a spy will also record which members were invoked so that unit tests can verify that members were invoked as expected`.
Fake |	A fake contains more complex implementations, typically handling interactions between different members of the type it's inheriting. While not a complete production implementation, `a fake may resemble a production implementation, albeit with some shortcuts`.
Mock | 	A mock is dynamically created by a mock library (the others are typically produced by a test developer using code). The test developer never sees the actual code implementing the interface or base class, but can configure the mock to provide return values, expect particular members to be invoked, and so on. `Depending on its configuration, a mock can behave like a dummy, a stub, or a spy`.

:bulb: They seems to be totally distinct, but if you're reading previous resources you'll see that's clearly not the case in real-world.

A good way to see it is the following [figure](https://learn.microsoft.com/en-us/archive/msdn-magazine/2007/september/images/cc163358.fig02.gif) that shows that our dependency replacement could behave into 1, 2 or even 3 test double type.

# When to use specified test double ?

Every resources shows how to implement test double manually but they all come to the fact that `Mock` is a simple way of creating them with less line of code and better maintanibility capabilities (as you're not creating new files / object for every needs).

Moreover you can come to a case where you'll to combine dummy, spy and stub behavior at same time for instance so that `Mock` seems to be more adapted.

The following table resume that well : 

| Test Double Type | Advantages | Disadvantages |
| --- | --- | --- |
Dummy |	Very easy to create. |	Not very useful.
Stub | Easy to create. | Limited flexibility. Opaque when observed from unit tests. No ability to verify that members were invoked correctly.
Spy | Can verify that members are invoked correctly. | Limited flexibility. Opaque when observed from unit tests.
Fake | 	Offers a semi-complete implementation that can be used in many different scenarios. | Harder to create. May be so complex that it requires unit testing in itself.
Mock | 	Efficient creation of test doubles. | Can verify that members are invoked correctly. Transparent when observed from unit tests.

# How to implement my mocks then ?

As I said before even though creating Dummy, Stub, Spies, and Fake manually could seem boring, mocking library offers different opinionated way to do so.

[Here](./mocks.nsubstitute.md) I'll explore it with C# `Nsubstitute` as a mocking library and `FluentAssertions` as assertion library :rocket:.