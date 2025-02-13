import 'package:flutter/material.dart';

class SocialmediaSigninRow extends StatelessWidget {
  final Color iconColor;
  const SocialmediaSigninRow({super.key, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    thickness: 0.7,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 10,
                  ),
                  child: Text(
                    'Sign up with',
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 0.7,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.facebook,
                  color: iconColor,
                ),
                Icon(
                  Icons.g_mobiledata_rounded,
                  color: iconColor,
                ),
                Icon(
                  Icons.apple,
                  color: iconColor,
                ),
              ],
            ),
          ],
        ));
  }
}
