library dartling.request;

import 'package:Dartling/src/core/NetworkEntity.dart';

class Request extends NetworkEntity {
  String method;
  List<String> parameters;
  Request(this.method, this.parameters) {}
}