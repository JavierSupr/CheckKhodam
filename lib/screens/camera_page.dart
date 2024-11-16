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

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  // Initialize the camera
  void _initializeCamera() async {
    try {
      cameras = await availableCameras();
      selectedCamera = cameras.first; // Select the first camera
      _controller = CameraController(selectedCamera, ResolutionPreset.high);

      // Initialize the controller and update the state
      await _controller?.initialize();
      setState(() {
        isCameraInitialized = true;
      });
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
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
      body: isCameraInitialized
          ? Column(
              children: [
                // Display camera preview
                Expanded(
                  child: CameraPreview(_controller!),
                ),
                // Button to take a picture
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ElevatedButton(
                    onPressed: _takePicture,
                    child: const Text('Take Picture'),
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
