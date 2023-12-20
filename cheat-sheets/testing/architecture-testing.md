# Architecture testing

Here's an explanation about the `architecture testing` process.

No matter the used langage, the purpose is to test the way you're project is architected as you would it to be.

They're is two tipology of architecture tests :
- Tests verifying that you're project is following the chosen architecture style, for instance the `clean architecture`

&rarr;  In this way, tests would do checks like : adapter layer could not directly depend on domain layer, domain layer should be free from dependencies, etc.

- Tests verifying code style business oriented in order to make the code easily readable, simplify adding new features or new devs on project

&rarr; In this way, tests would do checks like : services naming conventions, specify types for specific uses cases (for instance in C# use of record class, record struct, class, struct, etc.), specify rules on interfaces implementations, etc.

:bulb: Keep in mind that those tests are compatible and you better have to use both in order to get strong architecture tests.

# Use cases

You might want to write snapshot tests in the following use cases : 
- Your team is composed with junior developpers 

&rarr; It will reduce review time on Merge / Pull requests

- Your team is quite big or will significantly grow in the future

&rarr; Architecture tests in this way would reduce new developpers oboarding time

- Your team is suppose to have turn-over such as in IT Service company projects


&rarr; As previously, architecture tests in this way would reduce new developpers oboarding time

:clipboard: You might think " Why would I use Architecture tests instead a of something basic linter in TS / JS or a roslyn analyzer in C# ? "

&rarr; Answer is quite opinionated, but I find it way more readable to see architecture rules written a test whereas in a linter rule that I can't have (or in a harder way) the detail on before getting the error. I think it's not the purpose of a linter.

# How to write architecture tests ?

In C# you have a nugget package called [ArchUnitNet](https://github.com/VerifyTests/Verify?tab=readme-ov-file) that meet our goal.

:bulb: It's a port from the library `ArchUnit` coming from Java.

Speaking about the test code base, tests methods would look like basic unit tests with the common three parts : 

- `Arrange` : You load the assembly you want to analyze through reflection. It could be common and used over the all tests so that you don't do this expensive operation everytime.
```c#
private static readonly Architecture Architecture = new ArchLoader().LoadAssemblies(
            System.Reflection.Assembly.Load("ExampleClassAssemblyName")
        ).Build();
```

- `Act` : You specify the rules through a fluent API.
```c#

// Here you get specific classes from the loaded assembly to not apply your following rule the entire assembly
private readonly IObjectProvider<IType> ExampleLayer =
            Types().That().ResideInAssembly("ExampleAssembly").As("Example Layer");
private readonly IObjectProvider<Class> ExampleClasses =
            Classes().That().ImplementInterface("IExampleInterface").As("Example Classes");


// Here you specify the rule
IArchRule exampleClassesShouldBeInExampleLayer =
            Classes().That().Are(ExampleClasses).Should().Be(ExampleLayer);
```
- `Assert` : You check your implemented rules
```c#
exampleClassesShouldBeInExampleLayer.Check(Architecture);
```
:bulb: Note that you can also combine multiple rules checks using 
combinatorial logic whith `IArchRule.And()` and `IArchRule.Or()` methods for instance.
