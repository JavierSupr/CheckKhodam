import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart' show rootBundle, ByteData;
import 'package:share_plus/share_plus.dart';
import 'camera_page.dart';

class ImageProcessingScreen extends StatefulWidget {
  final String originalImagePath;

  const ImageProcessingScreen({super.key, required this.originalImagePath});

  @override
  _ImageProcessingScreenState createState() => _ImageProcessingScreenState();
}

class _ImageProcessingScreenState extends State<ImageProcessingScreen> {
  String? _processedImagePath;
  bool _isProcessing = false;
  String? _backgroundImageUrl;

  @override
  void initState() {
    super.initState();
    _fetchBackgroundImageUrl();
    _removeBackground();
  }

  // Fetch background image URL from the API
  Future<void> _fetchBackgroundImageUrl() async {
    final apiUrl = 'https://chekodam-backend.vercel.app/khodam/getrandom';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final imageUrl = jsonResponse['imageUrl'];
        setState(() {
          _backgroundImageUrl = imageUrl;
        });
      } else {
        _showErrorDialog('Failed to fetch background image URL');
      }
    } catch (e) {
      _showErrorDialog('Error fetching background image URL: $e');
    }
  }

  Future<void> _removeBackground() async {
    setState(() {
      _isProcessing = true;
    });

    final apiKey =
        'nBGvNsEF2WFVYgFft5dkymKv'; // Replace with your remove.bg API key
    final url = Uri.parse('https://api.remove.bg/v1.0/removebg');
    final request = http.MultipartRequest('POST', url)
      ..headers['X-Api-Key'] = apiKey
      ..files.add(await http.MultipartFile.fromPath(
          'image_file', widget.originalImagePath))
      ..fields['size'] = 'auto';

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final bytes = await response.stream.toBytes();
        final tempDir = await getTemporaryDirectory();
        final filePath = '${tempDir.path}/no_bg.png';
        final processedFile = File(filePath);
        await processedFile.writeAsBytes(bytes);

        // Download background image and merge
        if (_backgroundImageUrl != null) {
          final backgroundImageBytes =
              await _downloadImage(_backgroundImageUrl!);
          final backgroundImage = img.decodeImage(backgroundImageBytes);
          final foregroundImage = img.decodeImage(bytes);

          if (backgroundImage != null && foregroundImage != null) {
            print("object");
            final mergedImage = img.copyResize(backgroundImage,
                width: foregroundImage.width, height: foregroundImage.height);
            img.drawImage(mergedImage, foregroundImage);

            final mergedFilePath = '${tempDir.path}/merged_image.png';
            final mergedFile = File(mergedFilePath);
            await mergedFile.writeAsBytes(img.encodePng(mergedImage));

            setState(() {
              _processedImagePath = mergedFilePath;
              _isProcessing = false;
            });
          } else {
            throw Exception('Error decoding images');
          }
        } else {
          throw Exception('Background image URL not available');
        }
      } else {
        final responseBody = await response.stream.bytesToString();
        final errorMessage = jsonDecode(responseBody)['errors']?[0]['title'] ??
            'Error processing image';
        _showErrorDialog('Error: $errorMessage');
        setState(() {
          _isProcessing = false;
        });
      }
    } catch (e) {
      _showErrorDialog('Error removing background: $e');
      setState(() {
        _isProcessing = false;
      });
    }
  }

  // Function to download image from URL
  Future<List<int>> _downloadImage(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to download image');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
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
            if (_backgroundImageUrl != null)
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.network(
                  _backgroundImageUrl!,
                  fit: BoxFit.cover,
                  height: screenSize.height * 0.75,
                  width: screenSize.width,
                ),
              ),

            // Processed Image Preview with new background
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenSize.height * 0.75,
              child: Transform.scale(
                scale: 0.9,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: _isProcessing
                      ? Center(
                          child: Text(
                            'Checking your khodam...',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'DEATH_FONT',
                              color: Colors.white,
                            ),
                          ),
                        )
                      : _processedImagePath == null
                          ? SizedBox.shrink()
                          : Image.file(
                              File(_processedImagePath!),
                              fit: BoxFit.cover,
                            ),
                ),
              ),
            ),

            // Action Buttons
            if (_processedImagePath != null)
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
                            // Learn More action
                          },
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
                          onPressed: () {
                            if (_processedImagePath != null) {
                              Share.shareXFiles([XFile(_processedImagePath!)],
                                  text: 'Check out this image!');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                            backgroundColor: Colors.white,
                          ),
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
                          onPressed: () {
                            // Retake action
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CameraPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                            backgroundColor: Colors.white,
                          ),
                          child: Image.asset(
                            'assets/images/Rotate Camera.png',
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Retake',
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
}
