library swirl.request;

import 'dart:io';
import 'package:Swirl/src/core/network/Entity.dart';
import 'package:Swirl/src/core/network/Method.dart';
import 'package:Swirl/src/core/network/Payload.dart';
import 'package:Swirl/src/xi/Transform.dart';

class Request extends Entity {
  Request(Method method, Uri URI, HttpRequest request,
      {Map headers, Payload payload})
      : super(method, URI, request);

  Request.fromHttpRequest(HttpRequest request)
      : super(Entity.parseMethod(request.method), request.uri, request) {
    this.headers = Entity.mapHttpHeaders(request.headers);
//    this.payload = new Transform(request.join()).to(String);
  }
}
