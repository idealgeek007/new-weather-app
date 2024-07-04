import 'package:flutter/material.dart';
import 'package:weather_app/Home/homescreen.dart';
import 'package:weather_app/LoadingScreen/loadingscreen.dart';

import 'Utils/SizeConfig.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: LoadingScreen(),
    );
  }
}
