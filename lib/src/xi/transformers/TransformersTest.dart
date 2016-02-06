library swirl.transformer_test;

import "package:Swirl/src/core/integration/Transformable.dart";
import "package:Swirl/src/core/integration/Transformer.dart";

class Person extends Transformable {
  String name;

  Person(this.name);
}

class EmptyPerson {
  EmptyPerson();
}

class PTST extends Transformer<Person, String> {
  @override
  String transform(Person input) {
    return input == null || input.name == null || input.name.isEmpty
        ? "false"
        : "true";
  }
}

class STBT extends Transformer<String, bool> {
  @override
  bool transform(String input) {
    if (input == "true") {
      return true;
    } else {
      return false;
    }
  }
}

class BTIT extends Transformer<bool, int> {
  @override
  int transform(bool input) {
    if (input) {
      return 1;
    } else {
      return 0;
    }
  }
}

class ITDT extends Transformer<int, double> {
  @override
  double transform(int input) {
    return input.toDouble();
  }
}

class DTEPT extends Transformer<double, EmptyPerson> {
  @override
  EmptyPerson transform(double input) {
    if (input == 1) {
      return new EmptyPerson();
    } else {
      return null;
    }
  }
}
