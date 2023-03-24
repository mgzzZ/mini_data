import 'package:mini_data/mini_data.dart';

class CopyWithAnnotation implements CopyWith {
  const CopyWithAnnotation({
    required this.constructor,
    required this.copyWithNull,
    required this.skipFields,
  });

  @override
  final String? constructor;

  @override
  final bool copyWithNull;

  @override
  final bool skipFields;
}
