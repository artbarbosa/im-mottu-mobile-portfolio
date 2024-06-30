import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/states/base_page_state.dart';

abstract class ISplashBloc extends Cubit<BaseState> {
  ISplashBloc() : super(const EmptyState());

  Future<void> initApp();
}

class SplashBloc extends ISplashBloc {
  @override
  Future<void> initApp() async {
    Future.delayed(const Duration(seconds: 2), () {
      Modular.to.pushReplacementNamed('/character');
    });
  }
}
