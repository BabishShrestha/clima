import 'package:clima/services/networking.dart';

import '../services/location.dart';

const apiKey = "78b56619523654f68e045c6b60e17bef";
const weatherUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getWeatherData() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.longitude);
    print(location.latitude);
    NetworkHelper networkHelper = NetworkHelper(
        '$weatherUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return 'assets/thunderstorm.json';
    } else if (condition < 400) {
      return 'assets/light-rain.json';
    } else if (condition < 600) {
      return 'assets/heavy-rain.json';
    } else if (condition < 700) {
      return 'assets/moderate-snow.json';
    } else if (condition < 800) {
      return 'assets/foggy.json';
    } else if (condition == 800) {
      return 'assets/sunny_animation.json';
    } else if (condition <= 802) {
      return 'assets/weather_cloudysunny_animation.json';
    } else if (condition <= 804) {
      return 'assets/overcast.json';
    } else {
      return 'assets/404-notfound.json';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
