import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart'; // Import share_plus
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart'; // Import path_provider
import 'package:flutter/services.dart'; // For saving file to device
import 'package:http/http.dart' as http; // Import http package
import 'dart:convert'; // For converting JSON response

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
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the page is initialized
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

  @override
  Widget build(BuildContext context) {
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
                              child: Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              widget.title,
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
                              widget.description.isNotEmpty
                                  ? widget.description
                                  : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea.",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 40),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'PERSONAL TRAITS',
                                style: TextStyle(
                                  fontFamily: "DEATH_FONT",
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildTraitProgressBar(
                                'EXTROVERT', Colors.blue, 0.7),
                            const SizedBox(height: 20),
                            _buildTraitProgressBar('HUNGER', Colors.red, 0.5),
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
                        onPressed: captureScreenshot, // Button disabled
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                          backgroundColor: Colors.white,
                        ),
                        child: Image.asset(
                          'assets/images/Search More.png', // Replace with your custom image
                          width: 30, // Image size
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
        LinearProgressIndicator(
          value: progress,
          backgroundColor: color.withOpacity(0.3),
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }
}
