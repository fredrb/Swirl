import "package:Dartling/Dartling.dart";

class ServerApplication extends Server {
  ServerApplication(String path, int port) : super(path, port);
}

main () {
  var server = new ServerApplication('localhost', 3000);

  server.onReady.listen((signal) {
    print("Server ready");
  });

  server.run();
}