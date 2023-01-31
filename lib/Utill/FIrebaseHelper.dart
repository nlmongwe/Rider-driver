import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStoreRef = FirebaseStorage.instance.ref();
  final _fireDatabase = FirebaseFirestore.instance;

  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> uploadUserImage(String email, File profileFile) async {
    final profilesRef = _fireStoreRef.child('ProfileImages/$email');
    try {
      await profilesRef.putFile(profileFile);
    } catch (e) {
      print("error in storing image");
      print(e);
    }
  }

  Future<String?> downloadUserImage(String loggedInPersonEmail) async {
    final profilesRef =
        _fireStoreRef.child('ProfileImages/$loggedInPersonEmail');
    try {
      return await profilesRef.getDownloadURL();
    } catch (e) {
      print('error in downloading image');
      print(e);
      return null;
    }
  }

  Future<void> pushUserData(String name, String loggedInPersonEmail) async {
    String? imageUrl = await downloadUserImage(loggedInPersonEmail);
    final userData = {"name": name, "imageUrl": imageUrl};
    try {
      await _fireDatabase
          .collection('Users')
          .doc(loggedInPersonEmail)
          .set(userData);
      _fireDatabase.collection('Users').doc(loggedInPersonEmail).get();

      print('user data set');
    } catch (e) {
      print('error in pushing user data');
      print(e);
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserData(
      String loggedInPersonEmail) async {
    try {
      return await _fireDatabase
          .collection('Users')
          .doc(loggedInPersonEmail)
          .get();
    } catch (e) {
      print("error feting user data");
      print(e);
    }
    return null;
  }
}
