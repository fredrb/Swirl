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
        notSupportedRequest(req, res);
        break;
    }
  }

  void notSupportedRequest(Request request, Response response) {
    response
      ..write("Request not supported")
      ..close();
  }

  void onGetRequest(Request request, Response response) {
    notSupportedRequest(request, response);
  }

  void onPostRequest(Request request, Response response) {
    notSupportedRequest(request, response);
  }
}
