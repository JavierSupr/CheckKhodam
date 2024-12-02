import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart' show rootBundle, ByteData;
import 'package:share_plus/share_plus.dart';

class ImageProcessingScreen extends StatefulWidget {
  final String originalImagePath;

  const ImageProcessingScreen({super.key, required this.originalImagePath});

  @override
  _ImageProcessingScreenState createState() => _ImageProcessingScreenState();
}

class _ImageProcessingScreenState extends State<ImageProcessingScreen> {
  String? _processedImagePath;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _removeBackground();
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

        // Merge processed image with new background
        final ByteData data =
            await rootBundle.load('assets/images/Ellipse 67.png');
        final backgroundImage = img.decodeImage(data.buffer.asUint8List());
        final foregroundImage = img.decodeImage(bytes);

        if (backgroundImage != null && foregroundImage != null) {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Process Image'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
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

            // Processed Image Preview with new background
            Center(
              child: _isProcessing
                  ? CircularProgressIndicator()
                  : _processedImagePath == null
                      ? SizedBox.shrink()
                      : Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.7,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            image: DecorationImage(
                              image: FileImage(File(_processedImagePath!)),
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
                    ElevatedButton(
                      onPressed: () {
                        // Learn More action
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        backgroundColor: Colors.white,
                      ),
                      child: Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
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
                    ElevatedButton(
                      onPressed: () {
                        // Retake action
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        backgroundColor: Colors.white,
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 30,
                        color: Colors.black,
                      ),
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
