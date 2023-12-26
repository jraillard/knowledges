# NSubstitute

`Nsubsitute` is an opinionated way of handling `Mocks` in C#.

Before reading the next sections, take a look at :
- [NSubstitute getting started](https://nsubstitute.github.io/help/getting-started/)
- [How it works internally topic](https://nsubstitute.github.io/help/how-nsub-works/)
- Think about installing the [NSubstitute analyzer](https://nsubstitute.github.io/help/nsubstitute-analysers/)


# How to implement my mocks with NSubstitute

:pencil: Let's start with a definition.

***Mocks in NSubstitute are called `subs` or `substitutes`.***

Got it ? I'll use this terms for next sections now :eyes:


## Dummy

NSubstitute create by default an implementation of the substituted item:
- void returns method do nothing
- value-type and reference-type method would return default values

So, to create a dummy, the simple way is to check that our mock doesn't received any calls.

```c#

// Arrange 
var dummySubjectUnderTest = Substitute.For<ISubjectUnderTest>();

// ...

// Act
dummySubjectUnderTest.ReceivedCalls().Should().BeEmpty();

```

## Stub

NSubstitute allows you to setup returns from specified methods :
- Without any rules with `Returns()` / `Returns(Task.FromResult(...))` 
- Depending on method arguments by combining previous methods with the [argument matcher](https://nsubstitute.github.io/help/argument-matchers/) feature
- Depending on an [executed function](https://nsubstitute.github.io/help/return-from-function/) (but we might not need it oftenly)

:bulb: If you're stub is only supposed to expose some methods and not the others, you might want to check it by using [received calls feature](https://nsubstitute.github.io/help/received-calls/) as we did with dummies.

Another nice feature is the [ReturnsForAll() feature](https://nsubstitute.github.io/help/return-for-all) allowing you to return a value for every methods that returns the same type.

&rarr; Could be usefull when you have multiple signature of a method to stub :smiley:

:clipboard: I didnt talk about some other feature which i would call `syntaxic sugar` such as : **ReturnForAnyArgs()**, **ReturnsNul()**, etc.

## Spy

As we previously mentionned, `received calls feature` allows us to meet the spy test double type requirements.

Nsubstitute offers other features that could **really** help us to configure advanced spies :eyes: :
- [Partial substitute](https://nsubstitute.github.io/help/partial-subs/) 

&rarr; If you want to have a sub that uses the real instance behavior but Spy / Stub or anything else on specified methods

- [Performing actions with arguments](https://nsubstitute.github.io/help/actions-with-arguments/#performing-actions-with-arguments) 

&rarr; If like me you hate to check received calls with `Arg.Is<T>()` when reference types are passed into you're spied methods, this features could allows you to store it into a variable and then check it with you're loved assertion library (and `FluentAssertions` do it **SO NICELY** :heart_eyes: )

## Fake

Even if a fake should more likely be mannually implemented, Nsubstitute offers some features if you're fake behavior isn't that much complex :
- [Callbacks](https://nsubstitute.github.io/help/callbacks/) 

&rarr; Allowing you to do some actions after a call to you're substitute

- [Raising events](https://nsubstitute.github.io/help/raising-events/) 

&rarr; Allowing you to raise events on your substitute

## Mock

Well ... here you can barely combine every features `NSubstitute` as to offer :smiley: .