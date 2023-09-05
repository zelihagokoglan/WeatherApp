import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:havadurumu/Package/screens/mainScreen.dart';
import 'package:havadurumu/Package/utils/location.dart';
import 'package:havadurumu/Package/utils/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  LocationHelper? locationData;
  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData?.getCurrentLocation();
    if (locationData?.latitude == null || locationData?.longitude == null) {
      print("konum bilgileri gelmiyor");
    } else {
      print("latitude:" + locationData!.latitude.toString());
      print("longitue::" + locationData!.longitude.toString());
    }
  }

  void getWeatherData() async {
    await getLocationData();
    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();
    if (weatherData.currentTemperature == null ||
        weatherData.currentCondition == null) {
      print("API den sicaklik  ve durum bilgisi gelmiyor..");
    }
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return MainScreen(
          weatherData: weatherData,
        );
      },
    ));
  }

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.orangeAccent, Colors.yellowAccent]),
        ),
        child: Center(
          child: SpinKitDualRing(
            color: Colors.white,
            size: 120.0,
            duration: Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }
}
