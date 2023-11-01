import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:focus_app/data/models/task.dart';
import 'package:focus_app/providers/select_task.dart';
import 'package:focus_app/shared/utils/log.dart';
import 'package:focus_app/widgets/duration_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NewTaskScreen extends HookConsumerWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var duration = useState(Duration.zero);
    var detailController = useTextEditingController();
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                context.go("/");
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  ref.read(selectTaskProvider.notifier).setTask(Task(
                      duration: duration.value, detail: detailController.text));
                  logger.d(
                      "set task successfully ${duration.value}, ${detailController.text}");
                  context.go("/");
                },
              )
            ]),
        body: Center(
            child: Column(children: [
          Expanded(
              child: DurationPicker(
            duration: duration.value,
            baseUnit: BaseUnit.minute,
            onChange: (val) {
              duration.value = val;
            },
            snapToMins: 5.0,
          )),
          Expanded(
            child: TextFormField(
              controller: detailController,
              keyboardType: TextInputType.multiline,
              minLines: 5,
              //Normal textInputField will be displayed
              maxLines: 10,
            ),
          )
        ])));
  }
}
