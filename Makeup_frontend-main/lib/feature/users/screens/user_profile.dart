import 'package:flutter/material.dart';
import '../widgets/info_card.dart'; // Ensure this file exists and is correctly implemented.

// Our data
const url = "khadija.me";
const email = "abc123@gmail.com";
const phone = "+923-------2"; // Not a real number :)
const location = "Karachi, Pakistan";

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 100),
        child: Column(
          children: <Widget>[
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
            const Text(
              "Khadija Tul Kubra",
              style: TextStyle(
                fontSize: 40.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "Pacifico",
              ),
            ),
            Text(
              "Flutter Developer",
              style: TextStyle(
                fontSize: 30,
                color: Colors.blueGrey[200],
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
                fontFamily: "Source Sans Pro",
              ),
            ),
            const SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.white,
              ),
            ),
            // InfoCard widgets
            InfoCard(
              text: phone,
              icon: Icons.phone,
              onPressed: () {
                // Action when tapped
              },
            ),
            InfoCard(
              text: url,
              icon: Icons.web,
              onPressed: () {
                // Action when tapped
              },
            ),
            InfoCard(
              text: location,
              icon: Icons.location_city,
              onPressed: () {
                // Action when tapped
              },
            ),
            InfoCard(
              text: email,
              icon: Icons.email,
              onPressed: () {
                // Action when tapped
              },
            ),
          ],
        ),
      ),
    );
  }
}
