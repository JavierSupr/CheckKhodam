import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'khodam_result.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class KhodamXplorePage extends StatefulWidget {
  const KhodamXplorePage({super.key});

  @override
  _KhodamXplorePageState createState() => _KhodamXplorePageState();
}

class _KhodamXplorePageState extends State<KhodamXplorePage> {
  // Function to fetch all Khodam names and descriptions from the API
  Future<List<Map<String, String>>> _fetchKhodamData() async {
    final response = await http.get(
      Uri.parse('https://chekodam-backend.vercel.app/khodam/getallkhodam'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;

      // Cast the response to List<Map<String, String>> correctly
      List<Map<String, String>> khodamData = data.map((khodam) {
        return {
          'nama': khodam['nama'] as String,
          'deskripsi': khodam['deskripsi'] as String,
          'imageUrl': khodam['imageUrl'] as String,
          'extrovert': (khodam['extrovert'] ?? 0.0).toString(),
          'introvert': (khodam['introvert'] ?? 0.0).toString(),
          'jomok meter': khodam['jomok meter'] as String,
          'love language': khodam['love language'] as String,
          'orang terkenal dengan khodam ini':
              khodam['orang terkenal dengan khodam ini'] as String
        };
      }).toList();

      // Download images concurrently using Future.wait
      List<Future<String>> downloadTasks = [];
      for (var khodam in khodamData) {
        String imageUrl = khodam['imageUrl']!;
        downloadTasks.add(_downloadImage(imageUrl));
      }

      // Wait for all the image downloads to finish
      List<String> imagePaths = await Future.wait(downloadTasks);

      // Update khodamData with the downloaded image paths
      for (int i = 0; i < khodamData.length; i++) {
        khodamData[i]['localImagePath'] = imagePaths[i];
      }

      return khodamData;
    } else {
      throw Exception('Failed to load Khodams');
    }
  }

  Future<String> _downloadImage(String imageUrl) async {
    try {
      Dio dio = Dio();
      // Get the temporary directory to store the image
      Directory tempDir = await getTemporaryDirectory();
      String fileName = imageUrl.split('/').last;
      String filePath = '${tempDir.path}/$fileName';

      // Check if the image already exists locally
      if (File(filePath).existsSync()) {
        return filePath; // Return the local image path if it exists
      }

      // Download the image and save it to the file path
      await dio.download(imageUrl, filePath);
      return filePath;
    } catch (e) {
      print('Error downloading image: $e');
      return ''; // Return an empty string in case of an error
    }
  }

  // Function to navigate to the detail page
  void _navigateToResultPage(
      BuildContext context,
      String title,
      String description,
      String imagePath,
      String extrovertStr,
      String introvertStr,
      String jomok_level,
      String love_language,
      String people) {
    // Convert extrovert and introvert to double
    double extrovert =
        double.tryParse(extrovertStr) ?? 0.0; // Default to 0.0 if parsing fails
    double introvert =
        double.tryParse(introvertStr) ?? 0.0; // Default to 0.0 if parsing fails

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => KhodamResultPage(
            title: title,
            description: description,
            imagePath: imagePath,
            extrovert: extrovert,
            introvert: introvert,
            jomok_level: jomok_level,
            love_language: love_language,
            people: people),
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
                                _navigateToResultPage(
                                  context,
                                  khodamData[index]['nama']!,
                                  khodamData[index]['deskripsi']!,
                                  khodamData[index]['localImagePath']!,
                                  khodamData[index]['extrovert']!,
                                  khodamData[index]['introvert']!,
                                  khodamData[index]['jomok meter']!,
                                  khodamData[index]['love language']!,
                                  khodamData[index]
                                      ['orang terkenal dengan khodam ini']!,
                                  // Use local image path
                                );
                              },
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                leading: khodamData[index]['localImagePath']!
                                        .isEmpty
                                    ? CircularProgressIndicator() // Show a loading indicator if the image is still being downloaded
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            10), // Rounded corners with a radius of 15
                                        child: Image.file(
                                          File(khodamData[index]
                                              ['localImagePath']!),
                                          fit: BoxFit
                                              .cover, // Ensure the image covers the space without distortion
                                          width:
                                              60, // Increased width for the image
                                          height:
                                              105, // Increased height for the image
                                        ),
                                      ),
                                title: Text(
                                  khodamData[index]['nama']!,
                                  style: TextStyle(
                                    fontFamily: "DEATH_FONT",
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              )),
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
