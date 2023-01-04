import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/routes.dart';
import 'config/theme.dart';
import 'modules/shared/controllers/hot_key_manager.controller.dart';
import 'modules/shared/controllers/window_manager.controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(WindowManagerController());
  Get.put(HotKeyManagerController());

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uchkisch',
      theme: lightTheme,
      darkTheme: darkTheme,
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
