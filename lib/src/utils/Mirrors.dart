part of swirl.utils;

class Mirrors {

	static List<MethodMirror> getMethods(Type type) {
		ClassMirror clazz = reflectClass(type);
		Map<Symbol, DeclarationMirror> declarations = clazz.declarations;
		return declarations.values.where((declaration) => declaration is MethodMirror);
	}
}