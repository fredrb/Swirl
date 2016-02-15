part of swirl.core;

class Request {
  Map<String, String> headers;
  Map<String, String> parameters;
  Map<String, String> body;
  Method method;

  Request({this.parameters, this.method, this.headers, this.body});
}