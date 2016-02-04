library dartling.joint;

import 'dart:async';
import 'dart:io';

import "Connector.dart";
import 'package:Dartling/src/core/NetworkEntity.dart';

class Joint {
  Map<String, Connector> _connectorList = new Map<String, Connector>();
  Joint() {}

  void addPathToConnector(String path, Connector connector) {
    _connectorList[path] = connector;
  }

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

  Future onRequest(HttpRequest request) {
    return new Future(() {
      parseRequest(request)
        ..then((NetworkEntity entity) {
        var connector = _connectorList[entity.entryPoint];
        if (connector != null) {
          connector.redirect(entity);
        }
      });
    });
  }
}