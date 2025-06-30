import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_project_ariel_christ/routes/app_pages.dart';
import 'package:flutter_project_ariel_christ/routes/app_routes.dart';
import 'package:flutter_project_ariel_christ/theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.HOME,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}