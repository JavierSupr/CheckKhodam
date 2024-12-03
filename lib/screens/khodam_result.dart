import 'package:flutter/material.dart';

class KhodamResultPage extends StatelessWidget {
  final String title;
  final String description;

  // Constructor to accept title and description
  const KhodamResultPage({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

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
        color: Colors.black,
        child: Stack(
          children: [
            // Background images
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                'assets/images/Ellipse 65.png',
                fit: BoxFit.none,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                'assets/images/Ellipse 67.png',
                fit: BoxFit.none,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                'assets/images/Ellipse 69.png',
                fit: BoxFit.none,
              ),
            ),
            // Main content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: "DEATH_FONT",
                      fontSize: 32,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Display dynamic description
                  Text(
                    description.isNotEmpty
                        ? description
                        : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea.",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'PERSONAL TRAITS',
                      style: TextStyle(
                        fontFamily: "DEATH_FONT",
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTraitProgressBar('EXTROVERT', Colors.blue, 0.7),
                  const SizedBox(height: 20),
                  _buildTraitProgressBar('HUNGER', Colors.red, 0.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTraitProgressBar(String label, Color color, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: "DEATH_FONT",
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: color.withOpacity(0.3),
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }
}
