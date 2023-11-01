import 'package:focus_app/data/models/task.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part "select_task.g.dart";

@riverpod
class SelectTask extends _$SelectTask {
  @override
  Task? build() {
    return null;
  }

  setTask(Task task) {
    state = task.copyWith();
  }
}
