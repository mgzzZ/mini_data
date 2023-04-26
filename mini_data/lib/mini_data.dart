library mini_data;

class MiniDataConfig {
  const MiniDataConfig({
    required this.generateCopyWith,
    required this.generateMerge,
  });
  final bool generateCopyWith;
  final bool generateMerge;
}
