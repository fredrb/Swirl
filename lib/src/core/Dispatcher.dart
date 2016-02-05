library dartling.dispatcher;

import "dart:async";
import "dart:io";

import "package:Dartling/src/core/Joint.dart";
import "package:Dartling/src/core/NetworkEntity.dart";

abstract class Dispatcher {
  NetworkEntity networkEntity;
  Joint connectorJoint;

  Future HTTPForward(HttpRequest request) {
    return connectorJoint.onRequest(request);
  }
}