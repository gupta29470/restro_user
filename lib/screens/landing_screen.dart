import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import 'auth_screen.dart';
import 'home_screen.dart';
import '../widgets/custom_loading_indicator.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return StreamBuilder(
      stream: _authProvider.onAuthStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User _user = snapshot.data;
          if (_user == null) {
            return AuthScreen();
          } else {
            return HomeScreen();
          }
        } else {
          return CustomLoadingIndicator.customLoadingIndicator(100);
        }
      },
    );
  }
}
