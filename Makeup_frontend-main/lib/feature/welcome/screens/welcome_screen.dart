import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/auth/screens/signup_screen.dart';
import 'package:flutter_application_1/feature/auth/screens/signin_screen.dart';
import 'package:flutter_application_1/feature/welcome/widgets/welcome_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const Spacer(flex: 2),
            const Text(
              'Welcome',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 45.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const Spacer(flex: 4),
            Row(
              children: [
                Expanded(
                  child: WelcomeButton(
                    buttonText: 'Login',
                    onTap: () => _navigateTo(
                        context,
                        SignInScreen(
                          camera: camera,
                        )),
                    color: Colors.transparent,
                    textColor: Colors.white,
                  ),
                ),
                Expanded(
                  child: WelcomeButton(
                    buttonText: 'Sign up',
                    onTap: () =>
                        _navigateTo(context, SignUpScreen(camera: camera)),
                    color: Colors.white,
                    textColor: const Color.fromARGB(255, 195, 56, 207),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
