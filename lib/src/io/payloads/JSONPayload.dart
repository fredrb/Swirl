part of swirl.network;

class JsonPayload extends Payload<Map> {

	String _rawPayload;

	JsonPayload(Map content) : super(content) {
		this._rawPayload = JSON.encode(content);
	}

	JsonPayload.fromString(String content) {
		this._rawPayload = content;
		this._content = JSON.decode(content);
	}

  JsonPayload.fromHttpRequest(HttpRequest request, {Function onComplete}) {
	  request.join().then((content) {
		  this._rawPayload = content;
		  this._content = JSON.decode(content);
		  onComplete?.call();
	  });
  }

  @override
  String get contentType => "application/json";

  @override
  String get content => _rawPayload;
}