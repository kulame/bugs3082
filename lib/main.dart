import 'package:flutter/material.dart';
import 'package:focus_app/shared/utils/log.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:focus_app/app/app.dart';

void main() {
  runApp(const ProviderScope(
    observers: [StateLogger()],
    child: App(),
  ));
}
