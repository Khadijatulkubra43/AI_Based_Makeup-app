import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants.dart';
import 'package:flutter_application_1/feature/detail/widget/rating_bar.dart';

class ContentIntro extends StatelessWidget {
  const ContentIntro({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: mDarkBackgroundColor,
        borderRadius: BorderRadius.circular(36),
      ),
      child: Column(
        children: <Widget>[
          const Text(
            'Make up Beauty Products',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Lorem Ipsum is simply dummy text of the printing and '
            'typesetting industry.Lorem Ipsum is simply dummy '
            'text of the printing and typesetting industry.Lorem '
            'Ipsum is simply dummy text of the printing and typesetting '
            'industry.Lorem Ipsum is simply dummy text of the printing '
            'and typesetting industry.Lorem Ipsum is simply dummy '
            'text of the printing and typesetting industry.Lorem '
            'Ipsum is simply dummy text of the printing and '
            'typesetting industry.',
            style: TextStyle(height: 1.8, color: Colors.white54),
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Kiran Millwood Hargrave',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            '13 July 2020',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RatingBar(
                onRatingUpdate: (value) {},
                maxRating: 5,
                size: 18,
                value: 4.8,
                selectColor: mPrimaryColor,
              ),
              const Text(
                '4.8',
                style: TextStyle(color: Colors.white54),
              ),
              const Text(
                '/5.0',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: mPrimaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset('assets/images/share.png'),
              ),
              const SizedBox(
                width: 48,
              ),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset('assets/images/mark.png'),
              ),
              const SizedBox(
                width: 48,
              ),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset('assets/images/star.png'),
              )
            ],
          )
        ],
      ),
    );
  }
}
