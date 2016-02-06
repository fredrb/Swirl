library swirl.transformer;

abstract class Transformer<I, O> {
  O transform(I input);
  // I translate(O output); Complexity becomes extremely higher

  Type getInputType() => I;
  Type getOutputType() => O;
}
