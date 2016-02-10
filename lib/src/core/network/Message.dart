part of swirl.network;

class Message {

	Entity entity;
	int segmentDepth;

	Message(this.entity, this.segmentDepth);

	@override
	String toString() => '${entity.method} "${entity.uri.pathSegments[segmentDepth]}"';
}