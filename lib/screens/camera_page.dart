import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'background_remover.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  int _currentCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Get available cameras
    _cameras = await availableCameras();

    // Initialize the first camera
    if (_cameras != null && _cameras!.isNotEmpty) {
      _controller = CameraController(
        _cameras![_currentCameraIndex],
        ResolutionPreset.high,
      );

      try {
        await _controller!.initialize();

        if (mounted) {
          setState(() {});
        }
      } catch (e) {
        print('Error initializing camera: $e');
      }
    }
  }

  void _switchCamera() async {
    if (_cameras == null || _cameras!.isEmpty) return;

    // Dispose the existing controller
    await _controller?.dispose();

    // Switch to the next camera
    _currentCameraIndex = (_currentCameraIndex + 1) % _cameras!.length;

    // Initialize the new camera
    _controller = CameraController(
      _cameras![_currentCameraIndex],
      ResolutionPreset.high,
    );

    try {
      await _controller!.initialize();

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('Error switching camera: $e');
    }
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }

    try {
      // Take the picture
      final XFile image = await _controller!.takePicture();

      // Navigate to the image preview screen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ImagePreviewScreen(imagePath: image.path),
        ),
      );
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
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
        actions: [
          IconButton(
            icon: const Icon(Icons.switch_camera),
            onPressed: _switchCamera,
            tooltip: 'Switch Camera',
          ),
        ],
      ),
      body: Container(
        color: Colors.black, // Basic background color is black
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

            // Camera Preview - Positioned higher and zoomed out
            Positioned(
              top: 0, // Positioned at the top of the screen
              left: 0,
              right: 0,
              height: screenSize.height * 0.75, // Takes up 75% of screen height
              child: _controller != null && _controller!.value.isInitialized
                  ? Transform.scale(
                      scale: 0.9, // Slightly zoomed out
                      child: AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: CameraPreview(_controller!),
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
            ),

            // Capture Button
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap:
                      _takePicture, // Trigger the picture taking function when the image is tapped
                  child: Image.asset(
                    'assets/images/Final State.png', // Replace with your image path
                    width: 100, // Adjust size as needed
                    height: 100, // Adjust size as needed
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImagePreviewScreen extends StatelessWidget {
  final String imagePath;

  const ImagePreviewScreen({super.key, required this.imagePath});

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

            // Centered Image Preview
            Positioned(
              top: 0, // Positioned at the top of the screen
              left: 0,
              right: 0,
              height: screenSize.height * 0.75, // Takes up 75% of screen height
              child: Transform.scale(
                scale: 0.9, // Slightly zoomed out
                child: AspectRatio(
                  aspectRatio:
                      16 / 9, // Adjust to match the aspect ratio of your image
                  child: Image.file(
                    File(imagePath),
                    fit: BoxFit.cover, // Make sure the image fits well
                  ),
                ),
              ),
            ),

            // Action Buttons
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Row for buttons (horizontal arrangement)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // First ElevatedButton with text below
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Retake photo
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape:
                                      CircleBorder(), // Makes the button circular
                                  padding: EdgeInsets.all(20),
                                  backgroundColor:
                                      Colors.white.withOpacity(0.7),
                                ),
                                child: Image.asset(
                                  'assets/images/Rotate Camera.png', // Replace with your image path
                                  width: 30, // Adjust size as needed
                                  height: 30, // Adjust size as needed
                                ),
                              ),
                              SizedBox(
                                  height:
                                      8), // Space between the button and text
                              Text(
                                'RETAKE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'DEATH_FONT'),
                              ),
                            ],
                          ),

                          SizedBox(width: 120), // Space between the two buttons

                          // Second ElevatedButton with text below
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Navigate to ImageProcessingScreen with the captured image path
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ImageProcessingScreen(
                                        originalImagePath: imagePath,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape:
                                      CircleBorder(), // Makes the button circular
                                  padding: EdgeInsets.all(20),
                                  backgroundColor:
                                      Colors.white.withOpacity(0.7),
                                ),
                                child: Image.asset(
                                  'assets/images/ic_process.png', // Replace with your image path
                                  width: 30, // Adjust size as needed
                                  height: 30, // Adjust size as needed
                                ),
                              ),
                              SizedBox(
                                  height:
                                      8), // Space between the button and text
                              Text(
                                'PROCESS',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'DEATH_FONT'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
