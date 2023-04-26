library mini_data_gen;

import 'package:build/build.dart' show BuilderOptions, Builder;
import 'package:mini_data_gen/mini_data_gen.dart';
import 'package:source_gen/source_gen.dart' show SharedPartBuilder;

export 'package:mini_data_gen/src/mini_copy_with_generator.dart';
export 'package:mini_data_gen/src/mini_merge_generator.dart';

Builder createCopyWithBuilder(BuilderOptions options) =>
    SharedPartBuilder([CopyWithGenerator()], 'copy_with');

Builder createMergeBuilder(BuilderOptions options) =>
    SharedPartBuilder([MergeGenerator()], 'merge');
