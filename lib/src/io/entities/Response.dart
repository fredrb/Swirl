library swirl.response;

import 'dart:io';

import 'package:Swirl/src/core/network/Entity.dart';
import 'package:Swirl/src/core/network/Method.dart';
import 'package:Swirl/src/core/network/Payload.dart';
import 'dart:async';

class Response extends Entity {
  HttpResponse _dartResponse;

  Response(Method method, Uri URI, HttpRequest request,
      {Map headers, Payload payload})
      : super(method, URI, request) {
    _dartResponse = request.response;
  }

  void _sendTextResponse(String text) {
    _dartResponse
      ..headers.add("content-type", "text/plain")
      ..write(text)
      ..close();
  }

  void _sendPayload(Payload response) {
    _dartResponse
      ..headers.add("content-type", response.contentType)
      ..write(response.content)
      ..close();
  }

  void _setResponseHeaders() {
    if (this.headers != null)
      this.headers.forEach((key, val) => _dartResponse.headers.add(key, val));
  }

  Future send({Payload response: null, String textResponse: null}) {
    return new Future(() {
      _setResponseHeaders();
      if (textResponse != null) {
        _sendTextResponse(textResponse);
      } else {
        _sendPayload(response);
      }
    });
  }

  void write(Object object) {
    _dartResponse.write(object);
  }

  void close() {
    _dartResponse.close();
  }
}
