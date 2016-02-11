# Swirl

Swirl is a server-side framework for Dart used to create meaningful REST APIs in an easy way. It is based on design patterns developed in NodeJS and Ruby on rails. The framework is meant to be easy to use
  and can be put into test quickly without needing to write many lines of code. 
  
### Route system

Routes can be created with parameter reference
`new Route(url: '/user/:id', handler: new User())`

And then retrieved in a `Request` object
```dart
class User extends Controller {
  Future getRequest(Request req, Response res) {
    res.send("Hello ${req.parameters['id']}");
  }
}
```

### Example:

```dart
class User extends Controller {
  Future getRequest(Request req, Response res) {
    res.send("Hello ${req.parameters['id']}");
  }
}

class Index extends Controller {
  Future getRequest(Request req, Response res) {
    res.send("Hello, world");
  }
}

class Application extends Server {
  Application(String host, int port) : super(host, port);

  @override
  createRouterMap() {
    return new RouterMap(routes: [
      new Route(url: '/', handler: new Index()),
      new Route(url: '/user/:id', handler: new User())
    ]);
  }
}

main() {
  new Application('localhost', 3000).start();
}

```

Run `dart ./example/example01.dart` and goto `http://localhost:3000/user/yourname`

Result:
`Hello yourname`