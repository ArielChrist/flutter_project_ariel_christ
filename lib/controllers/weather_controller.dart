import 'package:get/get.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherController extends GetxController {
  final WeatherService _weatherService = Get.find<WeatherService>();

  final _weatherList = <WeatherModel>[].obs;
  final _isLoading = false.obs;
  final _hasError = false.obs;
  final _errorMessage = ''.obs;

  List<WeatherModel> get weatherList => _weatherList;
  bool get isLoading => _isLoading.value;
  bool get hasError => _hasError.value;
  String get errorMessage => _errorMessage.value;

  Future<void> fetchAllWeatherData() async {
    try {
      _isLoading.value = true;
      _hasError.value = false;
      _weatherList.clear();

      final weatherData = await _weatherService.getAllWeatherData();
      _weatherList.assignAll(weatherData);

      if (weatherData.isEmpty) {
        _hasError.value = true;
        _errorMessage.value = 'Aucune donnée météo disponible';
      }
    } catch (e) {
      _hasError.value = true;
      _errorMessage.value = 'Erreur lors du chargement des données';
    } finally {
      _isLoading.value = false;
    }
  }

  void retryFetch() {
    fetchAllWeatherData();
  }
}