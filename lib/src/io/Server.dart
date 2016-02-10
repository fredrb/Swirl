part of swirl.io;

class Server extends Dispatcher {

	String _host;
	int _port;

	Function onReady;

	Future<HttpServer> _server;

	Server(this._host, this._port, {Map<String, IOHandler> routes, this.onReady}) {
		this._setup(routes: routes);
	}

	void _setup({Map<String, IOHandler> routes}) {
		this.joint = new Router(routes);
		this._server = HttpServer.bind(this._host, this._port)
			.then((server) {
				this.onReady?.call(server);
			});
	}

	start() async {
		var server = await _server;

		await for (HttpRequest request in server) {
			this.forward(new Request.fromHttpRequest(request), 0);
		}
	}

	String get host => this._host;
	int get port => this._port;
}