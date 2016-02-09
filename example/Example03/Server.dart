import "package:Swirl/Swirl.dart";
import 'controllers/ProductController.dart';

class Application extends Server {
  Application(String path, int port) : super(path, port);

  void createRoutes() {
    joint
      ..attachHandler('/', new RequestHandler("Index"))
      ..attachHandler('/product/:id', new ProductController());
  }
}