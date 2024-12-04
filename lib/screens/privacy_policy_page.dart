import 'package:checkkhodam/screens/landing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  Future<void> agreeToTerms(BuildContext context) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isAgreed', true);  // Set status persetujuan

      // Setelah setuju, langsung ke Landing Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LandingPage()),
      );
    }

  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  bool _isChecked = false; // Track if checkbox is checked

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
          Positioned.fill(
            child: Image.asset(
              'assets/images/Rectangle 354.png',
              fit: BoxFit.fill, // Ensure no scaling of the image
            ),
          ),
          // Centered text content
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                    left: 30.0,
                    top: 20.0,
                    right: 20.0), // Padding from the left and top
                child: Text(
                  'TERMS AND CONDITION',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'kannada-sangam-mn',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 300,
                height: 450, // Set a fixed height for the scrollable area
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.white,
                      width: 2.0), // Border for the text box
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black54, // Slightly transparent background
                ),
                child: const SingleChildScrollView(
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '1. Penggunaan Aplikasi:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '  Aplikasi ini dirancang untuk tujuan hiburan dan edukasi ringan. Segala informasi yang disediakan hanya untuk keperluan bersenang-senang, dan tidak boleh dianggap sebagai nasihat profesional.',
                        textAlign: TextAlign.justify, // Make text justified
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '2. Tanggung Jawab Pengguna:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '  Pengguna bertanggung jawab atas segala aktivitas yang dilakukan di aplikasi ini. Hindari penggunaan yang dapat merugikan pihak lain atau melanggar hukum.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '3. Privasi Pengguna:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '  Kami menghargai privasi Anda dan berkomitmen untuk melindungi data pribadi Anda. Informasi yang dikumpulkan hanya digunakan untuk meningkatkan pengalaman Anda di aplikasi ini.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '4. Keterbatasan Tanggung Jawab:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '  Aplikasi ini tidak memberikan jaminan atas keakuratan atau hasil apa pun. Kami tidak bertanggung jawab atas kerugian yang mungkin timbul dari penggunaan aplikasi ini.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '5. Hanya untuk Have Fun:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '  Aplikasi ini dibuat hanya untuk bersenang-senang. Jadi, jangan terlalu serius! Nikmati fitur yang ada, tertawa, dan eksplorasi dunia CheckKhodam dengan santai.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '6. Pembaruan Aplikasi:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '  Kami berhak untuk memperbarui aplikasi ini sewaktu-waktu, termasuk syarat dan ketentuan ini, tanpa pemberitahuan terlebih dahulu.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '7. Hukum yang Berlaku:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '  Syarat dan ketentuan ini diatur oleh hukum yang berlaku di wilayah yurisdiksi Anda.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Checkbox for terms and conditions
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                    activeColor: Colors.white,
                    checkColor: Colors.black,
                    side: const BorderSide(
                      color:
                          Colors.white, // White border color for the checkbox
                      width: 2.0,
                    ),
                  ),
                  const Text(
                    'I agree to the Terms & Conditions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
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
                onPressed: _isChecked
                    ? () {
                        Navigator.of(context).push(_createRoute());
                      }
                    : null, // Disable the button if not checked
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent, // Transparent background
                  side: BorderSide(
                    color:
                        _isChecked ? Colors.white : Colors.grey, // Border color
                    width: 2.0, // Border thickness
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
                child: Text(
                  'NEXT',
                  style: TextStyle(
                    color:
                        _isChecked ? Colors.white : Colors.grey, // Text color
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
          const LandingPage(),
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
