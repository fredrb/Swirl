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
    joint.attachHandler("/", new IndexController());
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
