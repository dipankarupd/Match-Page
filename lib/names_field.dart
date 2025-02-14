import 'dart:ui';

import 'package:flutter/material.dart';

class NameFields extends StatelessWidget {
  final String name;
  final String id;
  final bool isAdded; // New parameter to check if the user is added

  const NameFields({
    super.key,
    required this.name,
    required this.id,
    this.isAdded = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 15,
            letterSpacing: 0.56,
            color: Color.fromRGBO(227, 227, 227, 1),
            fontFamily: 'Jost',
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Stack(
          //alignment: Alignment.center,
          children: [
            Container(
              color: const Color(0xffFF0606).withOpacity(0.6),
              height: 20,
              width: 85,
            ),
            CustomPaint(
              size: const Size(30, 10),
              painter: EllipsePainter(fillColor: Colors.black),
              child: SizedBox(
                width: 85,
                height: 20,
                child: Center(
                  child: Text(id,
                      style: const TextStyle(
                        fontSize: 8,
                        letterSpacing: .8,
                      ),
                      textAlign: TextAlign.center),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 3,
        ),
        if (isAdded) // Conditionally show "Already added" row
          const Row(
            children: [
              Icon(Icons.check, color: Color(0xff00BE07), size: 15),
              SizedBox(width: 2),
              Text(
                'Already added',
                style: TextStyle(fontSize: 9, letterSpacing: .18),
              ),
            ],
          ),
      ],
    );
  }
}

class EllipsePainter extends CustomPainter {
  final Color fillColor;

  EllipsePainter({
    required this.fillColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Save the canvas layer to apply blur without affecting other drawings
    canvas.saveLayer(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..imageFilter = ImageFilter.blur(sigmaX: 25, sigmaY: 4), // Blur effect
    );

    // Draw the ellipse with no stroke (filled only)
    final Paint fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    // Adjust the ellipse rect to avoid artifacts (center it properly)
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2), // Center of canvas
        width: size.width,
        height: size.height,
      ),
      fillPaint,
    );

    // Restore the canvas after applying effects
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
