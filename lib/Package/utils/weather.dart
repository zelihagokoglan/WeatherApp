import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'location.dart';
import 'package:flutter/cupertino.dart';

const apiKey = "6bc42c75b40625bcc475efb58f152a26";

class weatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;
  weatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData {
  WeatherData({@required this.locationData});
  LocationHelper? locationData;
  double? currentTemperature;
  int? currentCondition;
  String? city;

  Future<void> getCurrentTemperature() async {
    final response = await get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${locationData?.latitude}&lon=${locationData?.longitude}&appid=$apiKey&units=metric"));
    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);
      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]["id"];
        city = currentWeather['name'];
      } catch (e) {
        print(e);
      }
    } else {
      print("API den deger gelmiyor");
    }
  }

  weatherDisplayData? getWeatherDisplayData() {
    if (currentCondition! < 600) {
      return weatherDisplayData(
          weatherIcon: Icon(
            FontAwesomeIcons.cloud,
            size: 75.0,
            color: Colors.white,
          ),
          weatherImage: AssetImage("assets/bulutlu.jpg"));
    } else {
      var now = new DateTime.now();
      if (now.hour >= 19) {
        return weatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.moon,
              size: 75.0,
              color: Colors.white,
            ),
            weatherImage: AssetImage("assets/gece.jpg"));
      } else {
        return weatherDisplayData(
            weatherIcon: Icon(
              FontAwesomeIcons.sun,
              size: 75.0,
              color: Colors.white,
            ),
            weatherImage: AssetImage("assets/gunesli.jpg"));
      }
    }
  }
}
