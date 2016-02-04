library dartling.connector;

import 'dart:async';
import 'dart:io';

import 'package:Dartling/src/core/Joint.dart';
import 'package:Dartling/src/core/NetworkEntity.dart';

abstract class Connector {
  Joint connectorJoint;
  NetworkEntity networkEntity;

  StreamController _messageChannelController = new StreamController.broadcast();
  Stream get entityMessages => _messageChannelController.stream;

  Connector() {}

  void redirect(NetworkEntity entity) => _messageChannelController.add(entity);
  void forward();

  StreamController _requestController  = new StreamController.broadcast();
  StreamController _responseController = new StreamController.broadcast();

}

abstract class MainConnector extends Connector {
  Future HTTPForward(HttpRequest request) {
    return connectorJoint.onRequest(request);
  }
}

