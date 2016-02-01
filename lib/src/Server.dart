library Dartling.Server;
import 'dart:io';
import 'dart:async';
import 'Router.dart';

const EVENT_SERVER_UP = 'EVENT SERVER UP';
const EVENT_GET_REQUEST = 'EVENT GET REQUEST';
const EVENT_POST_REQUEST = 'EVENT POST REQUEST';
const EVENT_UNKNOWN_REQUEST = 'EVENT UNKOWN REQUEST';

class Server {
  Future<HttpServer> _server;
  Router _router;
  StreamController _signalController = new StreamController.broadcast();

  Stream get signal => _signalController.stream;

  Server(String path, int port) {
    this._server = HttpServer.bind(path, port)
    .whenComplete(() => _signalController.add(EVENT_SERVER_UP));
    this._router = new Router();
  }

  addPathController(String path, ControllerBase controller) {
    _router.addRouteController(path, controller);
  }

  run() async {
    var server = await _server;
    await for (HttpRequest req in server) { _router.onRequest(req); }
  }

}
