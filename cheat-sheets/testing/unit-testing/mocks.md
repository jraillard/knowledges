# Mocks

When writing units test, you'll always come to a point where the method under test have any dependencies and therefore need to use something called `Mocks`.

:pray: Thanks @GuiFerreira for his clean explanation [right here](https://www.youtube.com/watch?v=D0dCa9XO4z0&t=3s).

First of all `Mock` is a common used term for what should be more called `test doubles`.
They are multiple `test double types` and they all have one purpose.

You can divide them into two test approaches :
- State verification :
  - Dummy
  - Stub
  - Spy
  - Fake
- Behavior verification :
  - Mock

:bulb: Notice that common used libraries doesnt always expose those names explicitly, you most often just see `mock` type but instead they offer a way to achieve the same goal (more or less).

:clipboard: Code samples stands as **samples**, you might want to create something like custom creators base on it in order to make their implementation fluent.

# Test Doubles 

In his video, @GuiFerreira expose a way writing your test doubles by your own so if you want to see how to achieve it, go check it out :smiley:

Here i'll be focusing on achieving it in C#, using `Nsubstitute` library for mocks and `FluentAssertions` as assertion library.

## State Verification

### Dummy 

You want to use a `dummy` when your service under test have a dependency you need to provide but **should do nothing either being injected**. 

&rarr; The methods it could have should never be called and crash the test if it appends.

```c#
public void Dummy_WhenUserIsNull_ShouldThrowArgumentNullException()
{
    // Arrange    
    var userRepository = Substitute.For<IUserRepository>();
    var userService = new UserService(userRepository);
    
    // Act
    var act = () =>  userService.AddNewUser(null!);

    // Assert
    act.Should().Throw<ArgumentNullException>();

    userRepository.ReceivedCalls().Should().BeEmpty();
}
```

### Stub

You want to use a `Stub` use it when you have one or multiple dependencies that should return a known value.

:warning: Again you also want to checks that the configured calls are the only to be called.

```c#
[Fact]
public void Stub_WhenRepositorySavesSuccessfully_ThenReturnsOk()
{
    // Arrange       
    var userRepository = Substitute.For<IUserRepository>();
    userRepository.Save(Arg.Any<User>()).Returns(true);

    var userService = new UserService(userRepository);
    
    // Act
    var result = userService.AddNewUser(new User(1, "John Doe"));

    // Assert
    result.Should().Be(UserServiceResult.Success);

    userRepository.Received(1).Save(Arg.Any<User>());
    userRepository.ReceivedCalls().Should().HaveCount(1); // the number depends on calls you configured
}
```

### Spy

You want to use a `Spy` when :
- you need to check that specified methods on spied on dependency have been called x times
- you need to check that specified methods on spied on dependency have been called using specified arguments

:warning: Again you also want to checks that the configured calls are the only to be called

```c#
[Fact]
public void Spy_RepositorySavesCorrectUserOnce()
{
    // Arrange       
    var userRepository = Substitute.For<IUserRepository>();        
    var userService = new UserService(userRepository);
    var user = new User(1, "John Doe");
    userRepository.Save(Arg.Any<User>()).Returns(true);

    // Act
    var result = userService.AddNewUser(user);

    // Assert
    result.Should().Be(UserServiceResult.Success);
    
    // Solution 1 : Using Arg predicate (if parameters isnt complex object)
    userRepository.Received(1).Save(Arg.Is<User>(x => x.Id == user.Id && x.Name == user.Name));

    // Solution 2 : Without using Arg predicate (if parameters is complex object)
    // First check for call on save method to avoid IndexOutOfRangeException under if Save() isnt called
    userRepository.Received(1).Save(Arg.Any<User>());

    // Then check for call on save method with correct user        
    var callToSave = userRepository.ReceivedCalls().ToList()[0];
    var userSendToSaveMethod = callToSave.GetArguments()[0];
    userSendToSaveMethod.Should().Be(user);        

    // Check for call on any other method
    userRepository.ReceivedCalls().Should().HaveCount(1);  
}
```

### Fake

A `Fake` is a simple implementation of an interface you want to replace, faking his behavior.
This mean you will be able to replace de underlying behavior and then expose a method to assert the state of the fake.

For instance, let's say we want to replace the `UserRepository` by an InMemory one;

```c#
[Fact]
public void Fake_RepositorySavesUser()
{
    // Arrange       
    var userRepository = Substitute.For<IUserRepository>();
    var user = new User(1, "John Doe");
    
    // Here we'll return true by default so that we could check AddNewUser() method result AND fake behavior
    userRepository.Save(Arg.Any<User>()).Returns(true);

    // Specify the behavior by implementing a callback
    Dictionary<int, User> users = new();       
    userRepository
        .When(x => x.Save(Arg.Any<User>()))
        .Do(x => users.Add(x.Arg<User>().Id, x.Arg<User>()));

    var userService = new UserService(userRepository);
    
    // Act
    var result = userService.AddNewUser(user);

    // Assert
    result.Should().Be(UserServiceResult.Success);

    // Equivalent to a Fake.Verify() method
    users.Should().ContainKey(user.Id);
    users[user.Id].Should().Be(user);

    // Check for configured call
    userRepository.Received(1).Save(user);
    userRepository.ReceivedCalls().Should().HaveCount(1);
}
```

## Behavior Verification

### Mock

`Mock` is quite similar to the `Spy` but they differ by being assigned to two different approaches :
- A `Spy` belongs to state verification tests, meaning you only have to check the state of the configured mocked (parameters send and called on it made)
- A `Mock` belongs to behavior verification tests, meaning you'll define expectations on the mock and then ask him to verify himslef that they have been granted 

For instance you can specify that a mock :
- Returns a specified value for a specific entry
- Throws an exception for others

```c#
[Fact]
public void Mock_RepositorySavesCorrectUserOnce()
{
    // Arrange       
    var userRepository = Substitute.For<IUserRepository>();
    var user = new User(1, "John Doe");
    
    // Whenever the value passed in, you're suppose make your return so that the next steps from the code under test can be executed
    userRepository.Save(Arg.Any<User>()).Returns(true);

    // Specify the behavior by implementing a callback
    bool isCallCorrect = true;
    userRepository
        .When(x => x.Save(Arg.Is<User>(x => x.Id != user.Id)))
        .Do(x => isCallCorrect = false);            

    var userService = new UserService(userRepository);
    
    // Act
    var result = userService.AddNewUser(new User(1, "John Doe"));

    // Assert
    result.Should().Be(UserServiceResult.Success);

    // Equivalent to a Moq.Verify() method
    isCallCorrect.Should().BeTrue();

    // Check for configured call
    userRepository.Received(1).Save(user);
    userRepository.ReceivedCalls().Should().HaveCount(1);
}
```
