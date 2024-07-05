import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Home/homescreen.dart';
import '../Services/weatherData.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    checkLocationPermission();
  }

  void checkLocationPermission() async {
    var status = await Permission.location.request();

    if (status == PermissionStatus.granted) {
      var accuracy = Permission.location.value;
      print(accuracy);

      getLocation();
    } else {
      showPermissionDialog();
    }
  }

  void showPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Location Permission Required"),
          content: Text(
              "This app needs location access to provide weather information. Please grant location permission."),
          actions: <Widget>[
            TextButton(
              child: Text("Deny"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Settings"),
              onPressed: () {
                openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }

  void getLocation() async {
    try {
      var weatherData = await WeatherModel().getLocationWeather();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomePage(
              locationWeather: weatherData,
            );
          },
        ),
      );
    } catch (e) {
      showErrorDialog();
    }
  }

  void showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(
              "An error occurred while fetching weather data. Please try again later."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SpinKitDualRing(
          color: Colors.blue,
          size: 50.0,
        ),
      ),
    );
  }
}
