import "dart:async";
import "dart:io";

import "package:Dartling/src/core/Dispatcher.dart";
import "package:Dartling/src/core/Joint.dart";
import "package:Dartling/src/io/Router.dart";

abstract class Server extends Dispatcher {
  Future<HttpServer> _server;

  StreamController _onReadyController = new StreamController.broadcast();
  Stream get onReady => _onReadyController.stream;

  Server(String path, int port) {
    _server = HttpServer.bind(path, port)
      ..then((server) {
        _onReadyController.add(server);
      });

    super.connectorJoint = new MainRouter();
  }

  void createRoutes();

  run() async {
    createRoutes();
    var server = await _server;
    await for(HttpRequest req in server) { HTTPForward(req); }
  }
}