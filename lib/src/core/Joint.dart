library swirl.joint;

import "dart:async";
import "dart:io";

import "package:Swirl/src/core/IOHandler.dart";
import "package:Swirl/src/core/network/Entity.dart";

abstract class Joint {
  Map<String, IOHandler> connectorList = new Map<String, IOHandler>();
  Joint() {}

  void addPathToConnector(String path, IOHandler connector) {
    connectorList[path] = connector;
  }

  Future<Map<String, IOHandler>> _getConnector(String key) {
    return new Future(() => connectorList[key]);
  }

  Future<Entity> parseRequest(Object request);
  Future onRequest(Object request);
  Future onForward(Entity request);
}
