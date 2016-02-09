import 'package:Swirl/Swirl.dart';
import 'dart:convert';
import 'package:Swirl/Defaults.dart';

class UserInfoController extends Controller {
  void onGetRequest(Request request, Response response) {
    response.send(
        response: new JSONPayload({
      "This is a JSON": "Yes",
      "boolean": false,
      "List": [0, 1, 2, 3]
    }));
  }
}

class UserController extends Controller {
  UserController() {
    joint = new Router()..attachHandler('/info', new UserInfoController());
  }

  void onGetRequest(Request request, Response response) {
    response.send(textResponse: "User controller");
  }
}

class Application extends Server {
  Application(String path, int port) : super(path, port);

  void createRoutes() {
    joint
      ..attachHandler('/user', new UserController())
      ..attachHandler('/', new DefaultController());
  }
}

main() {
  new Application('localhost', 3000)..run();
}
