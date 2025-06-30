import 'package:get/get.dart';
import 'package:flutter_project_ariel_christ/models/weather_model.dart';
import 'package:flutter_project_ariel_christ/providers/weather_provider.dart';

class WeatherService extends GetxService {
  final WeatherProvider _weatherProvider = Get.find<WeatherProvider>();

  final List<String> cities = [
    'Paris',
    'London',
    'New York',
    'Tokyo',
    'Sydney',
  ];

  Future<WeatherModel?> getWeatherForCity(String city) async {
    try {
      final response = await _weatherProvider.getWeatherWithForecast(city);

      if (response.status.isOk && response.body != null) {
        return response.body;
      }
      return null;
    } catch (e) {
      print('Erreur lors de la récupération des données météo: $e');
      return null;
    }
  }

  Future<List<WeatherModel>> getAllWeatherData() async {
    List<WeatherModel> weatherList = [];

    for (String city in cities) {
      final weather = await getWeatherForCity(city);
      if (weather != null) {
        weatherList.add(weather);
      }
      await Future.delayed(Duration(milliseconds: 500));
    }

    return weatherList;
  }
}