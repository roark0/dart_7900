import 'dart:io';

String readStartModule() {
  return Platform.environment['START_MODULE'] ??
      const String.fromEnvironment('START_MODULE', defaultValue: 'analysis');
}

int readStartLjSide() {
  final String? rawValue = Platform.environment['START_LJ_SIDE'];
  if (rawValue != null) {
    final int? parsed = int.tryParse(rawValue);
    if (parsed != null) {
      return parsed;
    }
  }
  return const int.fromEnvironment('START_LJ_SIDE', defaultValue: 0);
}
