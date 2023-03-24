import 'package:analyzer/dart/constant/value.dart' show DartObject;
import 'package:analyzer/dart/element/element.dart'
    show ClassElement, FieldElement, ParameterElement;
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:mini_data/mini_data.dart';
import 'package:mini_data/src/copy_with_field_annotation.dart';
import 'package:source_gen/source_gen.dart' show ConstantReader, TypeChecker;

class FieldInfo {
  FieldInfo({required this.name, required this.nullable, required this.type});

  final String name;

  final bool nullable;

  final String type;

  bool get isDynamic => type == "dynamic";
}

class ConstructorParameterInfo extends FieldInfo {
  ConstructorParameterInfo(
    ParameterElement element,
    ClassElement classElement, {
    required this.isPositioned,
  })  : fieldAnnotation = _readFieldAnnotation(element, classElement),
        classFieldInfo = _classFieldInfo(element.name, classElement),
        super(
          name: element.name,
          nullable: element.type.nullabilitySuffix != NullabilitySuffix.none,
          type: element.type.getDisplayString(withNullability: true),
        );

  final CopyWithFieldAnnotation fieldAnnotation;

  final bool isPositioned;

  final FieldInfo? classFieldInfo;

  @override
  String toString() {
    return 'type:$type name:$name fieldAnnotation:$fieldAnnotation nullable:$nullable';
  }

  static FieldInfo? _classFieldInfo(
    String fieldName,
    ClassElement classElement,
  ) {
    FieldElement? field = classElement.fields
        .where((e) => e.name == fieldName)
        .fold(null, (previousValue, element) => element);
    if (field == null) return null;

    return FieldInfo(
      name: field.name,
      nullable: field.type.nullabilitySuffix != NullabilitySuffix.none,
      type: field.type.getDisplayString(withNullability: true),
    );
  }

  static CopyWithFieldAnnotation _readFieldAnnotation(
    ParameterElement element,
    ClassElement classElement,
  ) {
    const defaults = CopyWithFieldAnnotation.defaults();

    final fieldElement = classElement.getField(element.name);
    if (fieldElement is! FieldElement) {
      return defaults;
    }

    const checker = TypeChecker.fromRuntime(CopyWithField);
    final annotation = checker.firstAnnotationOf(fieldElement);
    if (annotation is! DartObject) {
      return defaults;
    }

    final reader = ConstantReader(annotation);
    final immutable = reader.peek('immutable')?.boolValue;

    return CopyWithFieldAnnotation(
      immutable: immutable ?? defaults.immutable,
    );
  }
}
