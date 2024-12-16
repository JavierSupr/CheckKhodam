import 'package:flutter/material.dart';
import 'question_page.dart'; // File halaman kuis

class QuizPage0 extends StatelessWidget {
  const QuizPage0({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back to the previous page
          },
        ),
      ),
      body: Stack(
        children: [
          // Black background
          Container(color: Colors.black),
          // Positioned image at the bottom-left
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_asset_quiz0.png',
              fit: BoxFit.fill, // Ensure no scaling of the image
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 150.0),
                child: Center(
                  child: Text(
                    'KHODAM\nQUIZ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 96,
                      fontFamily: 'DEATH_FONT',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Center(
                  child: Text(
                    'Jawablah beberapa pertanyaan berikut ini dan dapatkan khodam yang sesuai dengan kepribadian mu!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'micross',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(_routeChangePage());
                },
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 108, 143, 190),
                        Color.fromARGB(255, 255, 168, 159),
                        Color.fromARGB(255, 248, 167, 160),
                        Color.fromARGB(255, 181, 155, 175)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'START QUIZ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'micross',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Route _routeChangePage() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => QuestionPage(
        question: questionData[0]['question'],
        options: questionData[0]['options'],
        currentIndex: 0,
        totalQuestions: questionData.length,
      ),
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
