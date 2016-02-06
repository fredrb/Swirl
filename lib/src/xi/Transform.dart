library swirl.transform;

import 'package:Swirl/src/core/integration/Transformer.dart';

class Transform {
  static List<Transformer> _transformers = new List();

  Object _element;

  Transform(Object element) {
    this._element = element;
  }

  List<Transformer> _getTransformationChain(Type input, Type output) {
    List<Transformer> transformationChain = new List();
    Iterable<Transformer> transformers =
        _transformers.where((t) => t.getInputType() == input);

    for (Transformer transformer in transformers) {
      if (transformer.getOutputType() == output) {
        transformationChain.add(transformer);

        return transformationChain;
      } else {
        List<Transformer> subTransformationChain =
            _getTransformationChain(transformer.getOutputType(), output);

        if (subTransformationChain.length > 0) {
          transformationChain.add(transformer);
          transformationChain.addAll(subTransformationChain);
        }
      }
    }

    return transformationChain;
  }

  to(Type type) {
    if (_element == null) {
      return null;
    } else if (type == _element.runtimeType) {
      return _element;
    } else {
      List<Transformer> transformationChain =
          _getTransformationChain(_element.runtimeType, type);

      var result = _element;

      for (Transformer transformer in transformationChain) {
        result = transformer.transform(result);
      }

      return result;
    }
  }

  static void attach(Transformer transformer) {
    _transformers.add(transformer);
  }
}
