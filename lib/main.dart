import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_widget.dart';
import 'app/core/env/env.dart';
import 'app/core/helpers/connectivy_channel.dart';
import 'app/core/services/hive/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ConnectivityChannel.initialize();

  Env.setEnvironment();

  await HiveService.initHive();

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
