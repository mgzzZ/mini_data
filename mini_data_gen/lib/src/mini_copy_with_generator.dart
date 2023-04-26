import 'dart:async';

import 'package:analyzer/dart/element/element.dart' show ClassElement, Element;
import 'package:build/build.dart' show BuildStep;
import 'package:mini_data/mini_data.dart';
import 'package:mini_data_gen/src/config_ext.dart';
import 'package:source_gen/source_gen.dart'
    show ConstantReader, GeneratorForAnnotation, InvalidGenerationSourceError;

class CopyWithGenerator extends GeneratorForAnnotation<MiniDataConfig> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final config = ConfigUtil.fromConstantReader(annotation);
    if (!config.generateCopyWith) return '';

    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
          'Generator can only be applied to classes.',
          element: element);
    }
    final classElement = element;
    final className = classElement.name;

    final copyWithMethod = _generateCopyWithMethod(classElement);

    return '''
      extension ${className}CopyWith on $className {
        $copyWithMethod
      }
    ''';
  }

  String _generateCopyWithMethod(ClassElement classElement) {
    final className = classElement.name;

    final namedParameters = classElement.fields.map((field) {
      final type = field.type.getDisplayString(withNullability: false);
      final name = field.name;
      return '$type? $name';
    }).join(', ');

    final copyWithParams = classElement.fields.map((field) {
      final name = field.name;
      return '$name: $name ?? this.$name';
    }).join(', ');

    return '''
      $className copyWith({$namedParameters}) {
        return $className($copyWithParams);
      }
    ''';
  }
}
