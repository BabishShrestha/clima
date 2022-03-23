import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getWeatherData();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LocationScreen(
          weatherData: weatherData,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const SpinKitCubeGrid(
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
