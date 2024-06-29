import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/character/character_module.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Marvel',
      debugShowCheckedModeBanner: false,
      routerConfig: Modular.routerConfig,
    );
  }
}

class AppModule extends Module {
  @override
  void routes(r) async {
    r.module("/", module: CharacterModule());
  }
}
