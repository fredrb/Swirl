// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library DartlingServer.example;

import 'package:Dartling/Dartling.dart';
import 'package:Dartling/src/io/TextResponse.dart';
import 'package:Dartling/src/io/JSONResponse.dart';

// For the sake of the example, the controllers are created here
class IndexController<T extends Response> extends Controller<T> {
  IndexController() : super();

  @override
  getHandler(Request req) {
    // do something with request
    // ...
    req.response.send("Get Response");
  }

  @override
  postHandler(Request req) {
    req.response.send("Post response");
  }
}

class UserCreateController<T extends Response> extends Controller<T> {
  UserCreateController() : super();
}

class UserController<T extends Response> extends Controller<T> {
  UserController() : super();

  @override
  getHandler(Request req) {
    req.response.send({
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
  var indexController = new IndexController<TextResponse>();
  var userController  = new UserController<JSONResponse>();

  // add controller to router
  server
    ..addPathController('/', indexController)
    ..addPathController('/user', userController);

  server.run();
}
