library swirl.transformable;

import 'package:Swirl/src/xi/Transform.dart';

class Transformable {
  operator >>(Type type) {
    return new Transform(this).to(type);
  }
}
