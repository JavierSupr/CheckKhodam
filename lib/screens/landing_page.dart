import 'package:checkkhodam/screens/about_us.dart';
import 'package:checkkhodam/screens/camera_page.dart';
import 'package:checkkhodam/screens/privacy_policy_page.dart';
import 'package:checkkhodam/screens/tnc.dart';
import 'khodam_xplore.dart';
import 'package:checkkhodam/screens/quiz_pages/quiz_page_0.dart';

import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // Function to navigate to CameraPage
  void _navigateToCameraPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CameraPage()),
    );
  }

  // Function to navigate to KhodamXplorePage
  void _navigateToKhodamXplorePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const KhodamXplorePage()),
    );
  }

  void _navigateToQuizPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QuizPage0()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Correct context
              },
            );
          },
        ),
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
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.transparent, // Transparan agar gambar terlihat
                ),
                child: Text(
                  'CheckKhodam',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'DEATH_FONT',
                    fontSize: 45,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.article, color: Colors.white),
                title: const Text(
                  'Terms and Conditions',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'kannada-sangam-mn'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TnCPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.info, color: Colors.white),
                title: const Text(
                  'About Us',
                  style: TextStyle(color: Colors.white, fontFamily: 'micross'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUsPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.black, // Set the background color to black
        child: Stack(
          children: [
            // Background images
            Positioned.fill(
              child: Image.asset(
                'assets/images/bg_aboutUs.png',
                fit: BoxFit.fill,
              ),
            ),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _navigateToCameraPage,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 160, // Adjust the overall size of the Stack
                          height: 120,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      Colors.white, // Inner color
                                      Colors.blue, // Outer color
                                    ],
                                    center: Alignment(-0.5, -0.3),
                                    radius:
                                        0.2, // Adjust the spread of the gradient
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 15, // Adjust the vertical position
                                child: Image.asset(
                                  'assets/images/Group 43.png', // Replace with your image path
                                  width: 160, // Adjust image size
                                  height: 107,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                            height: 8), // Space between the button and text
                        const Text(
                          'CHECKHODAM',
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: "DEATH_FONT",
                              color: Colors.white), // White text for contrast
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _navigateToQuizPage, // Space between buttons
                    child: Column(
                      children: [
                        SizedBox(
                          width: 160,
                          height: 120,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      Colors.white, // Inner color
                                      Color.fromARGB(
                                          233, 88, 88, 88), // Outer color
                                    ],
                                    center: Alignment(0.05, 0.45),
                                    radius:
                                        0.3, // Adjust the spread of the gradient
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 30, // Adjust the vertical position
                                child: Image.asset(
                                  'assets/images/Group 45.png',
                                  width: 170,
                                  height: 85,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'KHODAM QUIZ',
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: "DEATH_FONT",
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _navigateToKhodamXplorePage,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 160,
                          height: 120,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      Colors.white, // Inner color
                                      Color.fromARGB(
                                          197, 255, 0, 0), // Outer color
                                    ],
                                    center: Alignment(-0.1, -0.1),
                                    radius:
                                        0.4, // Adjust the spread of the gradient
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 15, // Adjust the vertical position
                                child: Image.asset(
                                  'assets/images/Group 47.png',
                                  width: 160,
                                  height: 107,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'KHODAM XPLORE',
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: "DEATH_FONT",
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
