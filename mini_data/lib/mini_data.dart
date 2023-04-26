library mini_data;

class MiniDataConfig {
  const MiniDataConfig({
    this.generateCopyWith = true,
    this.generateMerge = true,
  });
  final bool generateCopyWith;
  final bool generateMerge;
}
