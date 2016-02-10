part of swirl.core;

abstract class IOHandler extends Dispatcher {
	StreamController _messageChannel = new StreamController.broadcast();

	void receive(Entity entity, int segmentDepth) {
		String path = entity.getSegment(segmentDepth);

		if (this.joint.hasRouter(path)) {
			this.joint.route(entity, segmentDepth);
		} else {
			this._messageChannel.add(new Message(entity, segmentDepth));
		}
	}

	Stream get messages => _messageChannel.stream;
}