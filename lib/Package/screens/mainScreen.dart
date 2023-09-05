import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:havadurumu/Package/utils/weather.dart';

class MainScreen extends StatefulWidget {
  final WeatherData weatherData;
  const MainScreen({super.key, required this.weatherData});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int? tempperature;
  Icon? weatherDisplayIcon;
  late AssetImage backgrondImage;
  String? city;

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      tempperature = weatherData.currentTemperature!.round();
      city = weatherData.city;
      weatherDisplayData? weatherDisplay = weatherData.getWeatherDisplayData();
      if (weatherDisplay != null) {
        backgrondImage = weatherDisplay.weatherImage;
        weatherDisplayIcon = weatherDisplay.weatherIcon;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgrondImage,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              child: weatherDisplayIcon,
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "$tempperature°",
                style: TextStyle(
                    fontSize: 80.0, color: Colors.white, letterSpacing: -5),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "$city",
                style: TextStyle(
                    fontSize: 50.0, color: Colors.black, letterSpacing: -5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
