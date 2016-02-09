import 'package:Swirl/src/core/network/Payload.dart';
import 'dart:convert';

class JSONPayload extends Payload<Object> {
  JSONPayload(content) : super(content) {
    this.contentType = "application/json";
    this.content     = JSON.encode(content);
  }
}