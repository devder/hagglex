import 'package:flutter/material.dart';
import 'package:hagglex/providers/auth_provider.dart';
import 'package:hagglex/screens/login/login_screen.dart';
import 'package:provider/provider.dart';
import 'components/advert_carousel.dart';
import 'components/crypto_list.dart';
import 'components/dashboard_header.dart';
import 'components/do_more.dart';
import 'components/news.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/dashboard';
  @override
  Widget build(BuildContext context) {
    final username = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.exit_to_app_outlined,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (ctx) => LoginScreen(),
            ),
          );
          Provider.of<Auth>(context, listen: false).logout();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/dasbboard.png',
              scale: 3,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/wallet.png',
                scale: 3,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/Savings.png',
                scale: 3,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/Utilities.png',
                scale: 3,
              ),
              label: ''),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DashboardHeader(username: username),
            AdvertCarousel(),
            CryptoList(),
            DoMore(),
            News()
          ],
        ),
      ),
    );
  }
}
