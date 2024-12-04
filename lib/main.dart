import 'package:checkkhodam/screens/landing_page.dart';
import 'package:checkkhodam/screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/explanation_page.dart'; // Mengimpor file landing_page.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       home: FutureBuilder(
        future: _checkAgreementStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Tampilkan loading indicator sementara
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == true) {
            // Jika sudah setuju, langsung ke Landing Page
            return const LandingPage();
          } else {
            // Jika belum setuju, tampilkan Welcome Page
            return const WelcomePage();
          }
        },
      ),
    );
  }

  Future<bool> _checkAgreementStatus() async {
    final prefs = await SharedPreferences.getInstance();
    // Cek apakah sudah ada status persetujuan
    bool? isAgreed = prefs.getBool('isAgreed');
    return isAgreed ?? false;  // Jika null, berarti belum setuju, kembalikan false
  }
}
