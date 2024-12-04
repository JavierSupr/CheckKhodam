import 'package:flutter/material.dart';
import 'dart:io'; // Import to use File

class KhodamResultPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final double extrovert;
  final double introvert;
  final String jomok_level;
  final String love_language;
  final String people;

  const KhodamResultPage(
      {Key? key,
      required this.title,
      required this.description,
      required this.imagePath,
      required this.extrovert,
      required this.introvert,
      required this.jomok_level,
      required this.love_language,
      required this.people})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> peopleList = people.split(',');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/CHECKHODAM_1.png',
              height: 20,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Stack(
            children: [
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          FileImage(File(imagePath)), // Use FileImage
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
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'PERSONAL TRAITS',
                        style: TextStyle(
                          fontFamily: "boxpot",
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTraitProgressBar('extrovert', Colors.blue, extrovert),
                    const SizedBox(height: 20),
                    _buildTraitProgressBar('introvert', Colors.red, introvert),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft, // Align to the left
                      child: _buildTraitText(
                          'jomok level', Colors.green, jomok_level),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft, // Align to the left
                      child: _buildTraitText(
                          'love language',
                          const Color.fromARGB(255, 233, 194, 135),
                          love_language),
                    ),
                    const SizedBox(height: 40),
                    // People list below
                    const Text(
                      'PEOPLE WHO HAVE SIMILAR TRAITS',
                      style: TextStyle(
                        fontFamily: "boxpot",
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildPeopleList(peopleList),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTraitText(String label, Color color, String value) {
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
        Text(
          value,
          style: TextStyle(
            fontFamily: 'micross',
            fontSize: 16,
            color: color,
          ),
        ),
      ],
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
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: color.withOpacity(0.3),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${(progress * 100).toStringAsFixed(0)}%', // Convert progress to percentage
              style: TextStyle(
                fontFamily: 'micross',
                fontSize: 16,
                color: color,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPeopleList(List<String> peopleList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(peopleList.length, (index) {
        return Column(
          children: [
            Text(
              peopleList[index],
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 1,
            ),
          ],
        );
      }),
    );
  }
}
