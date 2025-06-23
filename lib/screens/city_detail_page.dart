import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/weather_model.dart';

class CityDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final WeatherModel weather = Get.arguments as WeatherModel;

    return Scaffold(
      appBar: AppBar(
        title: Text('${weather.city}, ${weather.country}'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carte météo principale
            Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${weather.temperature.round()}°C',
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Text(
                              weather.description.toUpperCase(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        Icon(
                          _getWeatherIcon(weather.description),
                          size: 80,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            // Détails météo
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Détails Météorologiques',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildDetailRow(
                      context,
                      Icons.opacity,
                      'Humidité',
                      '${weather.humidity.round()}%',
                    ),
                    _buildDetailRow(
                      context,
                      Icons.air,
                      'Vitesse du vent',
                      '${weather.windSpeed} m/s',
                    ),
                    _buildDetailRow(
                      context,
                      Icons.compress,
                      'Pression',
                      '${weather.pressure} hPa',
                    ),
                    _buildDetailRow(
                      context,
                      Icons.location_on,
                      'Coordonnées',
                      '${weather.latitude.toStringAsFixed(2)}, ${weather.longitude.toStringAsFixed(2)}',
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            // Bouton Google Maps
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _openGoogleMaps(weather.latitude, weather.longitude),
                icon: Icon(Icons.map),
                label: Text('Voir sur Google Maps'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(String description) {
    final desc = description.toLowerCase();
    if (desc.contains('rain')) return Icons.water_drop;
    if (desc.contains('cloud')) return Icons.cloud;
    if (desc.contains('sun') || desc.contains('clear')) return Icons.wb_sunny;
    if (desc.contains('snow')) return Icons.ac_unit;
    if (desc.contains('storm')) return Icons.flash_on;
    return Icons.wb_cloudy;
  }

  void _openGoogleMaps(double latitude, double longitude) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Get.snackbar(
        'Erreur',
        'Impossible d\'ouvrir Google Maps',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}