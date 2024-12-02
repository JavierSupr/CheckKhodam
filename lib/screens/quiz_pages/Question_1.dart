import 'package:checkkhodam/screens/landing_page.dart';
import 'package:checkkhodam/screens/quiz_pages/Question_2.dart';
import 'package:flutter/material.dart';

class Question1 extends StatefulWidget {
  @override
  _Question1State createState() => _Question1State();
}

class _Question1State extends State<Question1> {
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
                      "Jika semangka bisa berbicara, apa yang akan dia katakan saat dimakan?",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    RadioListTile<String>(
                      value: "Jangan kunyah bijiku!",
                      groupValue: _selectedOption,
                      title: const Text(
                        "Jangan kunyah bijiku!",
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
                      value: "Akhirnya, aku pensiun dari dunia pertanian.",
                      groupValue: _selectedOption,
                      title: const Text(
                        "Akhirnya, aku pensiun dari dunia pertanian.",
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
                      value: "Tolong, aku punya keluarga di kulkas!",
                      groupValue: _selectedOption,
                      title: const Text(
                        "Tolong, aku punya keluarga di kulkas!",
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
                      value: "Aku harap gigimu bersih.",
                      groupValue: _selectedOption,
                      title: const Text(
                        "Aku harap gigimu bersih.",
                        style: TextStyle(color: Colors.white),
                      ),
                      activeColor: Colors.white,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Button Positioned at the bottom-right
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
                        builder: (context) => Question2(),
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
