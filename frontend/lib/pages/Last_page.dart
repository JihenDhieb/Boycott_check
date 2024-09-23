import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          _buildBackgroundCircle(160, 100, Colors.red, 90, 50),
          _buildBackgroundCircle(290, 210, Color(0xFF09FBD3), 70, 50),
          _buildImageCircle(),
          _buildText(
              "Thank you very much for \ntrying to help people", 480, 38, 30),
          _buildText(
            'شكرًا جزيلاً لكم على محاولة مساعدة الناس',
            570,
            45,
            20,
            isArabic: true,
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundCircle(double top, double left, Color color,
      double spreadRadius, double blurRadius) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              spreadRadius: spreadRadius,
              blurRadius: blurRadius,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCircle() {
    return Positioned(
        top: 100,
        left: 30,
        child: Center(
            child: Container(
          width: 338,
          height: 338,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Colors.red, Colors.white, Color(0xFF09FBD3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Container(
              width: 328,
              height: 328,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/thank.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        )));
  }

  Widget _buildText(String text, double top, double left, double fontSize,
      {bool isArabic = false}) {
    return Positioned(
      top: top,
      left: left,
      child: Text(
        text,
        style: GoogleFonts.flamenco(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: isArabic ? FontWeight.normal : FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
