import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class AuthProvider  extends ChangeNotifier{
  static AuthProvider authServiceInstance = AuthProvider();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get onAuthStateChanges => _firebaseAuth.authStateChanges();

  User get currentUser => _firebaseAuth.currentUser;


  Future<void> signInAnonymously() async{
    notifyListeners();

    try{
      await _firebaseAuth.signInAnonymously();
    }
    catch (error){
      print(error.toString());
    }
    notifyListeners();
  }

  Future<void> signOutAnonymously() async{
    await _firebaseAuth.signOut();
    notifyListeners();
  }
}