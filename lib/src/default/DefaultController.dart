library defaults.controller;

import "package:Dartling/src/io/Controller.dart";
import 'package:Dartling/src/core/NetworkEntity.dart';
import 'package:Dartling/src/io/Request.dart';
import 'package:Dartling/src/io/Response.dart';

class DefaultController extends Controller {
  void onGetRequest(Request req, Response res) {
    res
      ..write("Default HTTP GET request")
      ..close();
  }

  void onPostRequest(Request req, Response res) {
    res
      ..write("Default HTTP POST request")
      ..close();
  }

  void forward() {}
}