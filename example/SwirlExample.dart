import 'package:Swirl/Swirl.dart';
import 'package:Swirl/Defaults.dart';

class ServerApplication extends Server {
  ServerApplication(String path, int port) : super(path, port);

  @override
  void createRoutes() {
    joint.addPathToConnector("/", new DefaultController());
  }
}

main () {
  var server = new ServerApplication('localhost', 3000);
  server.onReady.listen((signal) {
    print("Server ready");
  });

  server.run();
}