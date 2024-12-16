import 'package:flutter/material.dart';
import 'landing_page.dart'; // Ganti dengan path yang sesuai untuk LandingPage Anda.

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'About Us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(color: Colors.black),
          // Gambar latar belakang
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_aboutUs.png', // Ganti dengan path gambar Anda
              fit: BoxFit.cover,
            ),
          ),
          // Konten halaman
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    height: 250, // Tinggi 250px
                    decoration: BoxDecoration(
                      color: Colors.transparent, // Transparansi latar belakang box
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 4, // 4/5 bagian untuk teks
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'OUR STORY',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: 'micross',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Aplikasi ini dirancang untuk membantu Anda mengeksplorasi dan memahami berbagai fitur menarik tentang khodam. Melalui kuis interaktif, eksplorasi yang informatif, serta alat yang dirancang dengan intuitif, aplikasi ini memberikan pengalaman yang mendalam dan edukatif. Tidak hanya itu, aplikasi ini juga dibuat sebagai bagian dari tugas akhir mata kuliah Pemrograman Bergerak, dengan tujuan untuk menggabungkan pembelajaran teknologi dan kreativitas dalam menciptakan solusi digital yang bermanfaat.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'micross',
                                    color: Colors.white70,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1, // 1/5 bagian untuk foto
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/images/aboutUs_img.jpeg', // Ganti dengan path gambar Anda
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height / 4,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center, // Menyelaraskan semua item di tengah secara horizontal
                    children: [
                      Container(
                        alignment: Alignment.center, // Menempatkan teks di tengah
                        child: const Text(
                          'OUR TEAM',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true, // Agar GridView berfungsi di dalam SingleChildScrollView
                        physics: const NeverScrollableScrollPhysics(), // Nonaktifkan scrolling internal GridView
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, // Membagi layar secara vertikal menjadi 4 grid (2 kolom x 2 baris)
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.6, // Rasio lebar dan tinggi grid
                        ),
                        itemCount: 4, // Jumlah gambar
                        itemBuilder: (context, index) {
                          // Ganti dengan data asli atau gambar
                          final images = [
                            {'image': 'assets/images/khal.png', 'caption': 'Javier J. S.', 'subCaption': 'Frontend Developer'},
                            {'image': 'assets/images/rifan.png', 'caption': 'Rifan D. K.', 'subCaption': 'Backend Developer'},
                            {'image': 'assets/images/beryl.JPG', 'caption': 'A. Beryl B.', 'subCaption': 'UI/UX, Frontend Dev.'},
                            {'image': 'assets/images/khal.png', 'caption': 'Khalisha D. H.', 'subCaption': 'UI/UX Designer'},
                          ];

                          return Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    images[index]['image']!, // Path gambar
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                images[index]['caption']!,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                images[index]['subCaption']!,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'SUPPORTED BY',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GridView.builder(
                        shrinkWrap: true, // Agar GridView berfungsi di dalam SingleChildScrollView
                        physics: const NeverScrollableScrollPhysics(), // Nonaktifkan scrolling internal GridView
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // Membagi layar secara vertikal menjadi 4 grid (2 kolom x 2 baris)
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1, // Rasio lebar dan tinggi grid
                        ),
                        itemCount: 3, // Jumlah gambar
                        itemBuilder: (context, index) {
                          // Ganti dengan data asli atau gambar
                          final images = [
                            {'image': 'assets/images/logoITS.png'},
                            {'image': 'assets/images/logoCE.png'},
                            {'image': 'assets/images/logoPakArta.png'},
                          ];
                        return Column(
                            children: [
                              SizedBox(
                                width: 60,  // Ukuran lebar gambar
                                height: 60, // Ukuran tinggi gambar
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    images[index]['image']!, // Path gambar
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
