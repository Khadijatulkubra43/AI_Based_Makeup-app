import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants.dart';

class MyActionbar extends StatelessWidget {
  const MyActionbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Image.asset(
                'assets/images/menu.png',
                color: mDarkBackgroundColor,
                width: 24,
              ),
              onPressed: () {
                // Add your menu button action here
              },
            ),
            IconButton(
              icon: Image.asset(
                'assets/images/cart.png',
                color: mDarkBackgroundColor,
                width: 24,
              ),
              onPressed: () {
                // Add your cart button action here
              },
            ),
          ],
        ),
      ),
    );
  }
}
