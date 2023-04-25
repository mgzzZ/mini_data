import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:mini_data_gen/src/config.dart';
import 'package:source_gen/source_gen.dart';

class CopyWithGenerator extends GeneratorForAnnotation<MiniDataConfig> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final config = MiniDataConfig.fromConstantReader(annotation);
    if (!config.generateCopyWith) return '';

    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
          'Generator can only be applied to classes.',
          element: element);
    }
    final classElement = element;
    final className = classElement.name;

    // Create builder class name
    final builderClassName = '_${className}CopyWithBuilder';

    // Generate builder class
    final builderClass = _generateBuilderClass(builderClassName, classElement);

    // Generate copyWithBuilder method
    final copyWithBuilderMethod = config.generateCopyWith
        ? _generateCopyWithBuilderMethod(builderClassName, className)
        : '';

    return '''
      $builderClass
      
      $copyWithBuilderMethod
    ''';
  }
}

String _generateBuilderClass(
    String builderClassName, ClassElement classElement) {
  final fieldsDeclarations = classElement.fields.map((field) {
    return '${field.type.getDisplayString(withNullability: true)} ${field.name};';
  }).join('\n');

  final copyConstructor = '''
    $builderClassName.from$builderClassName($builderClassName builder) {
      ${classElement.fields.map((field) => '${field.name} = builder.${field.name};').join('\n')}
    }
  ''';

  final fromClassConstructor = '''
    $builderClassName.from${classElement.name}(${classElement.name} instance) {
      ${classElement.fields.map((field) => '${field.name} = instance.${field.name};').join('\n')}
    }
  ''';

  final buildMethod = '''
    ${classElement.name} build() {
      return ${classElement.name}(
        ${classElement.fields.map((field) => '${field.name}: ${field.name}!,'.trim()).join('\n')}
      );
    }
  ''';

  return '''
    class $builderClassName {
      $fieldsDeclarations
      
      $builderClassName();
      
      $copyConstructor
      
      $fromClassConstructor
      
      $buildMethod
    }
  ''';
}

String _generateCopyWithBuilderMethod(
    String builderClassName, String className) {
  return '''
    extension ${className}CopyWithBuilder on $className {
      $builderClassName copyWithBuilder() {
        return $builderClassName.from${className}(this);
      }
    }
  ''';
}
