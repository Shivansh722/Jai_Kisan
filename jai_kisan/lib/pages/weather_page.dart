import 'package:flutter/material.dart';
import 'package:jai_kisan/models/weather_model.dart';
import 'package:jai_kisan/services/weather_Service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService =
      WeatherService(apiKey: '0041daaa47f9d426227f3534327d6361');
  Weather? _weather;
  String? _iconUrl;

  _fetchWeather() async {

    String cityName = await _weatherService.getCurrentCity();
    print(cityName);

    try {
      final weather = await _weatherService.getWeather(cityName);
      final icon = await _weatherService.getWeatherIcon(weather.iconCode);
      setState(() {
        _weather = weather;
        _iconUrl = icon;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Text(_weather?.cityName ?? 'Loading...'),
        Text('${_weather?.temperature}C' ?? 'Loading...'),
      ],
    ));
  }
}
