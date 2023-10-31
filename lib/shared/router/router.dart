import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:caishen/app/screens/start_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "router.g.dart";

final _key = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

@riverpod
GoRouter router(RouterRef ref) {
  //final notifier = ref.watch(routerNotifierProvider.notifier);

  return GoRouter(
    navigatorKey: _key,
    //refreshListenable: notifier,
    debugLogDiagnostics: true,
    initialLocation: "/",
    routes: $appRoutes,
  );
}

@TypedGoRoute<StartRoute>(path: '/')
class StartRoute extends GoRouteData {
  const StartRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const StartScreen();
  }
}
