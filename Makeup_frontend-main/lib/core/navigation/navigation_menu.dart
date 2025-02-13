import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/camera/screens/camera_page.dart';
import 'package:flutter_application_1/feature/home/screens/home_screen.dart';
import 'package:flutter_application_1/feature/settings/screens/account_setting.dart';
import 'package:flutter_application_1/feature/users/screens/user_profile.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const MakeupRecommendationScreen(),
      CamerPage(camera: widget.camera),
      AccountScreen(camera: widget.camera),
      const UserProfile(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.pinkAccent, // Active icon color
        unselectedItemColor: Colors.white, // Inactive icon color
        backgroundColor:
            Colors.black, // Background color for the navigation bar
        type: BottomNavigationBarType.fixed, // Ensures all labels are visible
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            activeIcon: Icon(Icons.home, color: Colors.pinkAccent),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera, color: Colors.white),
            activeIcon: Icon(Icons.camera, color: Colors.pinkAccent),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.white),
            activeIcon: Icon(Icons.settings, color: Colors.pinkAccent),
            label: 'Setting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white),
            activeIcon: Icon(Icons.person, color: Colors.pinkAccent),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
