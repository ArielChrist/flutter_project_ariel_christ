class HourlyForecast {
  final String time;
  final double temp;
  final String iconCode;

  HourlyForecast({
    required this.time,
    required this.temp,
    required this.iconCode,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    final dt = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000);
    final formattedHour = '${dt.hour.toString().padLeft(2, '0')}h';
    return HourlyForecast(
      time: formattedHour,
      temp: json['main']['temp'].toDouble(),
      iconCode: json['weather'][0]['icon'],
    );
  }
}

class WeatherModel {
  final String city;
  final String country;
  final double temperature;
  final String description;
  final String icon;
  final double humidity;
  final double windSpeed;
  final double latitude;
  final double longitude;
  final int pressure;
  final List<HourlyForecast> hourlyForecasts;

  WeatherModel({
    required this.city,
    required this.country,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.latitude,
    required this.longitude,
    required this.pressure,
    required this.hourlyForecasts,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json, List<dynamic> forecastList) {
    return WeatherModel(
      city: json['name'] ?? '',
      country: json['sys']['country'] ?? '',
      temperature: (json['main']['temp'] - 273.15),
      description: json['weather'][0]['description'] ?? '',
      icon: json['weather'][0]['icon'] ?? '',
      humidity: json['main']['humidity'].toDouble(),
      windSpeed: json['wind']['speed'].toDouble(),
      latitude: json['coord']['lat'].toDouble(),
      longitude: json['coord']['lon'].toDouble(),
      pressure: json['main']['pressure'],
      hourlyForecasts: forecastList
          .take(8)
          .map((item) => HourlyForecast.fromJson(item))
          .toList(),
    );
  }

  String get iconUrl => 'https://openweathermap.org/img/wn/$icon@2x.png';
}