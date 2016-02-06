library swirl.router;

import "package:Swirl/src/core/Joint.dart";
import "package:Swirl/src/core/network/Entity.dart";
import "package:Swirl/src/io/entities/Request.dart";

import "dart:async";
import "dart:io";

class Router extends Joint {
  Future<Entity> parseRequest(HttpRequest request) {
    return new Future<Entity>(() {
      return new Request.fromHttpRequest(request)..depth = 0;
    });
  }

  @override
  Future onForward(Entity entity) {
    return new Future(() {
//      entity.depth++;
      var handler = handlers[entity.entryPoint];
      if (handler != null) handler.receive(entity);
    });
  }

  @override
  Future onRequest(HttpRequest request) {
    return new Future(() {
      parseRequest(request)
        ..then((Entity entity) {
          var handler = handlers[entity.entryPoint];
          if (handler != null) {
            handler.receive(entity..depth += 1);
          }
        });
    });
  }
}
