import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_project_ariel_christ/controllers/home_controller.dart';
import 'package:flutter_project_ariel_christ/controllers/weather_controller.dart';
import 'package:flutter_project_ariel_christ/widgets/progress_gauge.dart';
import 'package:flutter_project_ariel_christ/widgets/loading_messages.dart';
import 'package:flutter_project_ariel_christ/widgets/weather_card.dart';
import 'package:flutter_project_ariel_christ/routes/app_routes.dart';

class WeatherPage extends GetView<HomeController> {
  final WeatherController weatherController = Get.find<WeatherController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Données Météo'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.offAllNamed(AppRoutes.HOME),
        ),
      ),
      body: Obx(() {
        if (!controller.isCompleted) {
          return _buildLoadingView(context);
        }

        if (weatherController.hasError) {
          return _buildErrorView(context);
        }

        return _buildWeatherList(context);
      }),
    );
  }

  Widget _buildLoadingView(BuildContext context) {
    // Démarrer le chargement des données et l'animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.progress == 0.0) {
        controller.startProgress();
        weatherController.fetchAllWeatherData();
      }
    });

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.1),
            Theme.of(context).scaffoldBackgroundColor,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProgressGauge(
              progress: controller.progress,
              isCompleted: controller.isCompleted,
              onRestart: _restartProcess,
            ),
            SizedBox(height: 48),
            LoadingMessages(
              message: controller.loadingMessages[controller.currentMessageIndex],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red,
            ),
            SizedBox(height: 24),
            Text(
              'Oops! Une erreur est survenue',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              weatherController.errorMessage,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                controller.resetProgress();
                weatherController.retryFetch();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh),
                  SizedBox(width: 8),
                  Text('Réessayer'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherList(BuildContext context) {
    return Column(
      children: [
        // Bouton recommencer en haut
        Container(
          padding: EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: _restartProcess,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.refresh),
                SizedBox(width: 8),
                Text('Recommencer'),
              ],
            ),
          ),
        ),
        // Liste des données météo
        Expanded(
          child: ListView.builder(
            itemCount: weatherController.weatherList.length,
            itemBuilder: (context, index) {
              final weather = weatherController.weatherList[index];
              return WeatherCard(
                weather: weather,
                onTap: () => Get.toNamed(
                  AppRoutes.CITY_DETAIL,
                  arguments: weather,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _restartProcess() {
    controller.resetProgress();
    weatherController.fetchAllWeatherData();
  }
}