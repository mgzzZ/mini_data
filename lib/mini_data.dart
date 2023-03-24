library mini_data;

import 'package:build/build.dart' show Builder, BuilderOptions;
import 'package:meta/meta_meta.dart';
import 'package:mini_data/src/copy_with_generator.dart';
import 'package:mini_data/src/settings.dart';
import 'package:source_gen/source_gen.dart' show SharedPartBuilder;

Builder copyWith(BuilderOptions config) {
  return SharedPartBuilder(
    [CopyWithGenerator(Settings.fromConfig(config.config))],
    'copyWith',
  );
}

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
