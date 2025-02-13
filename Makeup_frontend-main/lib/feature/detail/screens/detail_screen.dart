import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/detail/widget/buy_now.dart';
import 'package:flutter_application_1/feature/detail/widget/content_intro.dart';
import 'package:flutter_application_1/feature/detail/widget/my_header.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            MyHeader(),
            Positioned(
              left: 0,
              right: 0,
              top: 290,
              child: Column(
                children: <Widget>[
                  ContentIntro(),
                  SizedBox(
                    height: 24,
                  ),
                  BuyNow()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
