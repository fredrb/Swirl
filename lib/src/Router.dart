library dartling.router;

import 'dart:async';
import 'dart:io';
import 'dart:mirrors';

part 'core/Controller.dart';
part 'io/Request.dart';
part 'io/Response.dart';

const String HTTP_REQUEST_GET = 'GET';
const String HTTP_REQUEST_POST = 'POST';

class Router {
  Map<String,Controller> _controllerList = new Map<String,Controller>();
  Router() {}

  /**
   * Parse request in entryPoint and parameters task
   */
  Future<Request> parseRequest(HttpRequest req) {
    return new Future(() => new Request(req));
  }

  /**
   * Bind controller to parameter passed in URL
   */
  void addRouteController(String route, Controller controller) {
    controller.initialize();
    _controllerList[route] = controller;
  }

  /**
   * Called when request is received by Dartling server
   */
  void onRequest(HttpRequest request) {
    parseRequest(request)
      .then((req) {
        var controller = _controllerList[req.entryPoint];
        if (controller != null)
          controller._routeRequest(req);
      });
  }
}