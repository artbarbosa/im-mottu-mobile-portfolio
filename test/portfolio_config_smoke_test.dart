import '../lib/app/core/env/dev/dev.dart';

void main() {
  final environment = Development();
  if (environment.publicKey != const String.fromEnvironment('MARVEL_PUBLIC_KEY') ||
      environment.privateKey != const String.fromEnvironment('MARVEL_PRIVATE_KEY')) {
    throw StateError('Marvel configuration was not injected.');
  }
  print('PASS: actual Development getters use supplied Marvel configuration.');
}
