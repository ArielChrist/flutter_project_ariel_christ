import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:flutter_project_ariel_christ/models/weather_model.dart';

class CityDetailPage extends StatefulWidget {
  @override
  _CityDetailPageState createState() => _CityDetailPageState();
}

class _CityDetailPageState extends State<CityDetailPage> {
  final mapController = MapController();
  final popupController = PopupController();
  double zoomLevel = 12;

  @override
  Widget build(BuildContext context) {
    final WeatherModel weather = Get.arguments as WeatherModel;
    final latlng.LatLng cityLatLng = latlng.LatLng(
        weather.latitude, weather.longitude);

    final marker = Marker(
      width: 40,
      height: 40,
      point: cityLatLng,
      child: Icon(
        Icons.location_on,
        color: Theme
            .of(context)
            .primaryColor,
        size: 36,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('${weather.city}, ${weather.country}'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWeatherCard(context, weather),
                SizedBox(height: 16),
                _buildWeatherDetails(context, weather),
                _buildHourlyForecastHorizontal(
                    context, weather.hourlyForecasts),
                SizedBox(height: 16),
                SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 250,
                    child: FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        center: cityLatLng,
                        zoom: zoomLevel,
                        onTap: (_, __) => popupController.hideAllPopups(),
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c'],
                          userAgentPackageName: 'com.example.weatherapp',
                        ),
                        PopupMarkerLayerWidget(
                          options: PopupMarkerLayerOptions(
                            markers: [marker],
                            popupController: popupController,
                            popupDisplayOptions: PopupDisplayOptions(
                              builder: (BuildContext context, Marker marker) =>
                                  Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            weather.city,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(weather.description),
                                          Text('${weather.temperature} °C'),
                                        ],
                                      ),
                                    ),
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Zoom controls
          Positioned(
            bottom: 30,
            right: 16,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'zoomIn',
                  mini: true,
                  child: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      zoomLevel += 1;
                      mapController.move(cityLatLng, zoomLevel);
                    });
                  },
                ),
                SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: 'zoomOut',
                  mini: true,
                  child: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      zoomLevel -= 1;
                      mapController.move(cityLatLng, zoomLevel);
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherCard(BuildContext context, WeatherModel weather) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${weather.temperature.round()}°C',
                    style: Theme
                        .of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme
                          .of(context)
                          .primaryColor,
                    )),
                Text(weather.description.toUpperCase(),
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge),
              ],
            ),
            Icon(
              _getWeatherIcon(weather.description),
              size: 80,
              color: Theme
                  .of(context)
                  .primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetails(BuildContext context, WeatherModel weather) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Détails Météorologiques',
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildDetailRow(context, Icons.opacity, 'Humidité',
                '${weather.humidity.round()}%'),
            _buildDetailRow(context, Icons.air, 'Vitesse du vent',
                '${weather.windSpeed} m/s'),
            _buildDetailRow(
                context, Icons.compress, 'Pression', '${weather.pressure} hPa'),
            _buildDetailRow(
                context,
                Icons.location_on,
                'Coordonnées',
                '${weather.latitude.toStringAsFixed(2)}, ${weather.longitude
                    .toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String label,
      String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme
              .of(context)
              .primaryColor),
          SizedBox(width: 12),
          Expanded(
            child: Text(label, style: Theme
                .of(context)
                .textTheme
                .bodyMedium),
          ),
          Text(
            value,
            style: Theme
                .of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyForecastHorizontal(BuildContext context, List<HourlyForecast> forecast) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Prévisions par heure',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: forecast.length,
              separatorBuilder: (context, index) => SizedBox(width: 12),
              itemBuilder: (context, index) {
                final hour = forecast[index];
                return Container(
                  width: 90,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(0.15),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        hour.time,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Image.network(
                        'https://openweathermap.org/img/wn/${hour.iconCode}@2x.png',
                        width: 36,
                        height: 36,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Icon(Icons.wb_cloudy, size: 36),
                      ),
                      Text(
                        '${hour.temp.round()}°C',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
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
}
