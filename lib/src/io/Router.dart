library swirl.router;

import "package:Swirl/src/core/Joint.dart";
import "package:Swirl/src/core/network/Entity.dart";
import "package:Swirl/src/io/entities/Request.dart";

import "dart:async";
import "dart:io";

abstract class Router extends Joint {
  @override
  Future<Entity> parseRequest(HttpRequest request) {
    return new Future<Entity>(() {
      return new Request.fromHttpRequest(request)..depth = 0;
    });
  }
}

//class NestedRouter extends Router {
//  @override
//  Future<Entity> parseRequest(Entity request) {
//    return new Future<Entity>(() {
//      request.entryPoint = "/" + request.parameters[0];
//      request.parameters.removeAt(0);
//      return request;
//    });
//  }
//
//  @override
//  Future onForward(Entity request) {
//    return new Future(() {
//      parseRequest(request)
//        ..then((NetworkEntity entity) {
//        var connector = connectorList[entity.entryPoint];
//        if (connector != null) {
//          connector.receive(entity);
//        }
//      });
//    });
//  }
//}

class MainRouter extends Router {
  @override
  Future onRequest(HttpRequest request) {
    return new Future(() {
      super.parseRequest(request)
        ..then((Entity entity) {
          var handler = connectorList["/" + entity.entryPoint];
          if (handler != null) handler.receive(entity);
        });
    });
  }

  @override
  Future onForward(Entity entity) {
    return new Future(() {
      entity.depth++;
      var handler = connectorList[entity.entryPoint];
      if (handler != null) handler.receive(entity);
    });
  }
}
