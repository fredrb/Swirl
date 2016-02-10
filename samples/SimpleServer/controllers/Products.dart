import '../../../lib/Swirl.dart';

class Products extends Controller {

	Map<int, String> products;

	Products() {
		products = new Map();
	}

	get(Request request, Response response) {
		response.send(new JsonPayload(products));
	}

	post(Request request, Response response) {
		int id = int.parse(request.uri.queryParameters['id']);
		String name = request.uri.queryParameters['name'];

		products[id] = name;

		response.send('OK');
	}

  @override
  bool canHandle(Entity entity, int segmentDepth) {
    return entity.uri.pathSegments[segmentDepth] == 'products';
  }
}