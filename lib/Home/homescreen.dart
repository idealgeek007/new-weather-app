import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:weather_app/Components/smallcard.dart';
import 'package:weather_app/Utils/SizeConfig.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Store city, date, temperature, and condition in variables
  String city = 'London'; // Replace with actual city
  String date = 'July 10, 2023'; // Replace with actual date
  int temperature = 27;
  String condition = 'Sunny'; // Replace with actual condition

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
            ), // Rotate the gradient by 90 degrees
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: width * 0.2),
            Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientText(
                    city, // Use city variable
                    style: GoogleFonts.lato(
                      fontSize: width * 0.15,
                      fontWeight: FontWeight.bold,
                    ),
                    colors: [
                      Color(0xFF90CAF9),
                      Color(0xFF42A5F5),
                    ],
                  ),
                  Text(
                    date, // Use date variable
                    style: GoogleFonts.lato(
                        fontSize: width * 0.07,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
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
                        ), // Rotate the gradient by 90 degrees
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
                  child: Image.asset(
                      "assets/weathericons/9.png"), // Replace with dynamic icon based on condition
                ),
                Positioned(
                  top: 20,
                  right: 40,
                  child: GradientText(
                    '$temperature°C', // Use temperature variable
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
                    'Condition',
                    style: GoogleFonts.lato(
                      fontSize: width * 0.1,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SmallCard(
              name: 'Wind',
              imagePath: "assets/weathericons/4.png",
              value: '17m/s',
            )
          ],
        ),
      ),
    );
  }
}
