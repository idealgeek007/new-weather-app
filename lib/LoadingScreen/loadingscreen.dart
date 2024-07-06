import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart' as perm;

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

  // Check if location permission is given
  void checkLocationPermission() async {
    loc.Location location = loc.Location();

    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        showPermissionDialog();
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    print("\n\n\n\n\n\n");
    print(loc.PermissionStatus);
    print("\n\n\n\n\n\n");
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        showPermissionDialog();
        return;
      }
    }

    getLocation();
  }

  // If permission not given show dialog box to open settings
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
                SystemNavigator.pop();
              },
            ),
            TextButton(
              child: Text("Settings"),
              onPressed: () {
                perm.openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }

  // get initial location and weather data
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
