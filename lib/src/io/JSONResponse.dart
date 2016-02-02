import 'package:Dartling/src/Router.dart';
import 'dart:io';
import 'dart:convert';

class JSONResponse extends Response {
  HttpResponse _res;

  JSONResponse(HttpResponse res) : super(res) {
    this._res = res;
  }

  @override
  void send(Object object) {
    _res.headers.add(HEADER_CONTENT_TYPE, CONTENT_APPLICATION_JSON);
    _res.write(JSON.encode(object));

    super.send(object);
  }
}
