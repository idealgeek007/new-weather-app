import 'network.dart';
import 'location.dart';

const apikey = '801c2fd8726c4230bb473334230512';
const weatherApi = 'http://api.weatherapi.com/v1/forecast.json?key=$apikey';

class WeatherModel {
  // Get weather information from APi from given city name

  Future<dynamic> getCityWeather(String typedname) async {
    var url =
        'https://api.weatherapi.com/v1/forecast.json?key=$apikey&q=$typedname&days=7';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = networkHelper.getData();
    return weatherData;
  }

  // Get weather data of current device location

  Future<dynamic> getLocationWeather() async {
    LocationService location = LocationService();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$weatherApi&q=${location.latitude},${location.longitude}&aqi=no');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  // function to give location of weather condition images displayed on weather page card

  String getWeatherIcon(int condition, int isday) {
    if (condition == 1000) {
      if (isday == 1) {
        return 'assets/conditions/clear.png';
      } else {
        return 'assets/conditions/moon.png';
      }
    } else if (condition == 1003 || condition == 1006 || condition == 1009) {
      if (isday == 1) {
        return 'assets/conditions/cloudy.png';
      } else {
        return 'assets/conditions/cloudynight.png';
      }
    } else if (condition == 1030 || condition == 1135 || condition == 1147) {
      return 'assets/conditions/fog.png';
    } else if ((condition >= 1063 && condition <= 1201) ||
        (condition >= 1240 && condition <= 1276)) {
      return 'assets/conditions/rain.png';
    } else if (condition == 1087 || (condition >= 1273 && condition <= 1276)) {
      return 'assets/conditions/storm.png';
    } else if ((condition >= 1066 && condition <= 1117) ||
        (condition >= 1204 && condition <= 1264) ||
        (condition >= 1279 && condition <= 1282)) {
      return 'assets/conditions/snow.png';
    } else if (condition == 1117 || condition == 1246 || condition == 1282) {
      return 'assets/conditions/extreme.png';
    } else {
      return 'assets/conditions/extreme.png';
    }
  }
}
