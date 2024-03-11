class Weather{
  final String cityName;
  final double temperature;
  final String mainCondition;
  final String iconCode;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.iconCode,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];
    final temperature = json['main']['temp'].toDouble();
    final mainCondition = json['weather'][0]['main'];
    final iconCode = json['weather'][0]['icon'];
    return Weather(
      cityName: cityName,
      temperature: temperature - 273.15,
      mainCondition: mainCondition,
      iconCode: iconCode,
    );
  }
}