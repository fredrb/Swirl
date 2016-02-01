library dartling.request;

import 'dart:io';
import 'Response.dart';

class Request {

  /**
   * Complete URI
   */
  String uri;

  /**
   * First path in URI: controller to be called.
   * e.g. http://localhost:3000/user  > entryPoint = /user
   *      http://localhost:3000       > entryPoint = /
   */
  String entryPoint;

  /**
   * All parameters followed by entry point
   * e.g. http://localhost:3000/user/1  > parameters = [1]
   */
  List<String> parameters;

  /**
   * Internal Dart library request object.
   */
  HttpRequest _dartReq;

  /**
   * HTTP method (verb)
   * e.g. GET, POST, UPDATE ...
   */
  String method;

  /**
   * Dartling HTTP response Object
   */
  Response response;

  /**
   * Response object
   * Mapped to Dart standard response object (for now)
   */
//  HttpResponse get response => _dartReq.response;

  factory Request(HttpRequest req) {
    Request request = new Request._internal(req);
    var routes = req.uri.toString().split("/")
      ..removeAt(0);

    request.method = req.method;
    request.entryPoint = "/" + routes[0];
    request.parameters = routes
      ..removeAt(0);

    return request;
  }

  Request._internal(HttpRequest req) {
    this._dartReq = req;
    this.response = new Response(req.response);
    this.uri      = req.uri.toString();
  }

}