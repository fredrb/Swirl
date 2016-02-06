import 'package:Swirl/Swirl.dart';

class IndexController extends Controller {
  void onGetRequest(Request request, Response response) {
    response
      ..write("This is a GET request!")
      ..close();
  }
}

class Application extends Server {
  Application(String path, int port) : super(path, port);

  @override
  void createRoutes() {
    joint.attachHandler('/', new IndexController());
  }
}

main () {
  new Application('localhost', 3000)
    ..run();
}