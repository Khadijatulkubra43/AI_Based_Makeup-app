import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/camera/screens/display_picture_screen.dart';
import 'package:image_picker/image_picker.dart';

class CamerPage extends StatefulWidget {
  const CamerPage({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  State<CamerPage> createState() => _CamerPageState();
}

class _CamerPageState extends State<CamerPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  final ImagePicker _imagePicker = ImagePicker(); // ImagePicker instance
  late List<CameraDescription> _cameras;
  late CameraDescription _currentCamera;

  @override
  void initState() {
    super.initState();
    _initializeCamera(widget.camera);
  }

  // Function to initialize the camera
  Future<void> _initializeCamera(CameraDescription cameraDescription) async {
    _controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
    );

    // Initialize the controller and store available cameras
    _initializeControllerFuture = _controller.initialize();
    _cameras = await availableCameras();
    _currentCamera = cameraDescription;
    setState(() {});
  }

  @override
  void dispose() {
    // Dispose of the controller to release the camera resources.
    _controller.dispose();
    super.dispose();
  }

  // Function to switch between front and back cameras
  Future<void> _switchCamera() async {
    final newCamera = _currentCamera.lensDirection == CameraLensDirection.back
        ? _cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front)
        : _cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.back);

    await _initializeCamera(newCamera);
  }

  // Function to pick an image from the gallery
  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? pickedImage =
          await _imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null && context.mounted) {
        // Navigate to display the picked image
        if (!mounted) {
          return;
        }
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                DisplayPictureScreen(imagePath: pickedImage.path),
          ),
        );
      }
    } catch (e) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error picking image"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Preview'),
        automaticallyImplyLeading: false,
        actions: [
          // Add switch camera button in the AppBar actions
          IconButton(
            icon: const Icon(Icons.switch_camera),
            onPressed: _switchCamera,
            tooltip: 'Switch Camera',
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Show camera preview when initialization is complete.
            return CameraPreview(_controller);
          } else {
            // Display a loading indicator until the camera is ready.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      // Two Floating Action Buttons: Camera Capture and Gallery Picker
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Button to pick an image from the gallery
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: FloatingActionButton(
              heroTag: 'gallery',
              onPressed: _pickImageFromGallery,
              tooltip: 'Pick Image from Gallery',
              child: const Icon(Icons.photo),
            ),
          ),
          // Button to take a picture using the camera
          FloatingActionButton(
            heroTag: 'camera',
            onPressed: () async {
              try {
                // Ensure that the camera is initialized.
                await _initializeControllerFuture;

                // Take the picture and save it to a file.
                final image = await _controller.takePicture();

                if (!context.mounted) return;

                // Navigate to display the picture.
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        DisplayPictureScreen(imagePath: image.path),
                  ),
                );
              } catch (e) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Error Occured"),
                  ),
                );
              }
            },
            tooltip: 'Capture Image',
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}
