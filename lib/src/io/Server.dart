library swirl.server;

import "dart:async";
import "dart:io";

import "package:Swirl/src/core/Dispatcher.dart";
import "package:Swirl/src/core/Joint.dart";
import "package:Swirl/src/io/Router.dart";

abstract class Server extends Dispatcher {
  Future<HttpServer> _server;

  Server(String path, int port) {
    _server = HttpServer.bind(path, port)
      ..then((server) {
        onServerReady();
      });

    joint = new Router();
  }

  void onServerReady() {
    // log something
  }

  void createRoutes();

  run() async {
    createRoutes();
    var server = await _server;
    await for(HttpRequest req in server) { HTTPForward(req); }
  }
}