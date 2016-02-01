// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library DartlingServer.example;

import 'package:Dartling/Dartling.dart';

// For the sake of the example, the controllers are created here
class IndexController extends Controller {
  IndexController() : super();

  @override
  getHandler(Request req) {
    // do something with request
    // ...
    req.response.send("Get response");
  }

  @override
  postHandler(Request req) {
    req.response.send("Post response");
  }
}

class UserCreateController extends Controller {
  UserCreateController() : super();
}

class UserController extends Controller {
  UserController() : super();

  @override
  getHandler(Request req) {
    req.response.sendJSON({
      "user" : "Frederico",
      "email" : "fred@gmail.com"
    });
  }

  // @todo: find a better way to do this
  @override
  Map<String, Controller> router() {
    var routeMap = new Map();
    routeMap['/create'] = new UserCreateController();

    return routeMap;
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
