import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Utill/FIrebaseHelper.dart';

class AppUser {
  final String _name;
  final String _email;
  final File _profileFile;
  final FirebaseHelper fireBaseHelper = FirebaseHelper();

  AppUser(this._name, this._email, this._profileFile);

  File get profileFile => _profileFile;

  String get email => _email;

  String get name => _name;

  Future<void> register(String password) async {
    await fireBaseHelper.registerWithEmailAndPassword(_email, password);
  }

  Future<void> uploadUserData() async {
    await fireBaseHelper.uploadUserImage(email, profileFile);
    await fireBaseHelper.pushUserData(name, email);
  }
}
