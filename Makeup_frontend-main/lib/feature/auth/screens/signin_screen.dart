import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/navigation/navigation_menu.dart';
import 'package:flutter_application_1/feature/auth/screens/signup_screen.dart';
import 'package:flutter_application_1/core/theme/theme.dart';
import 'package:flutter_application_1/core/services/api_service.dart';
import 'package:flutter_application_1/feature/auth/widgets/my_text_form_field.dart';
import 'package:flutter_application_1/feature/auth/widgets/socialmedia_signin_row.dart';

class SignInScreen extends StatefulWidget {
  final String username;
  final String password;
  const SignInScreen({
    super.key,
    this.username = '',
    this.password = '',
    required this.camera,
  });

  final CameraDescription camera;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool rememberPassword = true;

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.username;
    _passwordController.text = widget.password;
  }

  Future<void> _login() async {
    setState(() => _isLoading = true);
    bool success = await ApiService.login(
        _usernameController.text, _passwordController.text);

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (success) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => NavigationMenu(
                    camera: widget.camera,
                  )));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Failed to login")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            margin: const EdgeInsets.all(2.0),
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 30),
                      child: Text(
                        'Welcome Back',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w900,
                            color: lightColorScheme.primary),
                      ),
                    ),
                    // Username Field
                    MyTextFormField(
                      controller: _usernameController,
                      label: 'Username',
                      hint: 'Enter Username',
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a username' : null,
                    ),
                    const SizedBox(height: 15.0),

                    // Password Field
                    MyTextFormField(
                      controller: _passwordController,
                      label: 'Password',
                      hint: 'Enter Password',
                      obscureText: !_isPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(_isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a password' : null,
                    ),
                    const SizedBox(height: 15.0),

                    // Remember Me and Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: rememberPassword,
                              onChanged: (value) {
                                setState(() => rememberPassword = value!);
                              },
                            ),
                            const Text(
                              'Remember me',
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text('Forgot password?',
                              style: TextStyle(
                                  color: lightColorScheme.primary,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    // Sign In Button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            rememberPassword) {
                          _login();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Please agree to the processing of personal data')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text('Sign In'),
                    ),
                    // sign up social media logo
                    const SocialmediaSigninRow(iconColor: Colors.blue),
                    // Sign Up Option
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.black45,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        SignUpScreen(camera: widget.camera)));
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                                color: lightColorScheme.primary,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
