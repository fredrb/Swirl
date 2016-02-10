part of swirl.io;

class Request extends Entity {
	HttpRequest _httpRequest;

	Request(Method method, Uri uri, {Map<String, String> headers, Payload payload, HttpRequest reference}) :
		super(method, uri, headers: headers, payload: payload) {

		this._httpRequest = reference;
	}

	Request.fromHttpRequest(HttpRequest request, {bool awaitPayload}) :
		super(Entity.parseMethod(request.method), request.uri, headers: Entity.mapHttpHeaders(request.headers)) {

		this._httpRequest = request;

		if (awaitPayload) {
//			this.payload = new Transform(request.join()).to(String);
//		} else {
//			request.
		}
	}

	Request.fromEntity(Entity entity) :
		super(entity.method, entity.uri, headers: entity.headers, payload: entity.payload) {

		this._httpRequest = (entity as Request)._httpRequest;
	}
}