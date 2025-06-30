import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_project_ariel_christ/controllers/home_controller.dart';
import 'package:flutter_project_ariel_christ/controllers/theme_controller.dart';
import 'package:flutter_project_ariel_christ/routes/app_routes.dart';
import 'package:flutter_project_ariel_christ/widgets/background.dart';

class HomePage extends GetView<HomeController> {
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return ThemedBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Météo'),
          actions: [
            Obx(() => IconButton(
              icon: Icon(
                themeController.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: themeController.toggleTheme,
            )),
          ],
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wb_sunny,
                  size: 100,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(height: 32),
                Text(
                  'Bienvenue dans l\'application de météo, 🌤️',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  'Découvrez la météo en temps réel pour 5 villes du monde entier.',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.WEATHER);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.play_arrow),
                      SizedBox(width: 8),
                      Text('Commencer l\'expérience'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
