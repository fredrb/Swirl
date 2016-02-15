part of swirl.core;

class Router {
  static RegExp parameterExpression = new RegExp(r"\/[\:](\w+)");
  static RegExp urlSegmentExpression = new RegExp(r"\/([\w]+)");
  static RegExp urlParseExpression = new RegExp(r"[\/,\w]+[^\/\:]");

  static RegExp bodyParseUrlencoded = new RegExp(r"(.*)=(.*)");

  // @TODO: change this
  // This is very stupid.
  // Should try a different approach that looks less... stupid.
  static RouteEntity findRouteForRequest(
      RouterMap map, List<String> requestUri) {
    RouteEntity selectedRoute = null;
    int matchedSegments = 0;

    map.routes.forEach((RouteEntity r) {
      int segments = 0;
      r.segments.forEach((s) {
        if (s == "/" + requestUri[r.segments.indexOf(s)]) {
          segments++;
        }
      });

      if (segments > matchedSegments) selectedRoute = r;
    });

    return selectedRoute;
  }

  static Future routeBodyBasedRequest(RouterMap map, HttpRequest request) {
    return request.listen((List<int> buffer) {
      return routeUrlBasedRequest(map, request, buffer:buffer);
    }).asFuture();
  }

  static Future routeUrlBasedRequest(RouterMap map, HttpRequest request, {List<int> buffer}) {
    var route = (request.uri.pathSegments.length > 0)
    ? findRouteForRequest(map, request.uri.pathSegments)
    : map.routes.firstWhere((r) => r.path == '/');

    return parseMessage(route, request, buffer)
      .then((message) => route.handler.onReceive(message));
  }

  static Future routeRequest(RouterMap map, HttpRequest request) {
    return (['POST', 'PUT'].any((p) => p == request.method))
      ? routeBodyBasedRequest(map, request)
      : routeUrlBasedRequest(map, request);
  }

  static Future<Map<String, String>> parseSegmentsIntoNamedParameters(
      RouteEntity route, HttpRequest request) {
    return new Future<Map<String, String>>(() {
      Map<String, String> namedParameters = new Map<String, String>();
      var segments = new List.from(request.uri.pathSegments);

      // workaround? Remove known path from segments
      route.segments.forEach((s) => segments.removeAt(0));

      segments.forEach((param) {
        if (route.namedParams != null && route.namedParams.length > 0) {
          // what?
          namedParameters[
              route.namedParams.elementAt(segments.indexOf(param))] = param;
        }

      });
      return namedParameters;
    });
  }

  static Future<Map<String, String>> parseBody(HttpHeaders headers, List<int> buffer)  {
    return new Future(() {
      switch (headers.value('content-type')) {
        case "application/x-www-form-urlencoded":
          return parseFormUrlEncodedContent(buffer);
        default:
          return null;
      }
    });
  }

  static Future<MessageEntity> parseMessage(
      RouteEntity route, HttpRequest request, List<int> buffer) {
    return new Future<MessageEntity>(() async {
      var bodyParameters = parseBody(request.headers, buffer);
      var namedParameters = parseSegmentsIntoNamedParameters(route, request);

      Request req = new Request(
          parameters: await namedParameters,
          method: parseMethod(request.method),
          body: await bodyParameters);
      Response res = new Response.FromHttpResponse(request.response);

      return new MessageEntity(req, res);
    });
  }

  static Map<String, String> parseFormUrlEncodedContent(List<int> rawContent) {
    Map<String, String> result = new Map<String, String>();
    List<String> content = new String.fromCharCodes(rawContent).split("&");
    content.forEach((string) {
      var key =
          applyRegexGroup(Uri.decodeFull(string), bodyParseUrlencoded, 1)[0];
      var value =
          applyRegexGroup(Uri.decodeFull(string), bodyParseUrlencoded, 2)[0];
      result[key] = value;
    });

    return result;
  }

  static List<String> getRouteParameters(String originalUrl) {
    return applyRegexGroup(originalUrl, parameterExpression, 1);
  }

  static List<String> getRouteURLSegments(String originalUrl) {
    return applyRegex(originalUrl, urlSegmentExpression);
  }

  static String getURLParsed(String originalUrl) {
    var parsed = applyRegex(originalUrl, urlParseExpression);
    return (parsed.length > 0) ? parsed.elementAt(0) : "/";
  }

  static Method parseMethod(String text) {
    return Method.values
        .singleWhere((method) => method.toString() == "Method." + text);
  }

  static Map<String, List<String>> mapHttpHeaders(HttpHeaders headers) {
    Map<String, List<String>> map = new Map();

    headers.forEach((key, value) => map[key] = value);

    return map;
  }
}

// Maybe put this in a util class?
List<String> applyRegex(String text, RegExp regex) {
  var result = new List<String>();
  Iterable<Match> routeParams = regex.allMatches(text);
  routeParams.forEach((m) => result.add(m.input.substring(m.start, m.end)));

  return result;
}

List<String> applyRegexGroup(String text, RegExp regex, int group) {
  var result = new List<String>();
  Iterable<Match> routeParams = regex.allMatches(text);
  routeParams.forEach((m) => result.add(m.group(group)));

  return result;
}
