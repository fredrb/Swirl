library swirl.controller;

import 'package:Swirl/src/core/IOHandler.dart';
import 'package:Swirl/src/core/network/Entity.dart';
import 'package:Swirl/src/io/entities/Request.dart';
import 'package:Swirl/src/io/entities/Response.dart';
import 'package:Swirl/src/io/Router.dart';
import 'package:Swirl/src/core/network/Method.dart';

abstract class Controller extends IOHandler {
  Controller() {
    entityMessages.listen(entityListener);
  }

  void entityListener(Entity entity) {
    var req = new Request(entity.method, entity.URI, entity.dartReference);
    var res = new Response(entity.method, entity.URI, entity.dartReference);

    switch (entity.method) {
      case Method.GET:
        onGetRequest(req, res);
        break;
      case Method.POST:
        onPostRequest(req, res);
        break;
      default:
        res
          ..write("Error")
          ..close();
        break;
    }
  }

  void onGetRequest(Request request, Response response);
  void onPostRequest(Request request, Response response);
}
