# Unit testing

Here's an explanation about the `unit testing` process, the most known and used one.

No matter the used langage, the purpose is to test a single unit of code such as a component or a method from an object.

# Use cases

You might want to write unit tests in the following use cases : 
- You have complex algorithm you want ensure it handle every uses cases
- You are required to acquire a fixed test coverage percentage

:warning: Keep in mind that those tests could be hard to write if you're not following SOLID principles or having high cognitive complexity level on you're tested code base.

# How to write unit tests ?

In C# you have all testing framework include natively unit testing, my opiniated choice turn into `XUnit`.

:bulb: In TS / JS you can use `Jest` as you're testing framework.

Speaking about the test code base, tests methods would be composed on three parts :

- `Arrange` : You prepare you're data that would be send as test inputs and load the object containing the method you wanna test

```c#
// Arrange

int numberOne = 5;
int numberTwo = 6;

CalculatorService calculatorService = new ();
```

- `Act` : You call the method you wanna test

```c#
// Act

int result = calculatorService.Multiply(numberOne, numberTwo);
```

- `Assert` : You check the result

```c#
// Assert

result.Should().Be(30);
```


:bulb: You may have notice that I use [FluentValidation](https://fluentassertions.com/introduction) for assertions as I found the fluent API way more convenient than basic `Asserts` provided by the testing framework.

:clipboard: I didn't speak about `mocks` as it's another subject I will focus on [here](./mocks.md).