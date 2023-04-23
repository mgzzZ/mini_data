import 'package:source_gen/source_gen.dart';

class MiniDataConfig {
  final bool generateCopyWith;
  final bool generateMerge;

  const MiniDataConfig({
    required this.generateCopyWith,
    required this.generateMerge,
  });

  factory MiniDataConfig.fromConstantReader(ConstantReader reader) {
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
