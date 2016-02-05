library dartling.connector;

import "dart:async";
import "dart:io";

import "package:Dartling/src/core/Dispatcher.dart";
import "package:Dartling/src/core/NetworkEntity.dart";

abstract class Connector extends Dispatcher {
  StreamController _messageChannelController = new StreamController.broadcast();
  Stream get entityMessages => _messageChannelController.stream;

  void receive(NetworkEntity entity) {
    String route = null;
    if (entity.parameters.length > 0 && entity.parameters.elementAt(0) != null)
      route = "/" + entity.parameters[0];

    if ((connectorJoint != null) && connectorJoint.connectorList.containsKey(route)) {
      connectorJoint.onForward(entity);
    } else {
      _messageChannelController.add(entity);
    }
  }

  void forward() {}

//  StreamController _requestController  = new StreamController.broadcast();
//  StreamController _responseController = new StreamController.broadcast();

}
