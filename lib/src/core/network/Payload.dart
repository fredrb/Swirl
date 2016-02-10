part of swirl.network;

abstract class Payload<T> {

	T _content;

	Payload([this._content]);

	Payload.fromXml(String xml);

	Payload.fromJson(String json);

	Payload.fromFile(File file);

	Payload.fromHttpRequest(HttpRequest request, {Function onComplete});

	String get contentType;
	String get content;
}