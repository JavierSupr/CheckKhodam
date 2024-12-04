import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart'; // Import share_plus
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart'; // Import path_provider
import 'package:flutter/services.dart'; // For saving file to device
import 'package:http/http.dart' as http; // Import http package
import 'dart:convert'; // For converting JSON response
import 'khodam_result.dart';

class KhodamDetailPage extends StatefulWidget {
  final String title;
  final String description;

  const KhodamDetailPage(
      {super.key, required this.title, required this.description});

  @override
  _KhodamDetailPageState createState() => _KhodamDetailPageState();
}

class _KhodamDetailPageState extends State<KhodamDetailPage> {
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List? capturedImage;
  String title = '';
  String description = '';
  String imageUrl = '';
  double extrovert = 0.0;
  double introvert = 0.0;
  String jomok_level = '';
  String love_language = '';
  String people = '';

  bool isDataLoaded = false; // Track whether data has been loaded

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the page is initialized
  }

  // Fetch data from API
  Future<void> fetchData() async {
    try {
      final response = await http.get(
          Uri.parse('https://chekodam-backend.vercel.app/khodam/getrandom'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          title = data['nama'];
          description = data['deskripsi'];
          imageUrl = data['imageUrl'];
          extrovert = data['extrovert'].toDouble();
          introvert = data['introvert'].toDouble();
          jomok_level = data['jomok meter'];
          love_language = data['love language'];
          people = data['orang terkenal dengan khodam ini'];
        });

        // Download the image after fetching data
        print(" title $title");
        print("desc $description");
        print("url $imageUrl");
        downloadImage(imageUrl);
        print("New image URL: $imageUrl");

        // Once the image is downloaded, set isDataLoaded to true
        setState(() {
          isDataLoaded = true; // Mark data as loaded
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  Future<void> downloadImage(String url) async {
    try {
      // Get the application's document directory
      final directory = await getApplicationDocumentsDirectory();

      // Find the next available index for the image file
      int index = 1;
      String filePath = '${directory.path}/khodam_image_$index.png';

      // Check if the file already exists and increment index until a free spot is found
      while (await File(filePath).exists()) {
        index++;
        filePath = '${directory.path}/khodam_image_$index.png';
      }

      // Modify the URL to get the correct download link from Google Drive
      String downloadUrl = url.contains('drive.google.com')
          ? url.replaceAll('drive.google.com', 'docs.google.com')
          : url; // Google Drive specific

      final response = await http.get(Uri.parse(downloadUrl));

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        // Save the new image to the file system
        final newFile = File(filePath);
        await newFile.writeAsBytes(bytes);
        print("Image downloaded and saved to: $filePath");

        // Reset the image state and trigger a refresh
        setState(() {
          imageUrl = ''; // Reset imageUrl before setting the new one
        });

        // After the reset, update the imageUrl with the new file path
        setState(() {
          imageUrl = filePath; // Update the imageUrl to the new image path
        });
      } else {
        throw Exception('Failed to download image');
      }
    } catch (e) {
      print("Error downloading image: $e");
    }
  }

  // Function to capture screenshot
  void captureScreenshot() async {
    screenshotController.capture().then((Uint8List? image) {
      setState(() {
        capturedImage = image;
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  // Function to save the screenshot to a file and share it
  Future<void> shareScreenshot() async {
    if (capturedImage == null) {
      // Ensure there is an image to share
      print("No screenshot captured yet!");
      return;
    }

    // Get the temporary directory
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/screenshot.png';

    // Save the screenshot as a file
    final file = File(filePath);
    await file.writeAsBytes(capturedImage!);

    // Share the file using share_plus
    Share.shareXFiles([XFile(filePath!)], text: 'Check out this image!');
  }

  Future<void> saveScreenshot() async {
    if (capturedImage == null) {
      // Ensure there is an image to save
      print("No screenshot captured yet!");
      return;
    }

    // Get the temporary directory
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/captured_screenshot.png';

    // Save the screenshot as a file
    final file = File(filePath);
    await file.writeAsBytes(capturedImage!);

    // Optionally, you can print the file path to check where it was saved
    print("Screenshot saved at: $filePath");
  }

  void captureAndShare() {
    captureScreenshot();
    Future.delayed(Duration(seconds: 1), () {
      shareScreenshot();
    });
  }

  void captureAndSave() {
    captureScreenshot(); // Capture screenshot first
    Future.delayed(Duration(seconds: 1), () {
      saveScreenshot(); // After a short delay, save the screenshot
    });
  }

  void _navigateToResultPage(
      BuildContext context,
      String title,
      String description,
      String imageUrl,
      double extrovert,
      double introvert,
      String jomok_level,
      String love_language,
      String people) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => KhodamResultPage(
          title: title,
          description: description,
          imagePath: imageUrl,
          extrovert: extrovert,
          introvert: introvert,
          jomok_level: jomok_level,
          love_language: love_language,
          people: people,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isDataLoaded) {
      return Scaffold(
        backgroundColor: Colors.black,
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
        body: Center(
          child: Container(
            color: Colors.black, // Set the background color to black
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white), // Set the progress indicator color to white
            ),
          ),
        ),
      );
    }

    // Get device screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate the width and height based on a 16:9 aspect ratio
    double aspectRatio = 16 / 9;
    double width = screenHeight *
        aspectRatio; // Width is based on height to maintain 16:9 ratio
    double height = screenHeight; // The height will be the full screen height

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
        color: Colors.black, // Set the entire background to black
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'assets/images/Rectangle 360.png',
                fit: BoxFit
                    .cover, // Adjust this to how you want the image to fill
              ),
            ),
            Screenshot(
              controller: screenshotController,
              child: Transform.scale(
                scale: 0.6, // 70% zoom-out effect
                child: Container(
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

                      // Image preview from screenshot with zoom-out effect

                      // Main content
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  FileImage(File(imageUrl)), // Use FileImage
                            ),
                            const SizedBox(height: 20),
                            Text(
                              title, // Use the title fetched from API
                              style: const TextStyle(
                                fontFamily: "DEATH_FONT",
                                fontSize: 32,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            // Display dynamic description
                            Text(
                              description.isNotEmpty
                                  ? description
                                  : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea.",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 40),
                            const Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'PERSONAL TRAITS',
                                style: TextStyle(
                                  fontFamily: "boxpot",
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            _buildTraitProgressBar(
                                'ekstrovert', Colors.green, extrovert),
                            const SizedBox(height: 10),
                            _buildTraitProgressBar(
                                'introvert', Colors.yellow, introvert),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // New body outside Screenshot with black background
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Ensure you're passing the correct arguments to the function
                          _navigateToResultPage(
                              context,
                              title, // Use the title fetched from API
                              description, // Use the description fetched from API
                              imageUrl,
                              extrovert,
                              introvert,
                              jomok_level,
                              love_language,
                              people // Use the local path of the downloaded image
                              );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                          backgroundColor: Colors.white,
                        ),
                        child: Image.asset(
                          'assets/images/Search More.png', // Your button icon
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Learn More',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'DEATH_FONT',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: captureAndShare, // Button disabled
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black),
                        child: Icon(
                          Icons.share,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Share',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'DEATH_FONT',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: captureAndSave, // Button disabled
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                          backgroundColor: Colors.white, // Set background color
                        ),
                        child: Image.asset(
                          'assets/images/Save.png',
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'DEATH_FONT',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTraitProgressBar(String label, Color color, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: "DEATH_FONT",
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: color.withOpacity(0.3),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${(progress * 100).toStringAsFixed(0)}%', // Convert progress to percentage
              style: TextStyle(
                fontFamily: 'micross',
                fontSize: 16,
                color: color,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
