part of swirl.core;

abstract class Entity {}

class MessageEntity extends Entity {
  Request request;
  Response response;

  MessageEntity(this.request, this.response);
}

abstract class RouteEntity {
  List<String> namedParams;
  List<String> segments;
  String path;
  String url;
  IOHandler handler;

  RouteEntity({this.url, this.handler}) {
    this.path = Router.getURLParsed(this.url);
    this.namedParams = Router.getRouteParameters(this.url);
    this.segments = Router.getRouteURLSegments(this.url);
  }
}