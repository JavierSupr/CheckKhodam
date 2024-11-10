import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/CHECKHODAM_1.png', // Logo in AppBar
              height: 20,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background color
          Container(
            color: Colors.black,
          ),
          // Positioned images
          Positioned(
            top: -70,
            right: 0,
            child: Image.asset(
              'assets/images/Ellipse 70.png',
              fit: BoxFit.none,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/images/Ellipse 71.png',
              fit: BoxFit.none,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/images/Rectangle 353.png',
              fit: BoxFit.none,
            ),
          ),
          // Centered content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //const SizedBox(height: 20),
                _buildMenuButton(
                  'assets/images/Group 5.png',
                  'CHECKODAM',
                  () {
                    // Add navigation logic here
                  },
                ),
                //const SizedBox(height: 20),
                _buildMenuButton(
                  'assets/images/Group 6.png',
                  'KHODAM QUIZ',
                  () {
                    // Add navigation logic here
                  },
                ),
                //const SizedBox(height: 20),
                _buildMenuButton(
                  'assets/images/Group 7.png',
                  'KHODAM XPLORE',
                  () {
                    // Add navigation logic here
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(
      String imagePath, String text, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 180,
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              child: Center(
                child: Image.asset(
                  imagePath,
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'DEATH_FONT',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
