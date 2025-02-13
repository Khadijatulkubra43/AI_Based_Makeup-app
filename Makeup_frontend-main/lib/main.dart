import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/welcome/screens/welcome_screen.dart';
import 'package:flutter_application_1/core/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MyApp(
    camera: firstCamera,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightMode,
      home: WelcomeScreen(
        camera: camera,
      ),
    );
  }
}
