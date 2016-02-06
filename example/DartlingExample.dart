import "package:Dartling/Swirl.dart";
import 'package:Dartling/Defaults.dart';
import 'dart:math';

class UserInformationController extends Controller {
  void onPostRequest(Request request, Response response) {}

  void onGetRequest(Request request, Response response) {
    response
      ..write("User info controller")
      ..close();
  }
}

class UserStatsController extends Controller {
  void onPostRequest(Request request, Response response) {}

  void onGetRequest(Request request, Response response) {
    response
      ..write("User statistics controller")
      ..close();
  }
}

class UserController extends Controller {
  UserController () {
    joint = new NestedRouter()
      ..addPathToConnector("/info", new UserInformationController())
      ..addPathToConnector("/stats", new UserStatsController());
  }

  void onPostRequest(Request request, Response response) {}

  void onGetRequest(Request request, Response response) {
    response
      ..write("User controller")
      ..close();
  }
}

class IndexController extends Controller {
  void onGetRequest(Request request, Response response) {
    response
      ..write("Welcome to Server")
      ..close();
  }

  void onPostRequest(Request request, Response response) {}
}

class ServerApplication extends Server {
  ServerApplication(String path, int port) : super(path, port);

  @override
  void createRoutes() {
    joint
      ..addPathToConnector("/", new DefaultController())
      ..addPathToConnector("/user", new UserController());
  }
}

main () {
  var server = new ServerApplication('localhost', 3000);
  server.onReady.listen((signal) {
    print("Server ready");
  });

  server.run();
}