import 'package:freezed_annotation/freezed_annotation.dart';

part "task.freezed.dart";
part "task.g.dart";

@freezed
class Task with _$Task {
  factory Task({
    required Duration duration,
    required String detail,
  }) = _Task;
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
