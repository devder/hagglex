import 'package:flutter/material.dart';

import 'crypto_card.dart';

class CryptoList extends StatelessWidget {
  const CryptoList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Markets',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        CryptoCard(
          imagePath: 'assets/images/biTCOIN.png',
          coinName: 'Haggle (HAG)',
          coinPrice: 'NGN 380',
          graphPath: 'assets/images/Group 875.png',
        ),
        CryptoCard(
          imagePath: 'assets/images/btc.png',
          coinName: 'Bitcoin (BTC)',
          coinPrice: 'NGN 23,492,747.68',
          graphPath: 'assets/images/Group 877.png',
          gains: '+2.34%',
        ),
        CryptoCard(
          imagePath: 'assets/images/ethereum.png',
          coinName: 'Ethereum (ETH)',
          coinPrice: 'NGN 1,422,086.30',
          graphPath: 'assets/images/Group 1769-1.png',
          gains: '+2.34%',
        ),
        CryptoCard(
          imagePath: 'assets/images/usdt.png',
          coinName: 'Tether (USDT)',
          coinPrice: 'NGN 377.00',
          graphPath: 'assets/images/Group 1769.png',
          gains: '+0.01%',
        ),
        CryptoCard(
          imagePath: 'assets/images/1831.png',
          coinName: 'Bitcoin Cash (BCH)',
          coinPrice: 'NGN 570,446.71',
          graphPath: 'assets/images/Group 876-1.png',
          gains: '+2.34%',
        ),
        CryptoCard(
          imagePath: 'assets/images/dogecoin-logo.png',
          coinName: 'Dodgecoin (DOGE)',
          coinPrice: 'NGN 269.41',
          graphPath: 'assets/images/Group 875-1.png',
          gains: '+2.34%',
        ),
        CryptoCard(
          imagePath: 'assets/images/LTC.png',
          coinName: 'Litecoin (LTC)',
          coinPrice: 'NGN 141,532.52',
          graphPath: 'assets/images/Group 876.png',
          gains: '+2.34%',
        ),
      ]),
    );
  }
}
