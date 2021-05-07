import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  final imagePath;
  final coinName;
  final coinPrice;
  final graphPath;
  final gains;
  const CryptoCard({
    Key key,
    this.imagePath,
    this.coinName,
    this.coinPrice,
    this.graphPath,
    this.gains,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(imagePath), fit: BoxFit.cover)),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          coinName,
                          style: TextStyle(fontSize: 13),
                        ),
                        SizedBox(height: 5),
                        RichText(
                            text: TextSpan(
                          children: [
                            TextSpan(
                              text: coinPrice,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 9),
                            ),
                            TextSpan(text: "  "),
                            TextSpan(
                                text: gains,
                                style: TextStyle(
                                    color: Color(0xff52CB35), fontSize: 9))
                          ],
                        ))
                      ],
                    ),
                    Image.asset(graphPath, scale: 3)
                  ]),
            ),
          ]),
        )),
        Divider()
      ],
    );
  }
}
