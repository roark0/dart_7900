String readStartModule() {
  return const String.fromEnvironment('START_MODULE', defaultValue: 'analysis');
}

int readStartLjSide() {
  return const int.fromEnvironment('START_LJ_SIDE', defaultValue: 0);
}
