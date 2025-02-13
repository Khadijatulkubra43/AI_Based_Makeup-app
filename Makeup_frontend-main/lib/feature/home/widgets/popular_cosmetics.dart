import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants.dart';
// import 'package:flutter_application_1/screens/Home/widget/popular_cosmetics_listview.dart';

class PopularCosmetics extends StatelessWidget {
  const PopularCosmetics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: mDarkBackgroundColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: const Text(
              'Popular Cosmetics',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          // PopularCosmeticsListview(),
        ],
      ),
    );
  }
}
