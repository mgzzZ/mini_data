import 'package:mini_data/mini_data.dart';
import 'package:source_gen/source_gen.dart' show ConstantReader;

class ConfigUtil {
  static MiniDataConfig fromConstantReader(ConstantReader reader) {
    final generateCopyWith =
        reader.read('generateCopyWith').literalValue as bool? ?? true;
    final generateMerge =
        reader.read('generateMerge').literalValue as bool? ?? true;

    return MiniDataConfig(
      generateCopyWith: generateCopyWith,
      generateMerge: generateMerge,
    );
  }
}
