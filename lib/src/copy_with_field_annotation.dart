import 'package:mini_data/src/copy_with.dart';

class CopyWithFieldAnnotation implements CopyWithField {
  const CopyWithFieldAnnotation({
    required this.immutable,
  });

  const CopyWithFieldAnnotation.defaults() : this(immutable: false);

  @override
  final bool immutable;
}
