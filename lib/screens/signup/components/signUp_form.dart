import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../countries/countries_screen.dart';

class SignUpForm extends StatefulWidget {
  final Function runMutationFunction;
  final bool isLoading;

  const SignUpForm({Key key, this.runMutationFunction, this.isLoading})
      : super(key: key);
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
    'username': '',
    'password': '',
    'phonenumber': '',
    'refferalCode': '',
    'country': 'Nigeria',
    'currency': 'NGN'
  };

  final _passwordController = TextEditingController();
  bool _obscureText = true;
  Map country;

  void _navigateToCountriesScreen(BuildContext context) async {
    country = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CountriesScreen()),
    );
    if (country != null) {
      _authData['country'] = country['name'];
      _authData['currency'] = country['currencyCode'];
      setState(() {});
    }
  }

  Future<void> _submit() async {
    try {
      if (!_formKey.currentState.validate()) {
        // Invalid!
        return;
      }
      _formKey.currentState.save();
      widget.runMutationFunction({
        "email": _authData["email"],
        "username": _authData["username"],
        "password": _authData["password"],
        "phonenumber": _authData["phonenumber"],
        "referralCode": _authData["referralCode"],
        "country": _authData["country"],
        "currency": _authData["currency"],
      });
    } catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Material(
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color: Colors.white,
        elevation: 3,
        child: Container(
          width: double.infinity,
          height: deviceSize.height * 0.8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Create a new account',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          labelText: 'Email Address',
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Basis Grotesque Pro',
                              fontSize: 11)),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter your email address';
                        }
                        bool validEmail = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!validEmail) {
                          return 'Invalid email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['email'] = value;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      cursorColor: Colors.black,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          labelText: 'Password (Min 8 characters)',
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Basis Grotesque Pro',
                              fontSize: 11)),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty || value.length < 8) {
                          return 'Password must be longer than 8 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['password'] = value;
                      },
                    ),
                    TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          labelText: 'Create a username',
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Basis Grotesque Pro',
                              fontSize: 11)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter your username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['username'] = value;
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 32,
                                color: Color(0xFF7bb142).withOpacity(0.08))
                          ]),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _navigateToCountriesScreen(context);
                            },
                            child: Container(
                              width: 90,
                              margin: const EdgeInsets.only(right: 5),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xff000000)
                                        .withOpacity(0.46)),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    width: 24,
                                    height: 15,
                                    child: SvgPicture.network(country != null
                                        ? country["flag"]
                                        : "https://restcountries.eu/data/nga.svg"),
                                  ),
                                  Text(
                                    '(+${country != null ? country["callingCode"] : "234"})',
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Enter your phone number',
                                hintStyle: TextStyle(fontSize: 12),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter your phone number';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['phonenumber'] = value;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          labelText: 'Referral Code (optional)',
                          labelStyle: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontFamily: 'Basis Grotesque Pro',
                              fontSize: 11)),
                      onSaved: (value) {
                        _authData['refferalCode'] = value;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "By signing, you agree to HaggleX terms and privacy policy.",
                      style: TextStyle(fontSize: 10),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (widget.isLoading)
                      Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator.adaptive())
                    else
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            gradient: LinearGradient(colors: [
                              Color(0xff432B7B),
                              Color(0xff6A4BBC)
                            ])),
                        child: MaterialButton(
                          height: 50,
                          onPressed: () {
                            _submit();
                          },
                          minWidth: double.infinity,
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
