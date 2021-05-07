import 'package:flutter/material.dart';

class AdvertCarousel extends StatelessWidget {
  const AdvertCarousel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
          child: Image.asset(
            'assets/images/OTC-1.png',
            scale: 2.7,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
          child: Image.asset(
            'assets/images/Mask Group 504.png',
            scale: 2.7,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
          child: Image.asset(
            'assets/images/haggleX ambassadoe.png',
            scale: 2.7,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
          child: Image.asset(
            'assets/images/haggleX ambassadoe-1.png',
            scale: 2.7,
          ),
        )
      ]),
    );
  }
}
