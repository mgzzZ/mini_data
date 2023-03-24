library mini_data;

import 'package:build/build.dart' show Builder, BuilderOptions;
import 'package:mini_data/src/copy_with_generator.dart';
import 'package:mini_data/src/settings.dart';
import 'package:source_gen/source_gen.dart';

Builder copyWith(BuilderOptions config) {
  return SharedPartBuilder(
    [CopyWithGenerator(Settings.fromConfig(config.config))],
    'copyWith',
  );
}
