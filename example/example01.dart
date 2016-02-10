import "package:Swirl/Swirl.dart";
import 'dart:async';

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
