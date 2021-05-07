import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex/screens/confirmation_screen.dart';

import 'components/verification_form.dart';

class VerificationScreen extends StatelessWidget {
  static const routeName = "/verification";

  @override
  Widget build(BuildContext context) {
    final details = ModalRoute.of(context).settings.arguments as Map;
    final _email = details['email'];
    final _token = details['token'];

    final HttpLink httpLink = HttpLink(
      'https://hagglex-backend-staging.herokuapp.com/graphql',
    );
    final AuthLink authLink = AuthLink(getToken: () async => 'Bearer $_token');

    final Link link = authLink.concat(httpLink);

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: Scaffold(
        body: Mutation(
          options: MutationOptions(
              document: gql(verifyUserMutation),
              onCompleted: (resultData) {
                if (resultData != null) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => ConfirmAtionScreen()));
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
                    content:
                        Text("Network Error, please check your connection"),
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
          builder: (RunMutation runMutation, QueryResult result) {
            return Stack(
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
                      child: VerificationForm(
                    runMutation: runMutation,
                    isLoading: result.isLoading,
                    email: _email,
                  )),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

String verifyUserMutation = """
  mutation VerifyUser(\$code:Int!){
  verifyUser(data:{code:\$code}){
    token
    user{
      _id
      username
      email
    }
  }
}
""";
