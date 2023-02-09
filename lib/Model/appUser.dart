import 'dart:io';
import 'package:rider_driver/AppAuth/userAuth.dart';
import 'package:rider_driver/Database/appDatabase.dart';

class AppUser {
  final String _name;
  final String _email;
  final File _profileFile;
  final UserAuthentication _userAuthentication = UserAuthentication();
  final Database _database = Database();

  AppUser(this._name, this._email, this._profileFile);

  File get profileFile => _profileFile;

  String get email => _email;

  String get name => _name;

  Future<void> register(String password) async {
    await _userAuthentication.registerWithEmailAndPassword(email, password);
  }

  Future<void> validateEmailAddress() async {}

  Future<void> uploadUserData() async {
    await _database.saveUserImage(email, profileFile);
    await _database.saveUserData(name, email);
  }
}
