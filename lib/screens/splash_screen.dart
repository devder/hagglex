import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hagglex/screens/login/login_screen.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard/dashboard_screen.dart';

class SplashScreen extends StatelessWidget {
  //check for user and push to dashboard or login wrt the outcome
  initMethod(context) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    }
    Map extractedUserData =
        jsonDecode(prefs.getString('userData')) as Map<String, Object>;

    final expiryDate = JwtDecoder.getExpirationDate(extractedUserData['token']);
    if (expiryDate.isBefore(DateTime.now())) {
      return Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    }

    return Navigator.of(context)
        .pushReplacementNamed(DashboardScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => initMethod(context));

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
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 60,
                  height: 60,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'HaggleX',
                  style: TextStyle(
                      fontSize: 24,
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
