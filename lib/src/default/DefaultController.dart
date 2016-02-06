library defaults.controller;

import "package:Swirl/src/io/Controller.dart";
import 'package:Swirl/src/core/network/Entity.dart';
import 'package:Swirl/src/io/entities/Request.dart';
import 'package:Swirl/src/io/entities/Response.dart';

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
