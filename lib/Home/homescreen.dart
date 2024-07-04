import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:weather_app/Components/smallcard.dart';
import 'package:weather_app/Components/sunPath.dart';
import 'package:weather_app/Utils/SizeConfig.dart';
import '../Search/searchPage.dart';
import '../Services/weatherData.dart';

class HomePage extends StatefulWidget {
  HomePage({this.locationWeather});

  final locationWeather;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel weather = WeatherModel();
  final GlobalKey _columnKey = GlobalKey();

  int? temp;
  String? cityName;
  String? condition;
  String? weatherIcon;
  String? weatherMessage;
  String? time;
  late String localtime;
  late double windspeed;
  late int humidity;
  int? rain;
  late String imageUrl;
  late int isDay;
  late int code;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temp = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        windspeed = 0;
        rain = 0;
        humidity = 0;
        localtime = '';
        condition = 'Not Found';
        showWeatherDataNotFoundPopup();
        return;
      }
      double temperature = weatherData['current']['temp_c'];
      time = weatherData['location']['localtime'];

      temp = temperature.toInt();
      condition = weatherData['current']['condition']['text'];
      cityName = weatherData['location']['name'];
      localtime = weatherData['location']['localtime'];
      windspeed = weatherData['current']['wind_kph'];
      humidity = weatherData['current']['humidity'];
      code = weatherData['current']['condition']['code'];
      rain = weatherData['forecast']?['forecastday']?['0']['day']
          ['daily_chance_of_rain'];

      isDay = weatherData['current']['is_day'];
      if (rain == null) {
        rain = 0;
      }
    });

    imageUrl = weather.getWeatherIcon(code, isDay);
  }

  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.screenWidth;
    return Scaffold(
      backgroundColor: Color(0xffFBFCFE),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.white,
              Color(0xFFACCCFD),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            transform: GradientRotation(
              0.25 * pi,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: width * 0.1),
            Center(
              child: GestureDetector(
                onTap: () async {
                  var typedName = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CityScreen()),
                  );
                  if (typedName != null) {
                    var weatherData = await weather.getCityWeather(typedName);
                    updateUI(weatherData);
                  }
                },
                child: Container(
                  width: width * 0.8,
                  height: width * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.5),
                        offset: Offset(5, 5),
                        blurRadius: 50,
                        spreadRadius: 3,
                        blurStyle: BlurStyle.inner,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        Text(
                          'Search',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: width * 0.09,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.search, size: 45),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: width * 0.05),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cityName ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: width * 0.12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "$localtime",
                        style: GoogleFonts.poppins(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Image.asset(
                      "assets/weathericons/map.png",
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: width * 0.1),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFACCCFD),
                          Color(0xFFACCCFD),
                          Color(0xFFACCCFD),
                          Color(0xFF78A2E8),
                          Color(0xFF5896FD),
                          Color(0xFF5896FD),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        transform: GradientRotation(
                          0.25 * pi,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.4),
                          spreadRadius: 0,
                          blurRadius: 12,
                          offset: Offset(0, 5),
                          blurStyle: BlurStyle.normal,
                        ),
                      ],
                    ),
                    height: SizeConfig.screenWidth * 0.5,
                    width: SizeConfig.screenWidth * 0.9,
                  ),
                ),
                Positioned(
                  top: -30,
                  left: 35,
                  width: width * 0.4,
                  child: Image.asset(imageUrl),
                ),
                Positioned(
                  top: 20,
                  right: 40,
                  child: GradientText(
                    '$temp°C', // Use temperature variable
                    style: GoogleFonts.rubik(
                      fontSize: width * 0.18,
                    ),
                    colors: [
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.blue,
                      Colors.blue,
                      Color(0xFF1976D2),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 40,
                  child: Text(
                    condition ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: width * 0.1,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: width * 0.1),
            Row(
              children: [
                Spacer(),
                SmallCard(
                  name: 'Wind',
                  imagePath: 'assets/weathericons/wind.png',
                  value: '$windspeed m/s',
                ),
                Spacer(),
                SmallCard(
                  name: 'Humidity',
                  imagePath: 'assets/weathericons/humidity2.png',
                  value: '$humidity%',
                ),
                Spacer(),
                SmallCard(
                  name: 'UV',
                  imagePath: 'assets/weathericons/UV.png',
                  value: '17m/s',
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 10),
            /*  Center(
              child: SunMoonPath(
                sunrise: DateTime(2024, 7, 4, 5, 30),
                sunset: DateTime(2024, 7, 4, 18, 30),
                moonrise: DateTime(2024, 7, 4, 18, 30),
                moonset: DateTime(2024, 7, 4, 5, 30),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  void showWeatherDataNotFoundPopup() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Weather Data Not Found"),
            content: Text("Please check the city entered."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    });
  }
}
