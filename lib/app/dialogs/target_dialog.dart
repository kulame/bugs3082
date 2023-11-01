import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_app/shared/utils/log.dart';
import 'package:focus_app/widgets/duration_picker.dart';
import 'package:super_editor/super_editor.dart';

const double _kDurationPickerWidthPortrait = 328.0;
const double _kDurationPickerWidthLandscape = 512.0;
const double _kDurationPickerHeightPortrait = 380.0;
const double _kDurationPickerHeightLandscape = 304.0;

const brandAttribution = NamedAttribution('brand');
const flutterAttribution = NamedAttribution('flutter');

TextStyle textStyleBuilder(Set<Attribution> attributions) {
  TextStyle textStyle = const TextStyle(
    color: Colors.black,
    fontSize: 14,
  );

  if (attributions.contains(brandAttribution)) {
    textStyle = textStyle.copyWith(
      color: Colors.red,
      fontWeight: FontWeight.bold,
    );
  }
  if (attributions.contains(flutterAttribution)) {
    textStyle = textStyle.copyWith(
      color: Colors.blue,
    );
  }

  return textStyle;
}

class TargetDialog extends StatefulWidget {
  /// Creates a duration picker.
  ///
  /// [initialTime] must not be null.
  const TargetDialog({
    Key? key,
    required this.initialTime,
    this.baseUnit = BaseUnit.minute,
    this.snapToMins = 1.0,
    this.decoration,
  }) : super(key: key);

  /// The duration initially selected when the dialog is shown.
  final Duration initialTime;
  final BaseUnit baseUnit;
  final double snapToMins;
  final BoxDecoration? decoration;

  @override
  TargetDialogState createState() => TargetDialogState();
}

class TargetDialogState extends State<TargetDialog> {
  @override
  void initState() {
    super.initState();
    _selectedDuration = widget.initialTime;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    localizations = MaterialLocalizations.of(context);
  }

  Duration? get selectedDuration => _selectedDuration;
  Duration? _selectedDuration;
  FocusNode focusNode = FocusNode();

  final _textController = TextEditingController();

  late MaterialLocalizations localizations;

  void _handleTimeChanged(Duration value) {
    setState(() {
      _selectedDuration = value;
    });
  }

  void _handleCancel() {
    Navigator.pop(context);
  }

  void _handleOk() {
    Navigator.pop(context, _selectedDuration);
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final theme = Theme.of(context);
    final boxDecoration =
        widget.decoration ?? BoxDecoration(color: theme.dialogBackgroundColor);
    final Widget picker = Padding(
      padding: const EdgeInsets.all(16.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: DurationPicker(
          duration: _selectedDuration!,
          onChange: _handleTimeChanged,
          baseUnit: widget.baseUnit,
          snapToMins: widget.snapToMins,
        ),
      ),
    );

    final Widget actions = ButtonBarTheme(
      data: ButtonBarTheme.of(context),
      child: ButtonBar(
        children: <Widget>[
          TextButton(
            onPressed: _handleCancel,
            child: Text(localizations.cancelButtonLabel),
          ),
          TextButton(
            onPressed: _handleOk,
            child: Text(localizations.okButtonLabel),
          ),
        ],
      ),
    );

    final dialog = Dialog(
      child: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          final Widget pickerAndActions = DecoratedBox(
            decoration: boxDecoration,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: picker,
                ), // picker grows and shrinks with the available space
                TextFormField(
                  onSaved: (String? value) {
                    logger.d(value);
                  },
                  autofocus: true,
                ),

                actions,
              ],
            ),
          );

          switch (orientation) {
            case Orientation.portrait:
              return SizedBox(
                width: _kDurationPickerWidthPortrait,
                height: _kDurationPickerHeightPortrait,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: pickerAndActions,
                    ),
                  ],
                ),
              );
            case Orientation.landscape:
              return SizedBox(
                width: _kDurationPickerWidthLandscape,
                height: _kDurationPickerHeightLandscape,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Flexible(
                      child: pickerAndActions,
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );

    return Theme(
      data: theme.copyWith(
        dialogBackgroundColor: Colors.transparent,
      ),
      child: dialog,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

Future<void> showTargetPicker({
  required BuildContext context,
  required Duration initialTime,
  BaseUnit baseUnit = BaseUnit.minute,
  double snapToMins = 1.0,
  BoxDecoration? decoration,
}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) => TargetDialog(
      initialTime: initialTime,
      baseUnit: baseUnit,
      snapToMins: snapToMins,
      decoration: decoration,
    ),
  );
}
