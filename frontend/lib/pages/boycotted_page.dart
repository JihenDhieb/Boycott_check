import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class boycotted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _buildBackgroundCircle(140, 90, Colors.red, 70, 50),
          _buildBackgroundCircle(290, 220, Color(0xFF09FBD3), 70, 50),
          _buildImageCircle(),
          _buildText("Don't buy this product \nit is boycotted", 480, 60, 30),
          _buildText(
            'لا تشتروا هذا المنتج إنه محل مقاطعة',
            570,
            70,
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
        left: 39,
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
              decoration: BoxDecoration(shape: BoxShape.circle),
              width: 328,
              height: 328,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/2.jpeg',
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
