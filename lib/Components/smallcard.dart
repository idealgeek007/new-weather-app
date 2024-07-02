import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:weather_app/Utils/SizeConfig.dart';

class SmallCard extends StatelessWidget {
  final String name;
  final String value;
  final String imagePath;

  const SmallCard({
    Key? key,
    required this.name,
    required this.imagePath,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      width: SizeConfig.screenWidth * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
          colors: [
            Color(0xFFACCCFD),
            Color(0xFFACCCFD),
            Color(0xFFACCCFD),
            Color(0xFF78A2E8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: width * 0.15,
              height: width * 0.15,
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: GoogleFonts.rubik(
                fontSize: width * 0.07,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              value,
              style: GoogleFonts.rubik(
                fontSize: width * 0.07,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
