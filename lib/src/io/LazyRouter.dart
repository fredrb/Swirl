part of swirl.io;

class LazyRouter extends Joint<Type> {

	LazyRouter(Map<String, Type> routes) {
		this.routes = routes;
	}

	IOHandler _instanceHandler(Type type) {
		IOHandler handler = null;

		if (type != null) {
			ClassMirror routerClass = reflectClass(type);

			if (routerClass.superclass == IOHandler) {
				InstanceMirror instance = routerClass.newInstance(routerClass.simpleName, new List());
				handler = instance.reflectee;
			}
		}

		return handler;
	}

  @override
  route(Entity entity, int segmentDepth) {
	  String path = entity.getSegment(segmentDepth);
	  Type handlerType = this.routes[path];

	  IOHandler handler = this._instanceHandler(handlerType);
	  handler?.receive(entity, segmentDepth);
  }
}