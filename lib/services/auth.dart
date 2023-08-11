import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_demo/screens/sign_up.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> SignUp(String email, String password) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return authResult;
  }

  Future<UserCredential> SignIn(String email, String password) async {
    final authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return authResult;
  }

  // User? get currentUser => _auth.currentUser;
  // Stream<User?> get authStateChanges => _auth.authStateChanges();
  //
  // Future<void> signInWithEmailAndPassword({
  //   required String email,
  //   required String password,
  // }) async {
  //   await _auth.signInWithEmailAndPassword(email: email, password: password);
  // }
  //
  // Future<void> createUserWithEmailAndPassword({
  //   required String email,
  //   required String password,
  // }) async {
  //   await _auth.createUserWithEmailAndPassword(
  //       email: email, password: password);
  // }
  //
  // Future<void> signOut() async {
  //   await _auth.signOut();
  // }
}
