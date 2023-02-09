import 'package:firebase_auth/firebase_auth.dart';

class UserAuthentication {
  static final _firebaseAuth = FirebaseAuth.instance;

  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> restPassword(email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> submitNewPassword(String code, String newPassword) async {
    await _firebaseAuth.confirmPasswordReset(
        code: code, newPassword: newPassword);
  }

  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  static User? getCurrentUser() {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      return user;
    }
    return null;
  }
}
