import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(
      methodCount: 0, colors: true, printTime: true, stackTraceBeginIndex: 2),
);

class StateLogger extends ProviderObserver {
  const StateLogger();
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    logger.d('''
{
  provider: ${provider.name ?? provider.runtimeType},
  oldValue: $previousValue,
  newValue: $newValue
}
''');
  }
}
