library dartling.network_entity;
import 'dart:io';

class NetworkEntity {
  HttpRequest dartReference;

  String method;
  String uri;
  String entryPoint;
  List<String> parameters;

  List<Object> body;
  NetworkEntity() {}

}