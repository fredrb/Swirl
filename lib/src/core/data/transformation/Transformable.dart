part of swirl.transformation;

class Transformable {

	operator >>(Type type) => new Transform(this).to(type);
}