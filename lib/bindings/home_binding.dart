import 'package:get/get.dart';
import 'package:flutter_project_ariel_christ/controllers/home_controller.dart';
import 'package:flutter_project_ariel_christ/controllers/weather_controller.dart';
import 'package:flutter_project_ariel_christ/controllers/theme_controller.dart';
import 'package:flutter_project_ariel_christ/providers/weather_provider.dart';
import 'package:flutter_project_ariel_christ/services/weather_service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeatherProvider>(() => WeatherProvider());
    Get.lazyPut<WeatherService>(() => WeatherService());
    Get.lazyPut<ThemeController>(() => ThemeController());
    Get.lazyPut<WeatherController>(() => WeatherController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}