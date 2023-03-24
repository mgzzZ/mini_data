

## Features

* 第一阶段工作完成:可以快捷生成copyWith方法

## Getting started

```yaml
dependencies:
  ...
  mini_data:
    git:
      url: https://github.com/mgzzZ/mini_data.git
      path: mini_data

dev_dependencies:
  ...
  build_runner:
  mini_data_gen:
    git:
      url: https://github.com/mgzzZ/mini_data.git
      path: mini_data_gen

```

## Usage


```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mini_data/mini_data.dart';

part 'student.g.dart';

@JsonSerializable()
@CopyWith()
class Student {
  final String name;
  final int? age;
  Student({required this.name, this.age});
  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);
}

```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
