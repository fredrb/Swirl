part of swirl.core;

abstract class Dispatcher {
	Joint joint;

	void forward(Entity entity, int segmentDepth) {
		joint.route(entity, segmentDepth);
	}
}