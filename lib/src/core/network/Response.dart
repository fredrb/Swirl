part of swirl.core;

class Response {
  HttpResponse _dartReference;
  Response.FromHttpResponse(HttpResponse response) { _dartReference = response; }

  void status(value) {
    _dartReference.statusCode = value;
  }

  void headers(String key, Object value) {
    _dartReference.headers.add(key, value);
  }

  void send(value) {
    _dartReference
      ..statusCode = 200
      ..write(value)
      ..close();
  }
}