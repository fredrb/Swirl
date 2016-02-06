# Swirl

Easy HTTP servers with Dart

Example:
```dart
class IndexController extends Controller {
  void onGetRequest(Request request, Response response) {
    response
      ..write("Welcome to Server")
      ..close();
  }
}

class ServerApplication extends Server {
  ServerApplication(String path, int port) : super(path, port);

  @override
  void createRoutes() {
    connectorJoint
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
```
