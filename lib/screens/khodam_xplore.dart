import 'package:flutter/material.dart';

class KhodamXplorePage extends StatelessWidget {
  const KhodamXplorePage({super.key});

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
            // Title at the top
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'KHODAM XPLORE',
                  style: TextStyle(
                    fontFamily: "DEATH_FONT",
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Main content
            ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 10),
              itemCount: 5, // Adjust the number of items as needed
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: index % 2 == 0
                          ? [
                              Colors.blue.withOpacity(0.5),
                              Colors.blueAccent.withOpacity(0.5)
                            ]
                          : [
                              Colors.red.withOpacity(0.5),
                              Colors.redAccent.withOpacity(0.5)
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ListTile(
                    leading: Image.asset(
                        'assets/images/Ellipse 67.png'), // Replace with your image path
                    title: const Text(
                      'KIPLI PENYERANG',
                      style: TextStyle(
                        fontFamily: "DEATH_FONT",
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      // Placeholder for button functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('You tapped item #$index'),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
