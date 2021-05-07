import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class Auth with ChangeNotifier {
  String _token;
  Map _user;
  DateTime _expiryDate;
  bool _twoFactorAuth;
  static String username;

  bool get isAuth {
    return _token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return '';
  }

  void login(Map retrievedData) async {
    try {
      _token = retrievedData['token'];
      _user = retrievedData['user'];
      username = _user['username'];
      _twoFactorAuth = retrievedData['twoFactorAuth'];
      notifyListeners();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userData = jsonEncode(
          {"token": _token, "user": _user, "twoFactorAuth": _twoFactorAuth});

      // Map<String, dynamic> decodedToken = JwtDecoder.decode(_token);
      _expiryDate = JwtDecoder.getExpirationDate(_token);
      prefs.setString('userData', userData);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        jsonDecode(prefs.getString('userData')) as Map<String, Object>;

    final expiryDate = JwtDecoder.getExpirationDate(extractedUserData['token']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedUserData['token'];
    _user = extractedUserData['user'];
    _twoFactorAuth = extractedUserData['twoFactorAuth'];
    _expiryDate = expiryDate;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _user = null;
    _expiryDate = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    notifyListeners();
    //prefs.clear();// for clearing the entire local storage
  }
}
