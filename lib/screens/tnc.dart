import 'package:checkkhodam/screens/landing_page.dart';
import 'package:flutter/material.dart';

class TnCPage extends StatefulWidget {
  const TnCPage({super.key});

  @override
  _TnCPageState createState() => _TnCPageState();
}

class _TnCPageState extends State<TnCPage> {
  bool _isChecked = false; // Track if checkbox is checked

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add AppBar with an image
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LandingPage()),
            );
          },
        ),
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
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
              'assets/images/bg_tnc_page.png', 
              fit: BoxFit.fill, 
            ),
          ),
          // Centered text content
          Align(
            alignment: Alignment.center, // Align the content to center
            child: SingleChildScrollView(
              child: Container(
                width: 380, // Slightly smaller width
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ), // Border for the text box
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.transparent, // Slightly transparent background
                ),
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
                    const SizedBox(height: 5),
                    Text(
                      '  Aplikasi ini dirancang untuk tujuan hiburan dan edukasi ringan. Segala informasi yang disediakan hanya untuk keperluan bersenang-senang, dan tidak boleh dianggap sebagai nasihat profesional.',
                      textAlign: TextAlign.justify, // Make text justified
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '2. Tanggung Jawab Pengguna:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '  Pengguna bertanggung jawab atas segala aktivitas yang dilakukan di aplikasi ini. Hindari penggunaan yang dapat merugikan pihak lain atau melanggar hukum.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '3. Privasi Pengguna:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '  Kami menghargai privasi Anda dan berkomitmen untuk melindungi data pribadi Anda. Informasi yang dikumpulkan hanya digunakan untuk meningkatkan pengalaman Anda di aplikasi ini.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '4. Keterbatasan Tanggung Jawab:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '  Aplikasi ini tidak memberikan jaminan atas keakuratan atau hasil apa pun. Kami tidak bertanggung jawab atas kerugian yang mungkin timbul dari penggunaan aplikasi ini.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '5. Hanya untuk Have Fun:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '  Aplikasi ini dibuat hanya untuk bersenang-senang. Jadi, jangan terlalu serius! Nikmati fitur yang ada, tertawa, dan eksplorasi dunia CheckKhodam dengan santai.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '6. Pembaruan Aplikasi:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '  Kami berhak untuk memperbarui aplikasi ini sewaktu-waktu, termasuk syarat dan ketentuan ini, tanpa pemberitahuan terlebih dahulu.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '7. Hukum yang Berlaku:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '  Syarat dan ketentuan ini tunduk pada hukum yang berlaku di wilayah hukum pengguna.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
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
