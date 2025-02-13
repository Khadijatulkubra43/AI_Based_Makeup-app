import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants.dart';
import 'package:flutter_application_1/feature/detail/widget/my_actionbar.dart';

class MyHeader extends StatelessWidget {
  const MyHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      height: 320,
      decoration: BoxDecoration(
        color: mCardBackgroundColor,
        image: const DecorationImage(
          image: AssetImage('assets/images/product_full_detail.png'),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: const MyActionbar(),
    );
  }
}
