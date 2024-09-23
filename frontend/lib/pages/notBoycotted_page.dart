import 'package:flutter/material.dart';
import 'package:flutter_app/pages/Last_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart'; // Import necessary for WidgetsBinding

class notboycotted extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<notboycotted> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Page4()),
      );
    });
  }

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
          _buildBackgroundCircle(140, 90, Colors.red),
          _buildBackgroundCircle(290, 220, Color(0xFF09FBD3)),
          _buildImageCircle(),
          _buildText("Buy this product \nit is not boycotted", 480, 90, 30),
          _buildText(
            'اشتروا هذا المنتج فإنه ليس محل مقاطعة',
            570,
            40,
            20,
            isArabic: true,
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundCircle(double top, double left, Color color) {
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
              spreadRadius: 70,
              blurRadius: 50,
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
                  'assets/images/3.jpeg',
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
