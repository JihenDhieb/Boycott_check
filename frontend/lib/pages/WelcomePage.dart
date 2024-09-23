import 'package:flutter/material.dart';
import 'package:flutter_app/pages/Home_Page.dart';
import 'package:google_fonts/google_fonts.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _buildCircle(150, 210, Color(0xFF09FBD3)),
          _buildCircle(290, 90, Colors.red),
          _buildGradientCircle(context),
          _buildTitleText("Let's save Palestine \nwith boycott", 500, 80),
          _buildTitleText('لننقذ فلسطين بالمقاطعة', 590, 110),
          _buildActionButton(context),
        ],
      ),
    );
  }

  Widget _buildCircle(double top, double left, Color color) {
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
              color: color.withOpacity(0.8),
              spreadRadius: 70,
              blurRadius: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientCircle(BuildContext context) {
    return Positioned(
      top: 100,
      left: 36,
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
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/1.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleText(String text, double top, double left) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        child: Text(
          text,
          style: GoogleFonts.flamenco(
            color: Colors.white,
            fontSize: top == 500 ? 30 : 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return Positioned(
      top: 640,
      left: 137,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        child: Container(
          width: 100,
          height: 40.0,
          child: ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                colors: [Colors.red, Color(0xFF09FBD3)],
                tileMode: TileMode.mirror,
              ).createShader(rect);
            },
            child: Center(
              child: Text(
                "Let's Go",
                style: GoogleFonts.flamenco(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
