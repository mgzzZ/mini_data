import 'dart:async';

import 'package:analyzer/dart/element/element.dart' show ClassElement, Element;
import 'package:build/build.dart' show BuildStep;
import 'package:mini_data/mini_data.dart';
import 'package:mini_data_gen/src/config_ext.dart';
import 'package:source_gen/source_gen.dart'
    show ConstantReader, GeneratorForAnnotation, InvalidGenerationSourceError;

class MergeGenerator extends GeneratorForAnnotation<MiniDataConfig> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final config = ConfigUtil.fromConstantReader(annotation);
    if (!config.generateMerge) return '';

    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
          'Generator can only be applied to classes.',
          element: element);
    }

    final classElement = element;
    final className = classElement.name;

    // Generate merge method
    final mergeMethod = config.generateMerge
        ? _generateMergeMethod(className, classElement)
        : '';

    return '''
      $mergeMethod
    ''';
  }
}

String _generateMergeMethod(String className, ClassElement classElement) {
  final fieldsMerging = classElement.fields.map((field) {
    return '${field.name}: other.${field.name} ?? ${field.name},';
  }).join('\n');

  return '''
    extension ${className}Merge on $className {
      $className merge($className other) {
        return $className(
          $fieldsMerging
        );
      }
    }
  ''';
}
