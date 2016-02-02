part of dartling.router;

const String HEADER_CONTENT_TYPE = HttpHeaders.CONTENT_TYPE;
const String CONTENT_PLAIN_TEXT = "text/plain";
const String CONTENT_APPLICATION_JSON = "application/json";

abstract class Response {
  HttpResponse _dartResponse;
  Map<String,String> headers;

  Response(HttpResponse dartResponse) {
    _dartResponse = dartResponse;
    headers = new Map<String,String>();
  }

  void addHeader(String key, String value) {
    headers[key] = value;
  }

  void send(Object object) {
//    headers.forEach((key, val) => _dartResponse.headers.add(key, val) );
    _dartResponse.close();
  }

//  void send(String plainText) {
//    _dartResponse
//      ..headers.add(HEADER_CONTENT_TYPE, CONTENT_PLAIN_TEXT)
//      ..write(plainText)
//      ..close();
//  }

//  void sendJSON(Object obj) {
//    _dartResponse
//      ..headers.add(HEADER_CONTENT_TYPE, CONTENT_APPLICATION_JSON)
//      ..write(JSON.encode(obj))
//      ..close();
//  }
}