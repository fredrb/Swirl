part of swirl.io;

class Router extends Joint<IOHandler> {

	Map<String, IOHandler> routes;

	Router([this.routes]);

  @override
  route(Entity entity, int segment) {
	  String path = entity.uri.pathSegments[segment];
	  routes[path]?.receive(entity, segment++);
  }
}