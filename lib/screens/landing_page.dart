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
      body: Container(
        color: Colors.black, // Set the background color to black
        child: Stack(
          children: [
            // Background images
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
            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
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
                  const SizedBox(height: 20), // Space between buttons
                  Column(
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
                  const SizedBox(height: 20),
                  Column(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
