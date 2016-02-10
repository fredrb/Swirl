part of swirl.core;

abstract class IOHandler {
  StreamController entityQueueController = new StreamController.broadcast();
  Stream get entityQueue => entityQueueController.stream;

  IOHandler() {
    entityQueue.listen(onData, onError: this.onError);
  }

  void onData(MessageEntity entity);
  void onError(MessageEntity entity);

  Future onReceive(MessageEntity entity) {
    return new Future(() => entityQueueController.add(entity));
  }
}
