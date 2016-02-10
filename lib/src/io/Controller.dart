part of swirl.io;

abstract class Controller extends IOHandler {

	Controller({bool startListening: true}) {
		if (startListening) {
			this.listen();
		}
	}

	bool canHandle(Entity entity, int segmentDepth);

	void listen() {
		this.messages.listen(this.receiveMessage);
	}

	void receiveMessage(Message message) {
		Entity entity = message.entity;
		int segmentDepth = message.segmentDepth;

		if (this.canHandle(entity, segmentDepth)) {
			if (!this.invoke(entity.method, entity)) {
				new Response.fromEntity(entity).send(new Payload404());
			}
		} else {
			this.forward(entity, segmentDepth);
		}
	}

	bool invoke(Method httpMethod, Entity entity) {
		InstanceMirror me = reflect(this);
		List<MethodMirror> methods = Mirrors.getMethods(this.runtimeType);

		Symbol method = _getMethod(httpMethod, methods);

		if (method != null) {
			me.invoke(method, [new Request.fromEntity(entity), new Response.fromEntity(entity)]);
			return true;
		}

		return false;
	}

	Symbol _getMethod(Method httpMethod, List<MethodMirror> methods) {
		for (MethodMirror method in methods) {
			if (method.simpleName == Enums.asString(httpMethod).toLowerCase()) {
				return method.simpleName;
			}
		}

		return null;
	}
}