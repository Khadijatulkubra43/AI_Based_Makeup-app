import 'package:flutter/material.dart';
import 'dart:typed_data';


class ImageScreen extends StatelessWidget {
  final Uint8List imageBytes;

  const ImageScreen({super.key, required this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Server Processed Image'),
      ),
      body: Center(
        child: Image.memory(imageBytes), // Display server-processed image
      ),
    );
  }
}
