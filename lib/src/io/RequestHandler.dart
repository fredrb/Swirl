import 'package:Swirl/src/core/IOHandler.dart';
import 'package:Swirl/src/core/network/Entity.dart';

class RequestHandler extends IOHandler {
  Object defaultResponse;
  RequestHandler(this.defaultResponse) : super();

  @override
  void receive(Entity entity) {
    entity.dartReference.response
      ..write(defaultResponse)
      ..close();
  }
}