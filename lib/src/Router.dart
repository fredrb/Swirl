library Dartling.Router;

import 'dart:io';
import 'dart:async';
import 'core/Request.dart';

part 'core/Controller.dart';

const String HTTP_REQUEST_GET = 'GET';
const String HTTP_REQUEST_POST = 'POST';

class Router {
  Map<String,ControllerBase> _controllerList = new Map<String,ControllerBase>();
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
  void addRouteController(String route, ControllerBase controller) {
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
        switch(req.method) {
          case HTTP_REQUEST_GET:
            controller._getController.add(req);
            break;
          case HTTP_REQUEST_POST:
            controller._postController.add(req);
            break;
        }
      });
  }
}