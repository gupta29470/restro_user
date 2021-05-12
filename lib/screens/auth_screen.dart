import 'package:flutter/material.dart';

import '../providers/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Image.asset(
                "assets/images/intro.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 150,
          ),
          _signInButtonWidget(),
        ],
      ),
    );
  }

  Widget _signInButtonWidget() {
    return Container(
          decoration: BoxDecoration(
            color: Colors.deepOrangeAccent,
            borderRadius: BorderRadius.circular(70)
          ),
          child: IconButton(
            splashColor: Colors.deepOrangeAccent,
            iconSize: 70,
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            onPressed: () => AuthProvider.authServiceInstance.signInAnonymously(),
          ),
        );
  }
}
