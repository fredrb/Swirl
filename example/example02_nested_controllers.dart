import 'package:Swirl/Swirl.dart';

class UserController extends Controller {
  UserController() {
    joint = new Router()
        ..attachHandler('/info', new UserInfoController());
  }

  void onGetRequest(Request request, Response response) {
    response
      ..write('User controller')
      ..close();
  }
}

class UserInfoController extends Controller {
  void onGetRequest(Request request, Response response) {
    response
      ..write('User info controller')
      ..close();
  }
}

class Application extends Server {
  Application(String path, int port) : super(path, port);

  void createRoutes() {
    joint.attachHandler('/user', new UserController());
  }
}

main() {
  new Application('localhost', 3000)
    ..run();
}

