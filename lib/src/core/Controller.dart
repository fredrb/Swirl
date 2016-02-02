part of dartling.router;

abstract class Controller<T extends Response> {
  String url;

  /**
   * Internal GET and POST stream
   * Every GET and POST request will be redirected to these stream controllers
   */
  StreamController _getController = new StreamController.broadcast();
  StreamController _postController = new StreamController.broadcast();

  Router _nestedRouter;

  get _HasNestedControllers => _nestedRouter != null;

//  Not sure if should have METHOD streams public so they can be listened on controller implementation
//  @todo: consider
//
//  Stream get GET => _getController.stream;
//  Stream get POST => _postController.stream;

  Controller() { }

  /**
   * GET request wrapper
   * Should be overwritten by custom controller
   */
  getHandler(Request req) {
    req.response.send("Default GET response");
  }

  /**
   * POST request wrapper
   * Should be overwritten by custom controller
   */
  postHandler(Request req) {
    req.response.send("Default POST response");
  }

  /**
   * Override this to set nested routes
   */
  Map<String, Controller> router() {
    return null;
  }

  T _createResponseObject(HttpResponse res) {
    var reflected = reflectClass(T);
    return reflected.newInstance(const Symbol(''), [res]).reflectee;
  }

  /**
   * Initialize Controller
   *  - Stream listeners
   *  - Nested routers
   */
  initialize() {
    var routers = router();
    if (routers != null && routers.length > 0)
      _nestedRouter = new Router()
        .._controllerList.addAll(routers);

    _getController.stream.listen(this.getHandler,
      onDone: () => _getController.stream.drain());

    _postController.stream.listen(this.postHandler,
      onDone: () => _postController.stream.drain());
  }

  void _routeRequest(Request req) {
    req.response = _createResponseObject(req._dartReq.response);
    switch(req.method) {
      case HTTP_REQUEST_GET:
        _getController.add(req);
        break;
      case HTTP_REQUEST_POST:
        _postController.add(req);
        break;
    }
  }
}
