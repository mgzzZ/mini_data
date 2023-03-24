import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class CopyWith {
  const CopyWith({
    this.copyWithNull,
    this.skipFields,
    this.constructor,
  });

  final bool? copyWithNull;

  final bool? skipFields;

  final String? constructor;
}

@Target({TargetKind.field})
class CopyWithField {
  const CopyWithField({this.immutable});

  final bool? immutable;
}

class $CopyWithPlaceholder {
  const $CopyWithPlaceholder();
}
