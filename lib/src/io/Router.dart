library dartling.router;

import "package:Dartling/src/core/Joint.dart";
import "package:Dartling/src/core/NetworkEntity.dart";
import "dart:async";
import "dart:io";

abstract class Router extends Joint {}

class NestedRouter extends Router {
  @override
  Future<NetworkEntity> parseRequest(NetworkEntity request) {
    return new Future<NetworkEntity>(() {
      request.entryPoint = "/" + request.parameters[0];
      request.parameters.removeAt(0);
      return request;
    });
  }

  @override
  Future onForward(NetworkEntity request) {
    return new Future(() {
      parseRequest(request)
        ..then((NetworkEntity entity) {
        var connector = connectorList[entity.entryPoint];
        if (connector != null) {
          connector.receive(entity);
        }
      });
    });
  }
}

class MainRouter extends Router {
  @override
  Future<NetworkEntity> parseRequest(HttpRequest request) {
    return new Future<NetworkEntity>(() {
      var entity = new NetworkEntity();
      entity.dartReference = request;
      var params = request.uri.toString().split("/")
        ..removeAt(0);

      entity.method = request.method;
      entity.entryPoint = "/" + params[0];
      entity.parameters = params
        ..removeAt(0);

      return entity;
    });
  }

  @override
  Future onRequest(HttpRequest request) {
    return new Future(() {
      parseRequest(request)
        ..then((NetworkEntity entity) {
        var connector = connectorList[entity.entryPoint];
        if (connector != null) {
          connector.receive(entity);
        }
      });
    });
  }

}
