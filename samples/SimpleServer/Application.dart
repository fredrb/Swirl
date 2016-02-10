import '../../lib/Swirl.dart';
import 'controllers/Index.dart';
import 'controllers/Products.dart';

class Application extends Server {
	Application(String path, int port) : super(path, port, routes: {
		'/': new Index(),
		'/product/:id': new Products()
	});
}

void main() {
	new Application('localhost', 3000).start();
}