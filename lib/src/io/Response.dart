library dartling.response;

import 'package:Dartling/src/core/NetworkEntity.dart';
import 'dart:io';

class Response extends NetworkEntity {
  HttpResponse _dartResponse;

  Response(this._dartResponse) {}

  void write(Object object) { _dartResponse.write(object); }
  void close() { _dartResponse.close(); }

}