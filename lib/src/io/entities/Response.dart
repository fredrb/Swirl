part of swirl.io;

class Response extends Entity {

	HttpResponse _httpResponse;

	Response(Method method, Uri uri, {Map<String, String> headers, Payload payload, HttpResponse reference}) :
		super(method, uri, headers: headers, payload: payload) {

		this._httpResponse = reference;
	}

	Response.fromHttpRequest(HttpRequest request) :
		super(Entity.parseMethod(request.method), request.uri, headers: Entity.mapHttpHeaders(request.headers)) {

		this._httpResponse = request.response;
	}

	Response.fromEntity(Entity entity) :
		super(entity.method, entity.uri, headers: entity.headers, payload: entity.payload) {

		this._httpResponse = (entity as Request)._httpRequest.response;
	}

	void _setHeaders() {
		for (int i = 0; i < this.headers.length; i++) {
			String name = this.headers.keys.elementAt(i);
			String value = this.headers.values.elementAt(i);

			this._httpResponse.headers.set(name, value);
		}
	}

	void _send(dynamic payload, {String contentType}) {
		this._setHeaders();

		if (contentType != null) {
			this._httpResponse.headers.set('content-type', contentType);
		}

		this._httpResponse
				..write(payload)
				..close();
	}

	void send(dynamic payload) {
		if (payload is Payload && payload.contentType != null) {
			this._send(payload, contentType: payload.contentType);
		} else {
			this._send(payload);
		}
	}

	void write(dynamic content) {
		this._httpResponse.write(content);
	}

	void close() {
		this._httpResponse.close();
	}
}