import '../../../lib/Swirl.dart';

class Index extends Controller {

	void get(Request req, Response resp) {
		resp.send('This is the Index, good job!');
	}

  @override
  bool canHandle(Entity entity, int segmentDepth) {
	  return entity.uri.pathSegments[segmentDepth] == '/';
  }
}