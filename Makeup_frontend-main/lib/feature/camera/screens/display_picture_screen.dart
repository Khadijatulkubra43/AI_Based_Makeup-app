import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/services/api_service.dart';
import 'package:flutter_application_1/feature/camera/screens/image_screen.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  bool _isWaiting = false;

  // Function to pick and upload the image file
  Future<Uint8List?> pickAndUploadFile(String imgPath) async {
    File file = File(imgPath);
    Uint8List? imageBytes = await ApiService.uploadFile(file);

    setState(() {
      _isWaiting = false;
    });

    if (imageBytes != null) {
      return imageBytes;
    } else {
      _scaffoldKey.currentState?.showSnackBar(
        const SnackBar(content: Text("File Upload Failed")),
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Display Picture'),
      ),
      body: Center(
        child: Image.file(File(widget.imagePath)), // Local Image Display
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: ElevatedButton(
          onPressed: () async {
            setState(() {
              _isWaiting = true;
            });
            // Upload and get the image bytes from the server
            Uint8List? serverImageBytes =
                await pickAndUploadFile(widget.imagePath);

            if (serverImageBytes != null) {
              if (!context.mounted) return;

              // Navigate to the ImageScreen and pass the image bytes
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageScreen(
                    imageBytes: serverImageBytes,
                  ),
                ),
              );
            }
          },
          child: (_isWaiting)
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : const Text("Apply Make-up"),
        ),
      ),
    );
  }
}
