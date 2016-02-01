part of Dartling.Router;

abstract class ControllerBase {
  String url;

  /**
   * Internal GET and POST stream
   * Every GET and POST request will be redirected to these stream controllers
   */
  StreamController _getController = new StreamController.broadcast();
  StreamController _postController = new StreamController.broadcast();

//  Not sure if should have METHOD streams public so they can be listened on controller implementation
//  @todo: consider
//
//  Stream get GET => _getController.stream;
//  Stream get POST => _postController.stream;

  ControllerBase() { }

  /**
   * GET request wrapper
   * Should be overwritten by custom controller
   */
  getHandler(Request req) {
    req.response.write("Default GET response");
  }

  /**
   * POST request wrapper
   * Should be overwritten by custom controller
   */
  postHandler(Request req) {
    req.response.write("Default POST response");
  }

  /**
   * Initialize Stream listeners
   */
  initialize() {
    _getController.stream.listen(this.getHandler,
      onDone: () => _getController.stream.drain());

    _postController.stream.listen(this.postHandler,
      onDone: () => _postController.stream.drain());
  }
}
