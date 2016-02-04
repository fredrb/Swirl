library dartling.connector;
import 'dart:async';

abstract class Connector {
  StreamController _requestController  = new StreamController.broadcast();
  StreamController _responseControlelr = new StreamController.broadcast();

  void forward();
}

abstract class MainConnector implements Connector {
  void forward() {
    // router work
  }
}

