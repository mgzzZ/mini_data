import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'config.dart';

class MergeGenerator extends GeneratorForAnnotation<MiniDataConfig> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final config = MiniDataConfig.fromConstantReader(annotation);
    if (!config.generateMerge) return '';

    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
          'Generator can only be applied to classes.',
          element: element);
    }
    final classElement = element;
    final buffer = StringBuffer();

    // 生成 merge 方法
    buffer.writeln("part of '${buildStep.inputId.pathSegments.last}';");

    buffer.writeln(
        'extension _\$${classElement.name}Merge on ${classElement.name} {');
    buffer.writeln('if (other == null) return this;');
    buffer.writeln('return copyWith(');
    buffer.writeAll(
        classElement.fields
            .map((field) => '${field.name}: other.${field.name}'),
        ', ');
    buffer.writeln(');');
    buffer.writeln('}');

    return buffer.toString();
  }
}
