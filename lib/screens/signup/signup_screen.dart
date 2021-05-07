import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex/screens/verification/verification_screen.dart';
import '../../providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'components/signUp_form.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/signUp';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Mutation(
        options: MutationOptions(
            document: gql(registerMutation),
            onCompleted: (dynamic resultData) {
              if (resultData != null) {
                Provider.of<Auth>(context, listen: false)
                    .login(resultData["register"]);
                Navigator.pushReplacementNamed(
                    context, VerificationScreen.routeName,
                    arguments: {
                      "email": resultData["register"]['user']["email"],
                      'token': resultData['register']['token']
                    });
              }
            },
            onError: (err) {
              if (err.graphqlErrors.length > 0) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
              } else if (err.linkException != null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Kingly recheck your input"),
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
            }),
        builder: (RunMutation runMutation, QueryResult result) => Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/Path 1087.png'),
                    fit: BoxFit.cover),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Image.asset(
                            'assets/icons/back.png',
                            height: 60,
                            width: 50,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SignUpForm(
                        runMutationFunction: runMutation,
                        isLoading: result.isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

String registerMutation = """
  mutation Register(
  \$email: String!
  \$username: String!
  \$password: String!
  \$phonenumber: String!
  \$referralCode: String
  \$country: String!
  \$currency: String!
) {
  register(
    data: {
      email: \$email
      username: \$username
      password: \$password
      phonenumber: \$phonenumber
      country: \$country
      currency: \$currency
      referralCode: \$referralCode
    }
  ) {
    token
    user {
      _id
      email
      username
    }
  }
}
""";
