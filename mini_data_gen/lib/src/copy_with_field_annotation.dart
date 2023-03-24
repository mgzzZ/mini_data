import 'package:mini_data/mini_data.dart';

class CopyWithFieldAnnotation implements CopyWithField {
  const CopyWithFieldAnnotation({
    required this.immutable,
  });

  const CopyWithFieldAnnotation.defaults() : this(immutable: false);

  @override
  final bool immutable;
}
