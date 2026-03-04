import 'package:flutter/material.dart';
import 'package:nesa_machine_test/core/routes/app_go_router.dart';
import 'package:nesa_machine_test/core/theme/app_theme.dart';
import 'package:nesa_machine_test/views/screens/product_list_screen.dart';
import 'package:provider/provider.dart';

import 'controllers/ProductController.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightThemeData,
      themeMode: ThemeMode.light,
      routerConfig: AppGoRouter.router,
    );
  }
}
