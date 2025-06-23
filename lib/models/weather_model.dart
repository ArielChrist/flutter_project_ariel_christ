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
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'] ?? '',
      country: json['sys']['country'] ?? '',
      temperature: (json['main']['temp'] - 273.15), // Conversion Kelvin to Celsius
      description: json['weather'][0]['description'] ?? '',
      icon: json['weather'][0]['icon'] ?? '',
      humidity: json['main']['humidity'].toDouble(),
      windSpeed: json['wind']['speed'].toDouble(),
      latitude: json['coord']['lat'].toDouble(),
      longitude: json['coord']['lon'].toDouble(),
      pressure: json['main']['pressure'],
    );
  }

  String get iconUrl => 'https://openweathermap.org/img/wn/$icon@2x.png';
}