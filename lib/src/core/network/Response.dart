part of swirl.core;

class Response {
  HttpResponse _dartReference;
  Response.FromHttpResponse(HttpResponse response) { _dartReference = response; }

  void status(value) {
    _dartReference.statusCode = value;
  }

  void send(value) {
    _dartReference
      ..write(value)
      ..close();
  }
}