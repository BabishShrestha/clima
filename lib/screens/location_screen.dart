import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherData});
  final weatherData;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String? weatherAnimation;
  String? message;
  int? temperature;
  String? city;
  WeatherModel weatherModel = WeatherModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.weatherData);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        print(weatherData);
        temperature = 0;
        message = 'Not Found';
        weatherAnimation = 'assets/404-notfound.json';
        city = '';
        return;
      }
      double temp;
      temp = weatherData['main']['temp'];
      var condition = weatherData['weather'][0]['id'];
      print(condition);
      weatherAnimation = weatherModel.getWeatherIcon(condition!);
      temperature = temp.toInt();
      message = weatherModel.getMessage(temperature!);
      city = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    var ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          var weatherData = await weatherModel.getWeatherData();

          setState(() {
            updateUI(weatherData);
          });
        },
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text("Clima"),
                leading: Image(
                  image: AssetImage("assets/clima.png"),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Text(
                          '$temperature°',
                          style:
                              kLocationScreenTextStyle.copyWith(fontSize: 60),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: ScreenWidth * 0.4,
                          ),
                        ),
                        Lottie.asset('$weatherAnimation',
                            width: 100, height: 100, fit: BoxFit.contain),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Text(
                          '$city ',
                          style: kLocationScreenTextStyle,
                        ),
                        const Icon(
                          Icons.location_on,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Text(
                          '$message ',
                          style: kLocationScreenTextStyle,
                        ),
                        const Icon(
                          Icons.location_on,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
