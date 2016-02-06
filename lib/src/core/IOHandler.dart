library swirl.connector;

import "dart:async";

import "package:Swirl/src/core/Dispatcher.dart";
import "package:Swirl/src/core/network/Entity.dart";
import 'package:Swirl/src/io/Router.dart';

abstract class IOHandler extends Dispatcher {
  StreamController _messageChannelController = new StreamController.broadcast();
  Stream get entityMessages => _messageChannelController.stream;

  void receive(Entity entity) {
    if ((joint != null) && joint.handlers.containsKey(entity.entryPoint)) {
      joint.onForward(entity);
    } else {
      _messageChannelController.add(entity);
    }
  }

  void forward() {}
}
