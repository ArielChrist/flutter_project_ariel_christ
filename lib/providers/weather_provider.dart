import 'package:get/get.dart';
import 'package:flutter_project_ariel_christ/models/weather_model.dart';

class WeatherProvider extends GetConnect {
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String _apiKey = 'a481f28e3dc4ab686aa9c356465921d7';

  @override
  void onInit() {
    httpClient.baseUrl = _baseUrl;
    httpClient.timeout = const Duration(seconds: 10);
  }

  Future<Response<WeatherModel>> getWeatherWithForecast(String city) async {
    final currentRes = await get('/weather', query: {
      'q': city,
      'appid': _apiKey,
    });

    if (currentRes.status.hasError) {
      return Response(statusCode: currentRes.statusCode, statusText: currentRes.statusText);
    }

    final lat = currentRes.body['coord']['lat'];
    final lon = currentRes.body['coord']['lon'];

    final forecastRes = await get('/forecast', query: {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'appid': _apiKey,
      'units': 'metric',
    });

    if (forecastRes.status.hasError) {
      return Response(statusCode: forecastRes.statusCode, statusText: forecastRes.statusText);
    }

    final forecastList = forecastRes.body['list'];

    return Response(
      statusCode: 200,
      body: WeatherModel.fromJson(currentRes.body, forecastList),
    );
  }
}