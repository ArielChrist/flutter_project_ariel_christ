import 'package:get/get.dart';
import '../models/weather_model.dart';

class WeatherProvider extends GetConnect {
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String _apiKey = 'a481f28e3dc4ab686aa9c356465921d7'; // Remplacez par votre clé

  @override
  void onInit() {
    httpClient.baseUrl = _baseUrl;
    httpClient.timeout = const Duration(seconds: 10);
  }

  Future<Response<WeatherModel>> getWeatherByCity(String city) async {
    final response = await get('/weather', query: {
      'q': city,
      'appid': _apiKey,
    });

    if (response.status.hasError) {
      return Response(
        statusCode: response.statusCode,
        statusText: response.statusText,
      );
    }

    return Response(
      statusCode: response.statusCode,
      body: WeatherModel.fromJson(response.body),
    );
  }
}