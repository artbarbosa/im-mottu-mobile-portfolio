import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';

import 'env/env.dart';
import 'services/http_client/http_client_service.dart';
import 'services/http_client/http_client_service_interface.dart';

class CoreModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<IHttpClientService>(
      () => HttpClientService(
        client: Client(),
        baseUrl: Env.to?.baseUrlAPI ?? '',
      ),
    );
  }
}
