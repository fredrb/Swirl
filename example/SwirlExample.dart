import 'package:Swirl/Swirl.dart';
import 'package:Swirl/Defaults.dart';
import 'package:Swirl/src/core/Joint.dart';

class UserController extends Controller {
  UserController() {
    joint = new Router()..attachHandler('/info', new DefaultController());
  }

  void onGetRequest(Request request, Response response) {
    response
      ..write("User Controller")
      ..close();
  }
}

class IndexController extends Controller {
  void onGetRequest(Request request, Response response) {
    response
      ..write("Index controller")
      ..close();
  }
}

class ServerApplication extends Server {
  ServerApplication(String path, int port) : super(path, port);

  @override
  void createRoutes() {
    joint
      ..attachHandler("/", new IndexController())
      ..attachHandler("/user", new UserController());
  }

  @override
  void onServerReady() {
    print("Server ready");
  }
}

main() {
  var server = new ServerApplication('localhost', 3000);
  server.run();
}
