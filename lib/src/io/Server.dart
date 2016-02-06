library swirl.server;

import "dart:async";
import "dart:io";

import "package:Swirl/src/core/Dispatcher.dart";
import "package:Swirl/src/core/Joint.dart";
import "package:Swirl/src/io/Router.dart";

abstract class Server extends Dispatcher {
  Future<HttpServer> _server;

  StreamController _onReadyController = new StreamController.broadcast();
  Stream get onReady => _onReadyController.stream;

  Server(String path, int port) {
    _server = HttpServer.bind(path, port)
      ..then((server) {
        _onReadyController.add(server);
      });

    super.joint = new Router();
  }

  void createRoutes();

  run() async {
    createRoutes();
    var server = await _server;
    await for(HttpRequest req in server) { HTTPForward(req); }
  }
}