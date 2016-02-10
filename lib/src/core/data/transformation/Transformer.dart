part of swirl.transformation;

abstract class Transformer<I, O> {

	O transform(I input);

	Type get inputType => I;
	Type get outputType => O;
}