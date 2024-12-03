import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'khodam_result.dart';

class KhodamXplorePage extends StatefulWidget {
  const KhodamXplorePage({super.key});

  @override
  _KhodamXplorePageState createState() => _KhodamXplorePageState();
}

class _KhodamXplorePageState extends State<KhodamXplorePage> {
  // Function to fetch all Khodam names and descriptions from the API
  Future<List<Map<String, String>>> _fetchKhodamData() async {
    final response = await http.get(
        Uri.parse('https://chekodam-backend.vercel.app/khodam/getallkhodam'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      // Extract 'nama' and 'deskripsi' fields from each Khodam object in the list
      return data.map((khodam) {
        return {
          'nama': khodam['nama'] as String,
          'deskripsi': khodam['deskripsi'] as String,
        };
      }).toList();
    } else {
      throw Exception('Failed to load Khodams');
    }
  }

  // Function to navigate to the detail page
  void _navigateToDetailPage(
      BuildContext context, String title, String description) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            KhodamResultPage(title: title, description: description),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/CHECKHODAM_1.png', // Logo in AppBar
              height: 20,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            // Background images
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                'assets/images/Ellipse 65.png',
                fit: BoxFit.none,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                'assets/images/Ellipse 67.png',
                fit: BoxFit.none,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                'assets/images/Ellipse 69.png',
                fit: BoxFit.none,
              ),
            ),
            // Title at the top
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'KHODAM XPLORE',
                  style: TextStyle(
                    fontFamily: "DEATH_FONT",
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Main content
            FutureBuilder<List<Map<String, String>>>(
              future: _fetchKhodamData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No Khodams available'));
                } else {
                  // Fetch the list of Khodam names and descriptions
                  List<Map<String, String>> khodamData = snapshot.data!;

                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 60, horizontal: 10),
                      itemCount: khodamData.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255)!
                                .withOpacity(0.35),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 187, 187, 187)
                                    .withOpacity(0.2),
                                offset: Offset(0, 5),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              _navigateToDetailPage(
                                context,
                                khodamData[index]['nama']!,
                                khodamData[index]['deskripsi']!,
                              );
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 24, horizontal: 16),
                              leading: Image.asset('assets/images/Icon.png'),
                              title: Text(
                                khodamData[index]['nama']!,
                                style: TextStyle(
                                  fontFamily: "boxpot",
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
