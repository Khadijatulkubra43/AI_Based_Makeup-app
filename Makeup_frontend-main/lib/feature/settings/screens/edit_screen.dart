import 'package:flutter_application_1/core/services/api_service.dart';
import 'package:flutter_application_1/feature/settings/widgets/gender_selector.dart';
import 'package:flutter_application_1/feature/settings/widgets/edit_item.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  bool _isEditEnabled = false;

  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();

  final _formUpdateKey = GlobalKey<FormState>();

  Future<void> getUserDetails() async {
    try {
      dynamic userDetails = await ApiService.getUserDetails();
      setState(() {
        _firstnameController.text = userDetails["first_name"];
        _lastnameController.text = userDetails["last_name"];
        _emailController.text = userDetails["email"];
      });
      if (userDetails['age'] == null || userDetails['gender'] == null) {
        setState(() {
          _ageController.text = "0";
          _genderController.text = "M";
        });
      } else {
        setState(() {
          _ageController.text = "${userDetails['age']}";
          _genderController.text = userDetails['gender'];
        });
      }
    } catch (e) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to get user details"),
        ),
      );
    }
  }

  void updateDetails() async {
    bool success = await ApiService.updateUserDetails(
      _firstnameController.text,
      _lastnameController.text,
      _emailController.text,
      _ageController.text,
      _genderController.text,
    );
    if (!mounted) {
      return;
    }
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Update Information"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to Update"),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _firstnameController.text = 'n\\a';
    _lastnameController.text = 'n\\a';
    _emailController.text = 'n\\a';
    _ageController.text = '0';
    _genderController.text = 'M';

    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 80,
        actions: [
          (_isEditEnabled == false)
              ? const SizedBox(
                  width: 5,
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                      onPressed: () {
                        getUserDetails();
                        setState(() {
                          _isEditEnabled = !_isEditEnabled;
                        });
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        fixedSize: const Size(60, 50),
                        elevation: 3,
                      ),
                      icon: const Icon(Icons.close, color: Colors.white)),
                ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                if (_isEditEnabled == true) {
                  if (_formUpdateKey.currentState?.validate() ?? false) {
                    // Form is valid
                    updateDetails();
                  } else {
                    // Form is invalid
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please fix the errors in the form')),
                    );
                  }
                }
                setState(() {
                  _isEditEnabled = !_isEditEnabled; // Toggle on click for now
                });
              },
              style: IconButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                fixedSize: const Size(60, 50),
                elevation: 3,
              ),
              icon: (_isEditEnabled == false)
                  ? const Icon(Icons.edit, color: Colors.white)
                  : const Icon(Ionicons.checkmark, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formUpdateKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Account",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                EditItem(
                  title: "Photo",
                  widget: Column(
                    children: [
                      Image.asset(
                        "assets/images/avatar.png",
                        height: 100,
                        width: 100,
                      ),
                      (_isEditEnabled)
                          ? TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.lightBlueAccent,
                              ),
                              child: const Text("Upload Image"),
                            )
                          : const SizedBox(
                              height: 5,
                            ),
                    ],
                  ),
                ),
                EditItem(
                  title: "First Name",
                  widget: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter First Name';
                      }
                      return null;
                    },
                    controller: _firstnameController,
                    enabled: _isEditEnabled,
                  ),
                ),
                const SizedBox(height: 40),
                EditItem(
                  title: "Last Name",
                  widget: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Last Name';
                      }
                      return null;
                    },
                    controller: _lastnameController,
                    enabled: _isEditEnabled,
                  ),
                ),
                const SizedBox(height: 40),
                EditItem(
                  title: "Gender",
                  widget: GenderSelector(
                      controller: _genderController,
                      isEnabled:
                          _isEditEnabled // Change to false to disable editing
                      ),
                ),
                const SizedBox(height: 40),
                EditItem(
                  title: "Age",
                  widget: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your age';
                      }
                      final int? age = int.tryParse(value);
                      if (age == null) {
                        return 'Age must be a valid number';
                      }
                      if (age <= 0 || age > 120) {
                        return 'Please enter a valid age between 1 and 120';
                      }
                      return null;
                    },
                    controller: _ageController,
                    enabled: _isEditEnabled,
                  ),
                ),
                const SizedBox(height: 40),
                EditItem(
                  title: "Email",
                  widget: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // Regular expression for a valid email format
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    controller: _emailController,
                    enabled: _isEditEnabled,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
