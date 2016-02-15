import "package:Swirl/Swirl.dart";
import 'dart:async';
import 'dart:convert';

class UserModel {
  String name;
  String email;

  UserModel(this.name, this.email);
}

class User extends Controller {
  Future getRequest(Request req, Response res) {

    res.send("Hello ${req.parameters['id']}");
  }

  Future postRequest(Request req, Response res) {
    res
      ..headers('content-type', 'application/json')
      ..send(JSON.encode({
        "Name" : req.body['name'],
        "Email" : req.body['email']
      }));
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
