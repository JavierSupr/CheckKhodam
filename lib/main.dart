import 'package:checkkhodam/screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'screens/explanation_page.dart'; // Mengimpor file landing_page.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage(), // Menggunakan LandingPage dari file terpisah
    );
  }
}
