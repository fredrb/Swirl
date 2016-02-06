library swirl.response;

import 'dart:io';

import 'package:Swirl/src/core/network/Entity.dart';
import 'package:Swirl/src/core/network/Method.dart';
import 'package:Swirl/src/core/network/Payload.dart';

class Response extends Entity {
  HttpResponse _dartResponse;

  Response(Method method, Uri URI, HttpRequest request,
      {Map headers, Payload payload})
      : super(method, URI, request) {
    _dartResponse = request.response;
  }

  void write(Object object) {
    _dartResponse.write(object);
  }

  void close() {
    _dartResponse.close();
  }
}
