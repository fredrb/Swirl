library swirl.joint;

import "dart:async";

import "package:Swirl/src/core/IOHandler.dart";
import "package:Swirl/src/core/network/Entity.dart";

abstract class Joint {
  Map<String, IOHandler> handlers = new Map<String, IOHandler>();
  Joint() {}

  void attachHandler(String path, IOHandler connector) {
    handlers[path] = connector;
  }

  Future onRequest(Object request);
  Future onForward(Entity request);
}
