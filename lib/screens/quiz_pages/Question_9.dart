import 'package:checkkhodam/screens/landing_page.dart';
import 'package:checkkhodam/screens/quiz_pages/Question_10.dart';
import 'package:flutter/material.dart';

class Question9 extends StatefulWidget {
  @override
  _Question9State createState() => _Question9State();
}

class _Question9State extends State<Question9> {
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
                      "Kenapa sandal sering hilang sebelah?",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    RadioListTile<String>(
                      value: "Karena mereka punya hubungan toxic",
                      groupValue: _selectedOption,
                      title: const Text(
                        "Karena mereka punya hubungan toxic",
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
                      value: "Karena sebelahnya sudah lelah diinjak terus",
                      groupValue: _selectedOption,
                      title: const Text(
                        "Karena sebelahnya sudah lelah diinjak terus",
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
                      value: "Karena mereka rebutan siapa yang lebih nyaman",
                      groupValue: _selectedOption,
                      title: const Text(
                        "Karena mereka rebutan siapa yang lebih nyaman",
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
                      value: "Ya gapapa sih, nanya mulu ",
                      groupValue: _selectedOption,
                      title: const Text(
                        "Ya gapapa sih, nanya mulu",
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
                        builder: (context) => Question10(),
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
