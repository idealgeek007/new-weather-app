import 'package:flutter/material.dart';
import 'dart:math';

class SunMoonPath extends StatelessWidget {
  final DateTime sunrise;
  final DateTime sunset;
  final DateTime moonrise;
  final DateTime moonset;

  SunMoonPath({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    if (now.isAfter(sunrise) && now.isBefore(sunset)) {
      return SunPath(sunrise: sunrise, sunset: sunset);
    } else {
      return NightPath(moonrise: moonrise, moonset: moonset);
    }
  }
}

class SunPath extends StatefulWidget {
  final DateTime sunrise;
  final DateTime sunset;

  SunPath({required this.sunrise, required this.sunset});

  @override
  _SunPathState createState() => _SunPathState();
}

class _SunPathState extends State<SunPath> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double sunPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(hours: 12), // Adjust the duration for a full day cycle
      vsync: this,
    )..repeat(reverse: false); // Continuously animate

    _calculateSunPosition();
  }

  void _calculateSunPosition() {
    final now = DateTime.now();
    final totalDuration = widget.sunset.difference(widget.sunrise).inSeconds;
    final currentDuration = now.difference(widget.sunrise).inSeconds;

    if (currentDuration < 0 || currentDuration > totalDuration) {
      sunPosition = currentDuration < 0 ? 0 : 1;
    } else {
      sunPosition = currentDuration / totalDuration;
    }
    _controller.value = sunPosition;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: Text(
              widget.sunrise
                  .toLocal()
                  .toString()
                  .split(' ')[1]
                  .substring(0, 5), // Sunrise time
              style: TextStyle(color: Colors.white),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Text(
              widget.sunset
                  .toLocal()
                  .toString()
                  .split(' ')[1]
                  .substring(0, 5), // Sunset time
              style: TextStyle(color: Colors.white),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: ArcPainter(_controller.value),
                child: Center(
                  child: Transform.translate(
                    offset: Offset(
                      150 * cos(_controller.value * pi - pi / 2),
                      150 * sin(_controller.value * pi - pi / 2),
                    ),
                    child: SunIcon(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class NightPath extends StatefulWidget {
  final DateTime moonrise;
  final DateTime moonset;

  NightPath({required this.moonrise, required this.moonset});

  @override
  _NightPathState createState() => _NightPathState();
}

class _NightPathState extends State<NightPath>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double moonPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration:
          Duration(hours: 12), // Adjust the duration for a full night cycle
      vsync: this,
    )..repeat(reverse: false); // Continuously animate

    _calculateMoonPosition();
  }

  void _calculateMoonPosition() {
    final now = DateTime.now();
    final totalDuration = widget.moonset.difference(widget.moonrise).inSeconds;
    final currentDuration = now.difference(widget.moonrise).inSeconds;

    if (currentDuration < 0 || currentDuration > totalDuration) {
      moonPosition = currentDuration < 0 ? 0 : 1;
    } else {
      moonPosition = currentDuration / totalDuration;
    }
    _controller.value = moonPosition;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: Text(
              widget.moonrise
                  .toLocal()
                  .toString()
                  .split(' ')[1]
                  .substring(0, 5), // Moonrise time
              style: TextStyle(color: Colors.black),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Text(
              widget.moonset
                  .toLocal()
                  .toString()
                  .split(' ')[1]
                  .substring(0, 5), // Moonset time
              style: TextStyle(color: Colors.black),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: MoonArcPainter(_controller.value),
                child: Center(
                  child: Transform.translate(
                    offset: Offset(
                      150 * cos(_controller.value * pi - pi / 2),
                      150 * sin(_controller.value * pi - pi / 2),
                    ),
                    child: MoonIcon(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  final double progress;

  ArcPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.yellow, Colors.red],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2), radius: 150))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final Rect rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 150);
    canvas.drawArc(rect, -pi, pi, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class MoonArcPainter extends CustomPainter {
  final double progress;

  MoonArcPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.blue, Colors.indigo],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2), radius: 150))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final Rect rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 150);
    canvas.drawArc(rect, -pi, pi, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class SunIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.yellow,
        boxShadow: [
          BoxShadow(
            color: Colors.yellow.withOpacity(0.6),
            spreadRadius: 8,
            blurRadius: 16,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.wb_sunny,
          color: Colors.orange,
          size: 30,
        ),
      ),
    );
  }
}

class MoonIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.6),
            spreadRadius: 8,
            blurRadius: 16,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.brightness_2,
          color: Colors.grey,
          size: 30,
        ),
      ),
    );
  }
}
