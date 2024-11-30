import 'package:checkkhodam/screens/explanation_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add AppBar with an image
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/CHECKHODAM_1.png', // Your image in AppBar
              height: 20, // Adjust the height as needed
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Black background
          Container(
            color: Colors.black,
          ),
          // Positioned image at the bottom-left
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/images/Ellipse 60.png',
              fit: BoxFit.none, // Ensure no scaling of the image
            ),
          ),
          // Centered text content and button
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align content to the left
            children: [
              const Padding(
                padding: EdgeInsets.only(
                    left: 20.0, top: 150.0), // Padding from the left and top
                child: Text(
                  'A VISUALIZATION\nOF YOUR\nKHODAM JOURNEY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontFamily: 'kannada-sangam-mn',
                  ),
                ),
              ),
              // Spacing between the text and button
              const SizedBox(height: 20), // Adjust the height as needed
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: SizedBox(
                  width: 240,
                  height: 60, // Button height
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(_createRoute());
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor:
                          Colors.transparent, // Transparent background
                      side: const BorderSide(
                        color: Colors.white, // White outline
                        width: 2.0, // Border thickness
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners
                      ),
                    ),
                    child: const Text(
                      "I'M READY TO BEGIN",
                      style: TextStyle(
                        color: Colors.white, // White text
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ExplanationPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Swipe from right to left
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
