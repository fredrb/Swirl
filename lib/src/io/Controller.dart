part of swirl.io;

abstract class Controller extends IOHandler {
  void onData(MessageEntity entity) {
    switch (entity.request.method) {
      case Method.GET:
        getRequest(entity.request, entity.response);
        break;
      case Method.POST:
        postRequest(entity.request, entity.response);
        break;
      default:
        unsupportedRequest(entity.request, entity.response);
    }
  }

  void onError(MessageEntity entity) {
    throw new Exception("Failed to read from Stream");
  }

  Future getRequest(Request req, Response res) => unsupportedRequest(req, res);

  Future postRequest(Request req, Response res) => unsupportedRequest(req, res);

  Future unsupportedRequest(Request req, Response res) {
    return new Future(() => res
      ..status(400)
      ..send("Not supported"));
  }
}