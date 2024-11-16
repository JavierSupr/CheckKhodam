import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller; // Make _controller nullable
  late List<CameraDescription> cameras;
  late CameraDescription selectedCamera;
  bool isCameraInitialized = false;
  int selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  // Initialize the camera
  void _initializeCamera() async {
    try {
      cameras = await availableCameras();
      _controller = CameraController(
        cameras[selectedCameraIndex],
        ResolutionPreset.high,
      );
      await _controller?.initialize();
      setState(() {
        isCameraInitialized = true;
      });
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }

  void _switchCamera() async {
    if (cameras.isEmpty) return;

    // Toggle the camera index between 0 and 1
    selectedCameraIndex = (selectedCameraIndex + 1) % cameras.length;

    setState(() {
      isCameraInitialized = false; // Temporarily disable the preview
    });

    await _controller?.dispose(); // Dispose the current controller
    _initializeCamera(); // Reinitialize the camera with the new index
  }

  // Take a picture
  void _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera not ready')),
      );
      return;
    }

    try {
      final XFile picture = await _controller!.takePicture();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Picture taken: ${picture.path}')),
      );
    } catch (e) {
      debugPrint('Error taking picture: $e');
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
            onPressed: _switchCamera, // Call the switch camera method
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
            // Main content: Camera preview and button
            isCameraInitialized
                ? Column(
                    children: [
                      // Centered camera preview with 3:4 aspect ratio
                      Center(
                        child: Transform.scale(
                          scale: 0.8, // Scale to 90%
                          // Maintain original camera aspect ratio
                          child: SizedBox(
                            width: screenSize.width,
                            height:
                                screenSize.height * 0.8, // Show 70% of height
                            child: CameraPreview(_controller!),
                          ),
                        ),
                      ),
                      const SizedBox(height: -10),
                      Align(
                        alignment: Alignment.topCenter,
                        // Button to take a picture
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GestureDetector(
                            onTap: _takePicture,
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 4,
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white, // White loading spinner
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
