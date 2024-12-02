import 'package:flutter/material.dart';
import 'package:checkkhodam/screens/landing_page.dart';
import 'package:checkkhodam/screens/welcome_page.dart';

class QuestionPage extends StatefulWidget {
  final String question;
  final List<String> options;
  final int currentIndex;
  final int totalQuestions;

  const QuestionPage({
    super.key,
    required this.question,
    required this.options,
    required this.currentIndex,
    required this.totalQuestions,
  });

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  String? _selectedOption;

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
        title: const Text(
          "Khodam Quiz",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'DEATH_FONT',
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.black,
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              widget.currentIndex % 2 == 0
                  ? 'assets/images/bg_quiz_even.png'
                  : 'assets/images/bg_quiz_odd.png',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.question,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ...widget.options.map(
                  (option) => RadioListTile<String>(
                    value: option,
                    groupValue: _selectedOption,
                    title: Text(
                      option,
                      style: const TextStyle(color: Colors.white),
                    ),
                    activeColor: Colors.white,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: widget.currentIndex > 0
                ? SizedBox(
                    width: 140,
                    height: 41,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: const BorderSide(color: Colors.white, width: 2.0),
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
                  )
                : const SizedBox.shrink(),
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
                  } else if (widget.currentIndex < widget.totalQuestions - 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuestionPage(
                          question: questionData[widget.currentIndex + 1]['question'],
                          options: questionData[widget.currentIndex + 1]['options'],
                          currentIndex: widget.currentIndex + 1,
                          totalQuestions: widget.totalQuestions,
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomePage()),
                    );
                  }
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: widget.currentIndex < widget.totalQuestions - 1
                      ? Colors.transparent
                      : Colors.red,
                  side: BorderSide(
                    color: widget.currentIndex < widget.totalQuestions - 1
                        ? Colors.white
                        : Colors.red,
                    width: 2.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  widget.currentIndex < widget.totalQuestions - 1 ? "NEXT" : "FINISH",
                  style: const TextStyle(
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


// Data pertanyaan (letakkan di file terpisah jika perlu)
const List<Map<String, dynamic>> questionData = [
  {//question 1
    "question": "Jika semangka bisa berbicara, apa yang akan dia katakan saat dimakan?",
    "options": 
    [
      "Jangan kunyah bijiku!",
      "Akhirnya, aku pensiun dari dunia pertanian",
      "Tolong, aku punya keluarga di kulkas!",
      "Aku harap gigimu bersih"
     ]
  },
  {//question 2
    "question": "Kamu sedang berjalan di hutan yang sangat gelap, tiba-tiba ada suara besar yang datang dari belakang. Kamu berbalik dan melihat apa?",
    "options": 
    [
      "Kucing Akmal",
      "Sepasang sepatu yang bisa nge-rizz",
      "Sebuah mobil yang minta tolong untuk parkir",
      "Sebuah pohon yang sedang mewing"
     ]
  },
  {//question 3
    "question": "Saat kamu berjalan di pasar malam, tiba-tiba ada tikus yang menawarkan kamu sesuatu. Apa yang dia tawarkan?",
    "options": 
    [
      "mau tau trik jitu cara menjadi sigma dalam satu malam?",
      "Jangan khawatir, aku akan memberi rizz seumur hidupmu.",
      "Ini bukan tikus biasa, dia seorang master mewing!",
      "Sebuah tutorial mewing yang akan mengubah hidupmu"
     ]
  },
  {//question 4
    "question": "Kamu terjebak di dalam kulkas dengan seekor ayam. Apa yang pertama kali kamu lakukan?",
    "options": 
    [
      "Ajak ayam ngomongin resep gulai ayam",
      "Minta ayam ngajarin cara bertelur",
      "Main petak umpet sama ayam, tapi nanti yang ketemu bisa jadi makan malam",
      "Tanya ayam cara menghilangkan bau ketek (sarkas)"
     ]
  },
  {//question 5
    "question": "Kamu sedang naik angkot, tiba-tiba supirnya berhenti dan bilang, 'Saya berhenti, karena angkot ini punya perasaan!' Apa yang kamu lakukan?",
    "options": 
    [
      "Bilang, 'Gak papa, angkot. Kita kan semua punya perasaan.'",
      "Coba minta maaf sama angkotnya, siapa tau bisa jalan lagi",
      "Tanya, 'Emang angkotnya lagi galau, atau cuma pengen silent treatment aja?",
      "Bilang, 'Yaudah, angkot. Nanti kita buat sesi konseling"
     ]
  },
  {//question 6
    "question": "Kamu lagi di dalam kereta, tiba-tiba kereta mulai ngomong, 'Saya butuh istirahat, kalian semua turun dulu' Apa yang kamu lakukan?",
    "options": 
    [
      "Bilang, 'Eh kereta, kita kan baru mulai, jangan ngambek dulu!'",
      "Tanya, 'Kereta, kamu capek ya? Gimana kalau kita kasih kamu libur sebulan?'",
      "Coba tawarin kereta untuk liburan ke Bali, biar nggak stres.",
      "Bilang, 'Kereta, kayaknya kita mending break dulu. Kamu terlalu toxic!'"
     ]
  },
  {//question 7
    "question": "Kamu lagi di taman, tiba-tiba ada orang yang kamu suka datang sambil bawa bunga mawar. Tapi dia ngomong, 'Aku cinta sama kamu, tapi aku juga cinta sama kucing peliharaanmu.' Apa yang kamu lakukan?",
    "options": 
    [
      "Bilang, 'Aku cinta kamu juga, tapi kucingku lebih cantik.'",
      "Tanya, 'Jadi, kamu mau cinta aku apa kucing, ya?'",
      "Coba ajak, 'Gimana kalau kita semua pacaran bareng?'",
      "Bilang, 'Bunga mawar sih oke, tapi kucingnya jangan diajak pacaran.'"
     ]
  },
  {//question 8
    "question": "Kalau manusia punya ekor, untuk apa kita memakainya?",
    "options": 
    [
      "Untuk menyeimbangkan isi dompet",
      "Ikat pinggang",
      "Untuk nge-swipe di aplikasi dating",
      "Apa kek"
     ]
  },
  {//question 9
    "question": "Kenapa sandal sering hilang sebelah?",
    "options": 
    [
      "Karena mereka punya hubungan toxic",
      "Karena sebelahnya sudah lelah diinjak terus",
      "Karena mereka rebutan siapa yang lebih nyaman",
      "Ya gapapa sih, nanya mulu"
     ]
  },
  {//question 10
    "question": "Kamu bepergian bersama pasangan baru mu ke mall di kota mu, di tengah jalan ada bapak-bapak berpakaian naruto melihat ke arah kalian. Apa yang kamu lakukan?",
    "options": 
    [
      "Cium pipi kanan cium pipi kiri",
      "Peluk dari belakang, sambil tanya 'hari ini khodam apa sayang?'",
      "ganti pasangan",
      "Jadi presiden"
     ]
  }
];
