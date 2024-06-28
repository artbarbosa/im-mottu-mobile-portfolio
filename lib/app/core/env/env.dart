import 'dev/dev.dart';

abstract class Env {
  Env() {
    to = this;
  }

  static Env? to;
  String? baseUrlAPI;
  String? publicKey;
  String? privateKey;

  static void setEnvironment() {
         const environment = String.fromEnvironment('ENV', defaultValue: 'dev');

    switch (environment) {
      case 'dev':
        {
          Development();
          break;
        }
      default:
        {
          Development();
          break;
        }
    }
  }
}
