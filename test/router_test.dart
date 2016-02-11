library swirl.router_test;

import 'package:test/test.dart';
import 'package:Swirl/Swirl.dart';
import 'package:Swirl/Core.dart';
import 'dart:io';

class DefaultHandler extends IOHandler {
  @override
  void onData(MessageEntity entity) {}

  @override
  void onError(MessageEntity entity) {}
}

main() {
  group('Test router logic', () {
    RouterMap map;
    List<String> requestUri;

    setUp(() {
      map = new RouterMap(routes:new List.from([
        new Route(url:'/user/:id', handler:new DefaultHandler())
      ]));

      requestUri = new List.from(['user', '1']);
    });

    test('Test #findRouteForRequest', () {
      var route = Router.findRouteForRequest(map, requestUri);
      expect(route.handler is IOHandler, isTrue);
      expect(route.namedParams.length, isPositive);
      expect(route.segments.length, equals(1));
      expect(route.namedParams.elementAt(0), equals("id"));
    });

    test('Test #getRouteParameters', () {
      var parameters = Router.getRouteParameters("/user/:id");
      expect(parameters.elementAt(0), equals("id"));
    });

    test('Test #getRouteURLSegments', () {
      var parameters = Router.getRouteURLSegments("/user/product/:id");
      expect(parameters.elementAt(0), equals("/user"));
      expect(parameters.elementAt(1), equals("/product"));
    });

    test('Test #getURLParsed', () {
      var parsed = Router.getURLParsed("/user/product/:id");
      expect(parsed, equals("/user/product"));
    });
  });
}