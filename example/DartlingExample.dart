import "package:Dartling/Dartling.dart";
import 'package:Dartling/Defaults.dart';
import 'dart:math';

class ServerApplication extends Server {
  ServerApplication(String path, int port) : super(path, port);

  @override
  void createRoutes() {
    connectorJoint.addPathToConnector("/", new DefaultController());
  }
}

main () {
  var server = new ServerApplication('localhost', 3000);
  server.onReady.listen((signal) {
    print("Server ready");
  });

  server.run();
}