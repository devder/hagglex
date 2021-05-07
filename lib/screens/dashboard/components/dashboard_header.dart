import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class DashboardHeader extends StatefulWidget {
  final String username;
  const DashboardHeader({
    Key key,
    this.username,
  }) : super(key: key);

  @override
  _DashboardHeaderState createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  bool showNGN = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 10),
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   colors: [Color(0xff2E1963), Color(0xff00AEFF)],
        // ),
        color: Color(0xff2E1963),
      ),
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 7),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      // width: 2,
                    )),
                child: Container(
                  alignment: Alignment.center,
                  height: 39,
                  width: 39,
                  decoration: BoxDecoration(
                    color: Color(0xffE9BBFF),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xff2E1963),
                      width: 3,
                    ),
                  ),
                  child: Text(
                    'SV',
                    style: TextStyle(
                        color: Color(0xff2E1963), fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Text(
                'HaggleX',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Badge(
                  badgeContent: Text('5'),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffE9BBFF).withOpacity(0.1)),
                    child: Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 15,
                    ),
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, bottom: 10),
            child: Text(
              "Total portfolio balance",
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              showNGN ? 'N0.00' : '\$****',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            Switch(
              value: showNGN,
              onChanged: (val) {
                setState(() {
                  showNGN = val;
                });
              },
            )
          ])
        ],
      )),
    );
  }
}
