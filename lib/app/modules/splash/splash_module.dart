import 'package:flutter_modular/flutter_modular.dart';

import '../../core/core_module.dart';
import 'splash_bloc.dart';
import 'splash_page.dart';

class SplashModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(i) {
    i.addLazySingleton<ISplashBloc>(SplashBloc.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const SplashPage());
  }
}
