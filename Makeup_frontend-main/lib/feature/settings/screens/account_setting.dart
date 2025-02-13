import 'package:camera/camera.dart';
import 'package:flutter_application_1/core/services/api_service.dart';
import 'package:flutter_application_1/feature/settings/screens/edit_screen.dart';
import 'package:flutter_application_1/feature/settings/widgets/forward_button.dart';
import 'package:flutter_application_1/feature/settings/widgets/setting_item.dart';
import 'package:flutter_application_1/feature/settings/widgets/setting_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/welcome/screens/welcome_screen.dart';
import 'package:ionicons/ionicons.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isDarkMode = false;

  String _fullname = 'Defaul User';
  String _username = 'username.me';

  Future<void> getUsername() async {
    try {
      dynamic userDetails = await ApiService.getUserName();
      setState(() {
        _fullname = "${userDetails["firstname"]} ${userDetails["lastname"]}";
        _username = userDetails['username'];
      });
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

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Settings",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Account",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Image.asset("assets/images/avatar.png",
                      width: 50, height: 50),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _fullname,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _username,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  ForwardButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditAccountScreen(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Settings",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            SettingItem(
              title: "Language",
              icon: Ionicons.earth,
              bgColor: Colors.orange.shade100,
              iconColor: Colors.orange,
              value: "English",
              onTap: () {},
            ),
            const SizedBox(height: 20),
            SettingItem(
              title: "Notifications",
              icon: Ionicons.notifications,
              bgColor: Colors.blue.shade100,
              iconColor: Colors.blue,
              onTap: () {},
            ),
            const SizedBox(height: 20),
            SettingSwitch(
              title: "Dark Mode",
              icon: Ionicons.earth,
              bgColor: Colors.purple.shade100,
              iconColor: Colors.purple,
              value: isDarkMode,
              onTap: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),
            const SizedBox(height: 20),
            SettingItem(
              title: "Help",
              icon: Ionicons.nuclear,
              bgColor: Colors.red.shade100,
              iconColor: Colors.red,
              onTap: () {},
            ),
            const SizedBox(height: 20),
            SettingItem(
              title: "Logout",
              icon: Ionicons.nuclear,
              bgColor: Colors.deepOrange.shade100,
              iconColor: Colors.deepOrange,
              onTap: () async {
                await ApiService.logout();
                if (!context.mounted) {
                  return;
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(camera: widget.camera),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
