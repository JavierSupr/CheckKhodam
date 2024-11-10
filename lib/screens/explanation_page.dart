import 'package:flutter/material.dart';
import 'privacy_policy_page.dart'; // Import your next page

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

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
              'assets/images/Ellipse 62.png',
              fit: BoxFit.none, // Ensure no scaling of the image
            ),
          ),
          // Another positioned image at the bottom-left
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/images/Ellipse 63.png',
              fit: BoxFit.none, // Ensure no scaling of the image
            ),
          ),
          // Positioned image at the bottom-right
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/images/Ellipse 61.png',
              fit: BoxFit.none, // Ensure no scaling of the image
            ),
          ),
          // Centered text content
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align content to the left
            children: [
              const Padding(
                padding: EdgeInsets.only(
                    left: 20.0, top: 150.0), // Padding from the left and top
                child: Text(
                  'WELCOME TO',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    //fontWeight: FontWeight.bold,
                    fontFamily: 'kannada-sangam-mn',
                  ),
                ),
              ),
              // Spacing between texts
              const SizedBox(height: 10), // Spacing between text and image
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0), // Padding from the left
                child: Image.asset(
                  'assets/images/CHECKHODAM.png', // Replace with your image path
                  height: 60, // Set the desired height
                  //width: 150, // Set the desired width
                  fit: BoxFit
                      .contain, // You can use BoxFit to control how the image scales
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 20.0), // Padding from the left
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea', // New text below
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'micross',
                  ),
                ),
              ),
            ],
          ),
          // Positioned Button that can be moved freely
          Positioned(
            bottom: 60, // Adjust the distance from the bottom here
            left: 100, // Adjust the distance from the left here
            child: SizedBox(
              width: 180,
              height: 60, // Button height
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(_createRoute());
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent, // Transparent background
                  side: const BorderSide(
                    color: Colors.white, // White outline
                    width: 2.0, // Border thickness
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
                child: const Text(
                  'NEXT',
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
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          PrivacyPolicyPage(),
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
