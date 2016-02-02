import 'dart:io';

import 'package:Dartling/src/Router.dart';

class TextResponse extends Response {
  HttpResponse _res;

  TextResponse(HttpResponse res) : super(res) {
    this._res = res;
  }

  @override
  void send(Object object) {
    _res.headers.add(HEADER_CONTENT_TYPE, CONTENT_PLAIN_TEXT);
    _res.write(object.toString());

    super.send(object);
  }
}
