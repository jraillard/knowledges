# Mutation testing

Here's an explanation about the `mutation testing` process.

No matter the used langage, the purpose is to detect if your unit tests are resilient to changes into your code. You can see them as tests for unit tests.

In another words mutation test are here to check that if a change is make in let say a service method, one or many of you're unit tests on it should fail. Otherwise it would indicate that you're unit tests doesnt sufficiently cover the code.

***"But what about code coverage from SonarQube for instance ?"*** would you say.

:warning: Spoiler alert &rarr; Code coverage only check if a test is passing trough every piece of the syntaxic tree induced by your codebase, but it doesnt check the effectiveness of your test (ie are you testing only common use cases on limit ones too).

***"Ok ... so how does mutation testing achieve that purpose ???"***

:bulb: Basically, mutation testing tool will analyze the syntax tree from your code base under test, generate alteration called `mutants` into it and then execute you're unit tests on the modified codebase.

&rarr; See an example on this [article](https://blog.raulnq.com/mutation-testing-with-strykernet) from Raul Naupari posted on the dotnet calendar 2023.

# Use cases

You might want to do mutation testing... **Almost everytime you're writing unit tests** :eyes:.

They will provide you, in addition to code coverage, an indicator of the effectiveness from your written unit tests.

# How to write mutation tests ?

For both C# and JS/TS you have a simple to use library for handling `mutation tests`, it is called [Stryker](https://stryker-mutator.io/).

As the docs would mention, your barely have quite nothing to do more than : 
  
:one: Install the appropriate library

:two:  Setup a configuration file 

:three: Run the associated command line

:four: Et voilà :rocket:

&rarr; The stryker tool generate all the mutants for you :pray: