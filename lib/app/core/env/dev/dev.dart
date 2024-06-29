import '../env.dart';

class Development extends Env {
  @override
  String get baseUrlAPI => 'http://gateway.marvel.com/v1/public/';

  @override
  String get publicKey => 'PORTFOLIO_REMOVED_API_KEY';

  @override
  String get privateKey => 'PORTFOLIO_REMOVED_API_KEY';
}
