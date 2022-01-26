import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_login/twitter_login.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Twitter Login App'),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text('Login With Twitter'),
            onPressed: () async {
              final twitterLogin = TwitterLogin(
                apiKey: "yRAFVeYikBzHEmvQNGP8IkROJ",
                apiSecretKey: "DQ5p70F2uvuBC7yqMFC7TbbRswId2v1OlTWC0H8lzxyociorwA",
                redirectURI: 'https://twittertest2-24864.firebaseapp.com/__/auth/handler',
              );
              // final authResult = twitterLogin.login();
              final authResult = await twitterLogin.login();
              final AuthCredential = TwitterAuthProvider.credential(
                  accessToken: authResult.authToken!,
                  secret: authResult.authTokenSecret!);
              await FirebaseAuth.instance.signInWithCredential(AuthCredential);
              switch (authResult.status) {
                case TwitterLoginStatus.loggedIn:
                // success
                  break;
                case TwitterLoginStatus.cancelledByUser:
                // cancel
                  break;
                case TwitterLoginStatus.error:
                // error
                  break;
              }
            },
          ),
        ),
      ),
    );
  }
}