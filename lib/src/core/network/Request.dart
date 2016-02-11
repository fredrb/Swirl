part of swirl.core;

class Request {
  Map<String,String> parameters;
  Method method;

  Request({this.parameters, this.method});
}