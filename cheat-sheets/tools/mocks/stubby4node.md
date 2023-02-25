# Stubby4node
A configurable server for mocking/stubbing external systems during development.

[stubby](https://github.com/mrak/stubby4node) takes endpoint descriptors in the form of a YAML or JSON file that tell it how to respond to incoming requests. For each incoming request, configured endpoints are checked in-order until a match is found.
