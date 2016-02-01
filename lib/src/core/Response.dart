library dartling.response;

import 'dart:convert';
import 'dart:io';

const String HEADER_CONTENT_TYPE = "content-type";
const String CONTENT_PLAIN_TEXT = "text/plain";
const String CONTENT_APPLICATION_JSON = "application/json";

class Response {
  HttpResponse _dartResponse;

  Response(HttpResponse dartResponse) {
    _dartResponse = dartResponse;
  }

  void send(String plainText) {
    _dartResponse
      ..headers.add(HEADER_CONTENT_TYPE, CONTENT_PLAIN_TEXT)
      ..write(plainText)
      ..close();
  }

  void sendJSON(Object obj) {
    _dartResponse
      ..headers.add(HEADER_CONTENT_TYPE, CONTENT_APPLICATION_JSON)
      ..write(JSON.encode(obj))
      ..close();
  }
}