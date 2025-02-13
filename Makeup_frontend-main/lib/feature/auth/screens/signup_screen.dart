import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/auth/screens/signin_screen.dart';
import 'package:flutter_application_1/core/services/api_service.dart';
import 'package:flutter_application_1/feature/auth/widgets/my_text_form_field.dart';
import 'package:flutter_application_1/feature/auth/widgets/socialmedia_signin_row.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();
  bool _ispasswordvisible1 = false;
  bool _ispasswordvisible2 = false;
  bool _isLoading = false;
  final _formSignupKey = GlobalKey<FormState>();
  bool agreePersonalData = true;

  void _register() async {
    setState(() {
      _isLoading = true;
    });

    // Call API service
    Map<String, dynamic> errors = await ApiService.register(
      _usernameController.text,
      _password1Controller.text,
      _password2Controller.text,
      "", // No EMAIL PASSING
      _firstnameController.text,
      _lastnameController.text,
    );

    if (!mounted) {
      return;
    }

    // Check for errors
    if (errors.isEmpty) {
      // Navigate to SignInScreen after successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignInScreen(
            username: _usernameController.text,
            password: _password1Controller.text,
            camera: widget.camera,
          ),
        ),
      );
    } else {
      // Extract the first error message from the map
      String firstErrorMessage =
          errors.entries.first.value[0]; // First error message

      // Display the first error message in a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(firstErrorMessage),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
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
          padding: const EdgeInsets.only(top: 85),
          child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
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
                  key: _formSignupKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // get started text
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 20),
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 227, 114, 217),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MyTextFormField(
                              controller: _firstnameController,
                              label: "First Name",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter First Name';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: MyTextFormField(
                              controller: _lastnameController,
                              label: "Last Name",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Last Name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      MyTextFormField(
                        controller: _usernameController,
                        label: "Userame",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username';
                          }
                          if (value.length < 3 || value.length > 16) {
                            return 'Username must be between 3 and 16 characters.';
                          }
                          final RegExp usernameRegex =
                              RegExp(r'^[a-zA-Z0-9_{"."}]+$');
                          if (!usernameRegex.hasMatch(value)) {
                            return 'Username can only contain letters, numbers, and underscores.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10.0),
                      MyTextFormField(
                        controller: _password1Controller,
                        label: "Password",
                        obscureText: !_ispasswordvisible1,
                        validator: (value) {
                          // Check for null or empty input
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          // Length validation
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          // Uppercase letter check
                          if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
                            return 'Password must contain at least 1 uppercase letter';
                          }
                          // Special character check
                          if (!RegExp(r'^(?=.*[!@#\$%^&*(),.?":{}|<>])')
                              .hasMatch(value)) {
                            return 'Password must contain at least 1 special character';
                          }
                          return null; // Return null if the password is valid
                        },
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _ispasswordvisible1 = !_ispasswordvisible1;
                            });
                          },
                          icon: Icon(
                            _ispasswordvisible1
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      MyTextFormField(
                        controller: _password2Controller,
                        label: "Confirm Password",
                        obscureText: !_ispasswordvisible2,
                        validator: (value) {
                          if (value != _password1Controller.text) {
                            return 'Password Did not Match';
                          }
                          // Check for null or empty input
                          if (value == null || value.isEmpty) {
                            return 'Please Confirm Password';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _ispasswordvisible2 = !_ispasswordvisible2;
                            });
                          },
                          icon: Icon(
                            _ispasswordvisible2
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: agreePersonalData,
                            onChanged: (bool? value) {
                              setState(() {
                                agreePersonalData = value!;
                              });
                            },
                            activeColor:
                                const Color.fromARGB(255, 243, 108, 227),
                          ),
                          const Text(
                            'I agree to the processing of ',
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                          const Text(
                            'Personal data',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 229, 126, 207),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      // signup button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formSignupKey.currentState!.validate() &&
                                agreePersonalData) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Processing Data'),
                                ),
                              );
                              _register();
                            } else if (!agreePersonalData) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please agree to the processing of personal data',
                                  ),
                                ),
                              );
                            }
                          },
                          child: (!_isLoading)
                              ? const Text('Sign up')
                              : const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SocialmediaSigninRow(
                          iconColor: Color.fromARGB(255, 227, 117, 211)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (e) => SignInScreen(
                                    camera: widget.camera,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 227, 117, 211),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
