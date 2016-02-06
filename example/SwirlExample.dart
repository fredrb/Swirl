import 'package:Swirl/Swirl.dart';
import 'package:Swirl/Defaults.dart';

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
    joint.addPathToConnector("/", new IndexController());
  }
}

main() {
  var server = new ServerApplication('localhost', 3000);
  server.onReady.listen((signal) {
    print("Server ready");
  });

  server.run();
}
