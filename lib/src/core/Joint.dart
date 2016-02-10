part of swirl.core;

abstract class Joint<T> {

	Map<String, T> routes;

	route(Entity entity, int segment);

	hasRouter(String segment) {
		return routes.containsKey(segment);
	}
}