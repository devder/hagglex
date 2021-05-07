import 'package:flutter/material.dart';

class News extends StatelessWidget {
  const News({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Trending crypto news',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          height: 50,
          child: Row(children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Image.asset(
                'assets/images/btctrending.png',
                height: 50,
                width: 52,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Blockchain Bites: BTC on Ethereum, DeFi’s latest stablecoin, the currency cold wars',
                      style: TextStyle(fontSize: 12),
                    ),
                    // SizedBox(height: 15),
                    Row(children: [
                      Text(
                        '6hrs ago',
                        style: TextStyle(color: Color(0xff838383), fontSize: 9),
                      ),
                      SizedBox(width: 25),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Category: ',
                              style: TextStyle(
                                  color: Color(0xff838383), fontSize: 9),
                            ),
                            TextSpan(
                              text: 'DeFi',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 9),
                            ),
                          ],
                        ),
                      ),
                    ])
                  ]),
            )
          ]),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          height: 50,
          child: Row(children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Image.asset(
                'assets/images/btctrending.png',
                height: 50,
                width: 52,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Blockchain Bites: BTC on Ethereum, DeFi’s latest stablecoin, the currency cold wars',
                      style: TextStyle(fontSize: 12),
                    ),
                    // SizedBox(height: 15),
                    Row(children: [
                      Text(
                        '6hrs ago',
                        style: TextStyle(color: Color(0xff838383), fontSize: 9),
                      ),
                      SizedBox(width: 25),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Category: ',
                              style: TextStyle(
                                  color: Color(0xff838383), fontSize: 9),
                            ),
                            TextSpan(
                              text: 'DeFi',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 9),
                            ),
                          ],
                        ),
                      ),
                    ])
                  ]),
            )
          ]),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          height: 50,
          child: Row(children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Image.asset(
                'assets/images/btctrending.png',
                height: 50,
                width: 52,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Blockchain Bites: BTC on Ethereum, DeFi’s latest stablecoin, the currency cold wars',
                      style: TextStyle(fontSize: 12),
                    ),
                    // SizedBox(height: 15),
                    Row(children: [
                      Text(
                        '6hrs ago',
                        style: TextStyle(color: Color(0xff838383), fontSize: 9),
                      ),
                      SizedBox(width: 25),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Category: ',
                              style: TextStyle(
                                  color: Color(0xff838383), fontSize: 9),
                            ),
                            TextSpan(
                              text: 'DeFi',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 9),
                            ),
                          ],
                        ),
                      ),
                    ])
                  ]),
            )
          ]),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          height: 50,
          child: Row(children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Image.asset(
                'assets/images/btctrending.png',
                height: 50,
                width: 52,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Blockchain Bites: BTC on Ethereum, DeFi’s latest stablecoin, the currency cold wars',
                      style: TextStyle(fontSize: 12),
                    ),
                    // SizedBox(height: 15),
                    Row(children: [
                      Text(
                        '6hrs ago',
                        style: TextStyle(color: Color(0xff838383), fontSize: 9),
                      ),
                      SizedBox(width: 25),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Category: ',
                              style: TextStyle(
                                  color: Color(0xff838383), fontSize: 9),
                            ),
                            TextSpan(
                              text: 'DeFi',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 9),
                            ),
                          ],
                        ),
                      ),
                    ])
                  ]),
            )
          ]),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          height: 50,
          child: Row(children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Image.asset(
                'assets/images/btctrending.png',
                height: 50,
                width: 52,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Blockchain Bites: BTC on Ethereum, DeFi’s latest stablecoin, the currency cold wars',
                      style: TextStyle(fontSize: 12),
                    ),
                    // SizedBox(height: 15),
                    Row(children: [
                      Text(
                        '6hrs ago',
                        style: TextStyle(color: Color(0xff838383), fontSize: 9),
                      ),
                      SizedBox(width: 25),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Category: ',
                              style: TextStyle(
                                  color: Color(0xff838383), fontSize: 9),
                            ),
                            TextSpan(
                              text: 'DeFi',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 9),
                            ),
                          ],
                        ),
                      ),
                    ])
                  ]),
            )
          ]),
        ),
        Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'View all stories',
                  style: TextStyle(fontSize: 12),
                ),
                Icon(Icons.chevron_right)
              ],
            ))
      ]),
    );
  }
}
