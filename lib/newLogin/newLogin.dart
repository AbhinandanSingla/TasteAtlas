import 'package:flutter/material.dart';

class NewLogin extends StatefulWidget {
  @override
  _NewLoginState createState() => _NewLoginState();
}

class _NewLoginState extends State<NewLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: centerPaint(),
        child: Container(),
      ),
    );
  }
}

class centerPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()..color;
    canvas.drawLine(
      Offset(20, 40),
      Offset(15, 82),
      paint1
    );
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
