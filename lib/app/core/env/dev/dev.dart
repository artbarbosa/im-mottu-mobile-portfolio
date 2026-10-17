import '../env.dart';

class Development extends Env {
  @override
  String get baseUrlAPI => 'http://gateway.marvel.com/v1/public/';

  @override
  String get publicKey => const String.fromEnvironment('MARVEL_PUBLIC_KEY');

  @override
  String get privateKey => const String.fromEnvironment('MARVEL_PRIVATE_KEY');
}
