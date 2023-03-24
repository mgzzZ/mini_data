library mini_data_gen;

import 'package:build/build.dart' show Builder, BuilderOptions;
import 'package:mini_data_gen/src/copy_with_generator.dart';
import 'package:mini_data_gen/src/settings.dart';
import 'package:source_gen/source_gen.dart' show SharedPartBuilder;

Builder copyWith(BuilderOptions config) {
  return SharedPartBuilder(
    [CopyWithGenerator(Settings.fromConfig(config.config))],
    'copyWith',
  );
}
