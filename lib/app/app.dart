import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import "package:caishen/shared/router/router.dart";

class App extends HookConsumerWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: "LOOP",
      routerConfig: router,
      // The Mandy red, light theme.
      theme: FlexThemeData.light(scheme: FlexScheme.redM3),
      // The Mandy red, dark theme.
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.redM3),
      themeMode: ThemeMode.system,
    );
  }
}
