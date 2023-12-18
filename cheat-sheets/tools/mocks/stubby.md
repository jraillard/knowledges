# Stubby4node
A configurable server for mocking/stubbing external systems during development.

[stubby](https://github.com/mrak/stubby4node) takes endpoint descriptors in the form of a YAML or JSON file that tell it how to respond to incoming requests. For each incoming request, configured endpoints are checked in-order until a match is found.

:bulb: Stubby is implement with multiple langages :
* **[stubby4j](https://github.com/azagniotov/stubby4j):** A java implementation of stubby
* **[stubby4net](https://github.com/mrak/stubby4net):** A .NET implementation of stubby
* **[grunt-stubby](https://github.com/h2non/grunt-stubby):** grunt integration with stubby
* **[gulp-stubby-server](https://github.com/felixzapata/gulp-stubby-server):** gulp integration with stubby

:pencil:  Stubby is better to use when you have multiple endpoint to set programmatically, it is longer to use it in a case where you just need to quickly setup a mock endpoint such as with [Mockoon](mockoon.md).
