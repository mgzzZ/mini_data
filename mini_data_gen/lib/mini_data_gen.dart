library mini_data_gen;

import 'package:build/build.dart' show Builder, BuilderOptions;
import 'package:mini_data_gen/src/copy_with_generator.dart';
import 'package:mini_data_gen/src/settings.dart';
import 'package:source_gen/source_gen.dart' show LibraryBuilder;

Builder copyWith(BuilderOptions config) {
  return LibraryBuilder(CopyWithGenerator(Settings.fromConfig(config.config)),
      generatedExtension: '.mini.dart'
      // 'copyWith',
      );
}
