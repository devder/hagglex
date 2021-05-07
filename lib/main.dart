import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hagglex/providers/auth_provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/signup/signup_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/verification/verification_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await initHiveForFlutter();
  String _token = "";

//check for instance of user in shared preferences
  final prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('userData')) {
    final extractedUserData =
        jsonDecode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = JwtDecoder.getExpirationDate(extractedUserData['token']);
    if (!expiryDate.isBefore(DateTime.now())) {
      _token = extractedUserData['token'];
    }
  }

  final HttpLink httpLink = HttpLink(
    'https://hagglex-backend-staging.herokuapp.com/graphql',
  );
  final AuthLink authLink = AuthLink(getToken: () async => 'Bearer $_token');
  // AuthLink(getToken: () async => _token != "" ? 'Bearer $_token' : '');

  final Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );
  runApp(MyApp(
    client: client,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final ValueNotifier<GraphQLClient> client;
  const MyApp({Key key, this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => Auth())],
        child: Consumer<Auth>(
            builder: (ctx, auth, _) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: ThemeData(
                      fontFamily: 'Basis Grotesque Pro',
                      primarySwatch: Colors.deepPurple,
                      accentColor: Color(0xffFFC175)),
                  home: SplashScreen(),
                  // home: auth.isAuth
                  //     ? DashboardScreen()
                  //     : FutureBuilder(
                  //         future: auth.tryAutoLogin(),
                  //         builder: (ctx, authSnapshot) =>
                  //             authSnapshot.connectionState ==
                  //                     ConnectionState.waiting
                  //                 ? SplashScreen()
                  //                 : LoginScreen()),
                  routes: {
                    LoginScreen.routeName: (_) => LoginScreen(),
                    SignUpScreen.routeName: (_) => SignUpScreen(),
                    VerificationScreen.routeName: (_) => VerificationScreen(),
                    DashboardScreen.routeName: (_) => DashboardScreen()
                  },
                )),
      ),
    );
  }
}
