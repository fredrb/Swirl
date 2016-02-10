part of swirl.network;

abstract class Entity {

	Method method;
	Uri uri;
	Payload payload;
	Map<String, String> headers;

	Entity(this.method, this.uri, {this.headers, this.payload});

	static Method parseMethod(String text) => Method.values.singleWhere((method) => method.toString() == "Method.$text");

	static Map<String, String> mapHttpHeaders(HttpHeaders headers) {
		Map<String, String> map = new Map();

		headers.forEach((name, value) => map[name] = value);

		return map;
	}

	String getSegment(int segmentDepth) {
		this.uri.pathSegments[segmentDepth];
	}
}