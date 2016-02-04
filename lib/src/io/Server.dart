import 'dart:async';
import 'dart:io';

import 'package:Dartling/src/core/Connector.dart';

abstract class Server extends MainConnector {
  Future<HttpServer> _server;

  StreamController _onReadyController = new StreamController.broadcast();

  Stream get onReady => _onReadyController.stream;

  Server(String path, int port) {
    _server = HttpServer.bind(path, port)
      ..then((server) {
        _onReadyController.add(server);
      });
  }

  run() async {
    var server = await _server;
    await for(HttpRequest req in server) {
      req.response
        ..write("Done!")
        ..close();
    }
  }
}