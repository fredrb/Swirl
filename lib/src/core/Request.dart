library Dartling.Request;

import 'dart:io';

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
   * Response object
   * Mapped to Dart standard response object (for now)
   */
  HttpResponse get response => _dartReq.response;

  factory Request(HttpRequest req) {
    Request request = new Request._internal(req);
    request.parameters = request.uri.split("/")
      ..removeAt(0);

    request.entryPoint = "/" + request.parameters[0];
    request.parameters.removeAt(0);

    if (request.entryPoint.isEmpty)
      request.entryPoint = '/';

    request.method = req.method;
    return request;
  }

  Request._internal(HttpRequest req) {
    this._dartReq = req;
    this.uri = req.uri.toString();
  }

}