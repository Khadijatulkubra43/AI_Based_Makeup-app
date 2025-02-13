import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;

  const WelcomeButton({
    required this.buttonText,
    required this.onTap,
    required this.color,
    required this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Trigger the function when tapped
      child: Container(
        height: 120,
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: textColor),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: textColor,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
