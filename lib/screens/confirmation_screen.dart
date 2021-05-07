import 'package:flutter/material.dart';

import 'dashboard/dashboard_screen.dart';

class ConfirmAtionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Path 1087.png'),
                  fit: BoxFit.cover),
            ),
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              width: double.infinity,
              height: deviceSize.height * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/icons/start.png',
                          height: 64,
                          width: 64,
                        ),
                        Text(
                          'Setup Complete',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                        Text(
                          'Thank you for setting up your HaggleX account',
                          style: TextStyle(fontSize: 9, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    height: 50,
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, DashboardScreen.routeName);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    color: Color(0xffFFC175),
                    minWidth: double.infinity,
                    child: Text(
                      'START EXPLORING',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
