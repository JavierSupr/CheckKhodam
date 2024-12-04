import 'package:flutter/material.dart';
import 'privacy_policy_page.dart'; // Import your next page

class ExplanationPage extends StatelessWidget {
  const ExplanationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add AppBar with an image
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back to the previous page
          },
        ),
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
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_expl_page.png',
              fit: BoxFit.fill, // Ensure no scaling of the image
            ),
          ),
          
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
                  'Rasakan ketegangan yang mencekam saat kau sadar bahwa ada sosok tak kasat mata yang telah mengawasi setiap gerakmu, bahkan saat kau terlelap dalam tidurmu. Bayangannya selalu ada, menunggu saat yang tepat untuk menampakkan diri.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'micross',
                  ),textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
          // Positioned Button that can be moved freely
          Positioned(
            bottom: 100, // Adjust this as needed
            left: MediaQuery.of(context).size.width / 2 - 90, // Adjust the distance from the left here
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
