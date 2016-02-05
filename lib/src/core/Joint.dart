library dartling.joint;

import "dart:async";
import "dart:io";

import "package:Dartling/src/core/Connector.dart";
import "package:Dartling/src/core/NetworkEntity.dart";

abstract class Joint {
  Map<String, Connector> connectorList = new Map<String, Connector>();
  Joint() {}

  void addPathToConnector(String path, Connector connector) {
    connectorList[path] = connector;
  }

  Future<Map<String,Connector>> _getConnector(String key) {
    return new Future(() => connectorList[key]);
  }

  Future<NetworkEntity> parseRequest(Object request);
  Future onRequest(Object request);
  Future onForward(NetworkEntity request);

//  Future onRequest(Object request) {
//    return new Future(() {
//      parseRequest(request)
//        ..then((NetworkEntity entity) {
//          var connector = _connectorList[entity.entryPoint];
//          if (connector != null) {
//            connector.receive(entity);
//          }
//        });
//    });
//  }

//  Future<NetworkEntity> parseRequest(HttpRequest request) {
//    return new Future<NetworkEntity>(() {
//      var entity = new NetworkEntity();
//      entity.dartReference = request;
//      var params = request.uri.toString().split("/")
//        ..removeAt(0);
//
//      entity.method = request.method;
//      entity.entryPoint = "/" + params[0];
//      entity.parameters = params
//        ..removeAt(0);
//
//      return entity;
//    });
//  }
}