import 'package:Swirl/Swirl.dart';

class ProductController extends Controller {
  void onPostRequest(Request request, Response response) {
//    Todo: Payload.content = POST body
//    var produtct = Product.createFromContent(request.payload.content);
    response.send(response: new JSONPayload({
      "Created" : true,
      "Data" : {
        "id" : 3
        // "name" : product.name
      }
    }));
  }

  void onGetRequest(Request request, Response response) {
//    Todo: Named URL parameters
//    var id = request.parameters.get('id')
    response.send(response: new JSONPayload({
      "products" : [
        {
          "id" : 1,
          "name" : "Milk"
        },
        {
          "id" : 2,
          "name" : "Coffee"
        }
      ]
    }));
  }

}