import 'package:Dartling/src/core/Connector.dart';
import 'package:Dartling/src/core/NetworkEntity.dart';
import 'package:Dartling/src/io/Request.dart';
import 'package:Dartling/src/io/Response.dart';
import 'package:Dartling/src/io/Router.dart';

abstract class Controller extends Connector {
  Controller() { entityMessages.listen(entityListener); }

  void entityListener(NetworkEntity entity) {
    var req = new Request(entity.method, entity.parameters);
    var res = new Response(entity.dartReference.response);

    switch (entity.method) {
      case 'GET':
        onGetRequest(req, res);
        break;
      case 'POST':
        onPostRequest(req, res);
        break;
    }
  }

  void onGetRequest(Request request, Response response);
  void onPostRequest(Request request, Response response);

}