import 'package:checkkhodam/screens/landing_page.dart';
import 'package:checkkhodam/screens/welcome_page.dart';
import 'package:flutter/material.dart';

class Question10 extends StatefulWidget {
  @override
  _Question10State createState() => _Question10State();
}

class _Question10State extends State<Question10> {
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
              'assets/images/bg_quiz_even.png',
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
                      "Kamu bepergian bersama pasangan baru mu ke mall di kota mu, di tengah jalan ada bapak-bapak berpakaian naruto melihat ke arah kalian. Apa yang kamu lakukan?",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    RadioListTile<String>(
                      value: "Cium pipi kanan cium pipi kiri",
                      groupValue: _selectedOption,
                      title: const Text(
                        "Cium pipi kanan cium pipi kiri",
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
                      value: "ganti pasangan",
                      groupValue: _selectedOption,
                      title: const Text(
                        "ganti pasangan",
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
                      value: "ya.. lewatin aja.. jalan kan luas",
                      groupValue: _selectedOption,
                      title: const Text(
                        "ya.. lewatin aja.. jalan kan luas",
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
                      value: "Turun dari motor, story telling ke bapak-bapaknya",
                      groupValue: _selectedOption,
                      title: const Text(
                        "Turun dari motor, story telling ke bapak-bapaknya",
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
              width: 140,
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
                        builder: (context) => WelcomePage(),
                      ),
                    );
                  }
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.red,
                  side: const BorderSide(
                    color: Colors.white,
                    width: 2.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "CHECKHODAM!!",
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
