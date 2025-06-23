import 'package:get/get.dart';
import '../screens/home_page.dart';
import '../screens/weather_page.dart';
import '../screens/city_detail_page.dart';
import '../bindings/home_binding.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.HOME;

  static final routes = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.WEATHER,
      page: () => WeatherPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.CITY_DETAIL,
      page: () => CityDetailPage(),
    ),
  ];
}