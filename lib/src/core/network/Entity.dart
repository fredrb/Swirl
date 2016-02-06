library swirl.entity;

import 'dart:io';
import 'Method.dart';
import 'Payload.dart';

class Entity {
  Method method;
  Payload payload;
  Uri URI;
  String url;
  int depth;
  HttpRequest dartReference;

  Map<String, List<String>> headers;

  Entity(this.method, this.URI, this.dartReference,
      {this.headers, this.payload});

  String get entryPoint {
    return (URI.pathSegments.isEmpty) ? "" : URI.pathSegments.elementAt(depth);
  }

  static Method parseMethod(String text) {
    return Method.values
        .singleWhere((method) => method.toString() == "Method." + text);
  }

  static Map<String, List<String>> mapHttpHeaders(HttpHeaders headers) {
    Map<String, List<String>> map = new Map();

    headers.forEach((key, value) => map[key] = value);

    return map;
  }
}
