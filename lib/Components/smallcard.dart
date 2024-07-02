import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

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
      decoration: BoxDecoration(
        color: Color(0xffF8F8F9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: width * 0.2,
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
    );
  }
}
