import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex/screens/dashboard/dashboard_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../signup/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
        body: Mutation(
      options: MutationOptions(
          document: gql(LOGIN_MUTATION),
          update: (GraphQLDataProxy cache, QueryResult result) {
            return cache;
          },
          onError: (err) {
            if (err.graphqlErrors.length > 0) {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text('${err.graphqlErrors[0].message}'),
                  backgroundColor: Theme.of(context).errorColor,
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(16),
                  action: SnackBarAction(
                      label: 'Close',
                      onPressed: () {
                        ScaffoldMessengerState().removeCurrentSnackBar(
                            reason: SnackBarClosedReason.action);
                      }),
                ));
            } else {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text("Network Error, please check your connection"),
                  backgroundColor: Theme.of(context).errorColor,
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(16),
                  action: SnackBarAction(
                      label: 'Close',
                      onPressed: () {
                        ScaffoldMessengerState().removeCurrentSnackBar(
                            reason: SnackBarClosedReason.action);
                      }),
                ));
            }
          },
          onCompleted: (dynamic resultData) {
            if (resultData != null) {
              Provider.of<Auth>(context, listen: false)
                  .login(resultData["login"]);
              Navigator.pushReplacementNamed(
                  context, DashboardScreen.routeName);
            }
          }),
      builder: (RunMutation runMutation, QueryResult result) {
        return Stack(
          children: [
            // Container(
            //   width: double.infinity,
            //   decoration: BoxDecoration(color: Color(0xff2E1963)),
            // ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/Path 1087.png'),
                    fit: BoxFit.cover),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: SingleChildScrollView(
                  child: Container(
                    height: deviceSize.height,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: deviceSize.height * 0.1,
                        ),
                        Text(
                          'Welcome!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffffffff),
                              fontSize: 40.0),
                        ),
                        SizedBox(
                          height: deviceSize.height * 0.06,
                        ),
                        AuthCard(
                            runMutationFunction: runMutation,
                            isLoading: result.isLoading),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    ));
  }
}

class AuthCard extends StatefulWidget {
  final Function runMutationFunction;
  final bool isLoading;

  const AuthCard({
    Key key,
    this.runMutationFunction,
    this.isLoading = false,
  }) : super(key: key);
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  final _passwordController = TextEditingController();
  bool _obscureText = true;

  Future<void> _submit() async {
    try {
      if (!_formKey.currentState.validate()) {
        // Invalid!
        return;
      }
      _formKey.currentState.save();
      widget.runMutationFunction(
          {"input": _authData["email"], "password": _authData["password"]});
    } catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              key: ValueKey('email'),
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: 'Email Address',
                  labelStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Basis Grotesque Pro',
                      fontSize: 11)),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty || !value.contains('@')) {
                  return 'Invalid email!';
                }
                return null;
              },
              onSaved: (value) {
                _authData['email'] = value;
              },
            ),
            TextFormField(
              key: ValueKey('password'),
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              obscureText: _obscureText,
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Basis Grotesque Pro',
                      fontSize: 11)),
              controller: _passwordController,
              validator: (value) {
                if (value.isEmpty || value.length < 8) {
                  return 'Password must be longer than 8 characters!';
                }
                return null;
              },
              onSaved: (value) {
                _authData['password'] = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            if (widget.isLoading)
              CircularProgressIndicator.adaptive()
            else
              MaterialButton(
                height: 50,
                onPressed: _submit,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                color: Color(0xffFFC175),
                minWidth: double.infinity,
                child: Text('LOG IN'),
              ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => SignUpScreen()));
              },
              child: Text(
                'New User? Create a new account',
                style: TextStyle(color: Colors.white, fontSize: 11),
              ),
            )
          ],
        ),
      ),
    );
  }
}

String LOGIN_MUTATION = """
  mutation Login(\$input:String! \$password:String!){
      login(data:{input:\$input password:\$password}){
          token
          twoFactorAuth
          user{
              _id
              username
          }
      }
  }
""";
