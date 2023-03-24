library mini_data_gen;

import 'package:build/build.dart' show Builder, BuilderOptions;
import 'package:mini_data_gen/src/copy_with_generator.dart';
import 'package:mini_data_gen/src/settings.dart';
import 'package:source_gen/source_gen.dart' show PartBuilder, SharedPartBuilder;

Builder copyWith(BuilderOptions config) {
  return PartBuilder(
    [CopyWithGenerator(Settings.fromConfig(config.config))],
    '.mini.dart',
  );
}
