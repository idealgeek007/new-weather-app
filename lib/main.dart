import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:weather_app/LoadingScreen/loadingscreen.dart';

import 'Utils/SizeConfig.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<String>('recentCitiesBox');
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
