part of swirl.io;

abstract class Server {
  String host;
  int port;
  RouterMap routerMap;

  Server(this.host, this.port, {this.routerMap});

  RouterMap createRouterMap();

  Future start() async {
    var server = await HttpServer.bind(this.host, this.port);
    routerMap = createRouterMap();
    await for (HttpRequest req in server) {
      Router.routeRequest(routerMap, req);
    }
  }
}
