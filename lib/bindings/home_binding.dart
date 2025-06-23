import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/weather_controller.dart';
import '../controllers/theme_controller.dart';
import '../providers/weather_provider.dart';
import '../services/weather_service.dart';

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