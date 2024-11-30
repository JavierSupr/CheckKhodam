import 'package:checkkhodam/screens/landing_page.dart';
import 'package:checkkhodam/screens/quiz_pages/Question_6.dart';
import 'package:flutter/material.dart';

class Question5 extends StatefulWidget {
  @override
  _Question5State createState() => _Question5State();
}

class _Question5State extends State<Question5> {
  String? _selectedOption; // Menyimpan opsi yang dipilih

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LandingPage()),
            );
          },
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Khodam Quiz",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'DEATH_FONT',
              ),
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
          // Positioned image at the top-left
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/bg_quiz_odd.png',
              fit: BoxFit.none, // Ensure no scaling of the image
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Kamu sedang naik angkot, tiba-tiba supirnya berhenti dan bilang, 'Saya berhenti, karena angkot ini punya perasaan!' Apa yang kamu lakukan?",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    RadioListTile<String>(
                      value: "Bilang, 'Gak papa, angkot. Kita kan semua punya perasaan.'",
                      groupValue: _selectedOption,
                      title: const Text(
                        "Bilang, 'Gak papa, angkot. Kita kan semua punya perasaan.'",
                        style: TextStyle(color: Colors.white),
                      ),
                      activeColor: Colors.white,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      value: "Coba minta maaf sama angkotnya, siapa tau bisa jalan lagi.",
                      groupValue: _selectedOption,
                      title: const Text(
                        "Coba minta maaf sama angkotnya, siapa tau bisa jalan lagi.",
                        style: TextStyle(color: Colors.white),
                      ),
                      activeColor: Colors.white,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      value: "Tanya, 'Emang angkotnya lagi galau, atau cuma pengen silent treatment aja?'",
                      groupValue: _selectedOption,
                      title: const Text(
                        "Tanya, 'Emang angkotnya lagi galau, atau cuma pengen silent treatment aja?'",
                        style: TextStyle(color: Colors.white),
                      ),
                      activeColor: Colors.white,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      value: "Bilang, 'Yaudah, angkot. Nanti kita buat sesi konseling' ",
                      groupValue: _selectedOption,
                      title: const Text(
                        "Bilang, 'Yaudah, angkot. Nanti kita buat sesi konseling.'",
                        style: TextStyle(color: Colors.white),
                      ),
                      activeColor: Colors.white,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
          // Button Positioned at the bottom-left and bottom-right
          Positioned(
            bottom: 20,
            left: 20,
            child: SizedBox(
              width: 134,
              height: 41,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to previous page
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(
                    color: Colors.white,
                    width: 2.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "PREVIOUS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: SizedBox(
              width: 109,
              height: 41,
              child: OutlinedButton(
                onPressed: () {
                  if (_selectedOption == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Pilih salah satu opsi terlebih dahulu."),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Question6(),
                      ),
                    );
                  }
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(
                    color: Colors.white,
                    width: 2.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "NEXT",
                  style: TextStyle(
                    color: Colors.white,
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
}
