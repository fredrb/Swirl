// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library DartlingServer.example;

import 'package:Dartling/Dartling.dart';

// For the sake of the example, the controllers are created here
class IndexController extends ControllerBase {
  IndexController() : super();

  getHandler(Request req) {
    // do something with request
    // ...
    req.response.write("Get response");
  }

  postHandler(Request req) {
    req.response.write("Post response");
  }
}

class UserController extends ControllerBase {
  UserController() : super();

  getHandler(Request req) {
    req.response.writeJSON({
      "user" : "Frederico",
      "email" : "fred@gmail.com"
    });
  }
}

main() {
  Server server = new Server('localhost', 3000);
  server.signal.listen((event) => print(event));

  // instantiate controllers
  var indexController = new IndexController();
  var userController  = new UserController();

  // add controller to router
  server
    ..addPathController('/', indexController)
    ..addPathController('/user', userController);

  server.run();
}
