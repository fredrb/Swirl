import "package:Dartling/Dartling.dart";
import 'package:Dartling/Defaults.dart';

class ServerApplication extends Server {
  ServerApplication(String path, int port) : super(path, port);
}

main () {
  var server = new ServerApplication('localhost', 3000);

  // wrap this in a server method
  server.connectorJoint.addPathToConnector("/", new DefaultController());

  server.onReady.listen((signal) {
    print("Server ready");
  });

  server.run();
}