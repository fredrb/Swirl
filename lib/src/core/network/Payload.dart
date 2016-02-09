library swirl.payload;

import 'dart:io';

class Payload<T> {
  T content;
  String contentType;

  bool _complete;

  Payload(T content) {
    this.content = content;
    this._complete = true;
  }

//  Payload.fromXML(String xml);
//  Payload.fromJSON(Object json);
//  Payload.fromFile(File file);

  Payload.fromHttpRequest(HttpRequest request) {
    request.join().then((content) {
      this.content = content;
      this._complete = true;
    });
  }

  bool get complete => this._complete;
  T get encodedContent => this.content;
}
