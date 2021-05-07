import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex/screens/login/login_screen.dart';

class VerificationForm extends StatefulWidget {
  final Function runMutation;
  final bool isLoading;
  final String email;

  const VerificationForm(
      {Key key, this.runMutation, this.isLoading, this.email})
      : super(key: key);
  @override
  _VerificationFormState createState() => _VerificationFormState();
}

class _VerificationFormState extends State<VerificationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _resendCode = false;
  String _code = '';

  void _sendVerificationCode() {
    try {
      if (!_formKey.currentState.validate()) {
        // Invalid!
        return;
      }
      final code = int.parse(_code);
      _formKey.currentState.save();
      widget.runMutation({"code": code});
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset(
                'assets/icons/back.png',
                height: 60,
                width: 50,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => LoginScreen()));
            },
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Verify your account',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Material(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            color: Colors.white,
            elevation: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              width: double.infinity,
              height: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/icons/Group 346.png',
                    height: 64,
                    width: 64,
                  ),
                  Text(
                    'We just sent a verification code to your email.\nPlease enter the code',
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      maxLength: 6,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          labelText: 'Verification Code',
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Basis Grotesque Pro',
                              fontSize: 11)),
                      // keyboardType: TextInputType.number,Z
                      validator: (value) {
                        if (value.length < 6) {
                          return 'Please enter the 6 digit code';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _code = value;
                      },
                    ),
                  ),
                  if (widget.isLoading)
                    CircularProgressIndicator.adaptive()
                  else
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          gradient: LinearGradient(
                              colors: [Color(0xff432B7B), Color(0xff6A4BBC)])),
                      child: MaterialButton(
                        height: 50,
                        onPressed: _sendVerificationCode,
                        minWidth: double.infinity,
                        child: Text(
                          'VERIFY ME',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  Text(
                    'This code will expire in 10 minutes',
                    style: TextStyle(fontSize: 9),
                  ),
                  if (_resendCode)
                    Query(
                        options: QueryOptions(
                            document: gql(resendVerificationCodeQuery),
                            variables: {
                              "email": widget.email != null ? widget.email : ""
                            }),
                        builder: (QueryResult result,
                            {VoidCallback refetch, FetchMore fetchMore}) {
                          return TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    'Verification code was resent to your email'),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                                margin: const EdgeInsets.all(16),
                              ));
                              refetch();
                            },
                            child: Text(
                              'Resend Code',
                              style: TextStyle(
                                color: Color(0xff432B7B),
                              ),
                            ),
                          );
                        })
                  else
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _resendCode = true;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Verification code was resent to your email'),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.all(16),
                          ));
                        });
                      },
                      child: Text(
                        'Resend Code',
                        style: TextStyle(
                          color: Color(0xff432B7B),
                        ),
                      ),
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

String resendVerificationCodeQuery = """
query ResendVerificationCode(\$email:String!){
  resendVerificationCode(data:{email:\$email})
}
""";
