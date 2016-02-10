part of swirl.utils;

class Enums {

	static String asString(dynamic enumerator) {
		ClassMirror enumeratorClass = reflectClass(enumerator.runtimeType);

		if (enumeratorClass.isEnum) {
			String string = enumerator.toString();
			return string.substring(string.indexOf('.') + 1);
		} else {
			return enumerator.toString();
		}
	}
}