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

    return Column(
      children: [
        Container(
          width: SizeConfig.screenWidth * 0.2,
          height: SizeConfig.screenWidth * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Color(
                  0xFFC9DBF9,
                ),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.5),
                offset: Offset(5, 5),
                blurRadius: 50,
                spreadRadius: 3,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              imagePath,
              width: width * 0.15,
              height: width * 0.15,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: GoogleFonts.poppins(
            fontSize: width * 0.034,
            color: Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
