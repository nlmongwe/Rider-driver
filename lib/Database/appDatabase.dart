import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Database {
  final _fireStoreRef = FirebaseStorage.instance.ref();
  final _fireDatabase = FirebaseFirestore.instance;

  Future<void> saveUserImage(String email, File profileFile) async {
    //TODO handle error on the methods that call this function
    final profilesRef = _fireStoreRef.child('ProfileImages/$email');
    await profilesRef.putFile(profileFile);
  }

  Future<String?> downloadUserImage(String loggedInPersonEmail) async {
    //TODO handle error on the methods that call this function
    final profilesRef =
        _fireStoreRef.child('ProfileImages/$loggedInPersonEmail');
    return await profilesRef.getDownloadURL();
  }

  Future<void> saveUserData(String name, String loggedInPersonEmail) async {
    //TODO handle error on the methods that call this function
    String? imageUrl = await downloadUserImage(loggedInPersonEmail);
    final userData = {"name": name, "imageUrl": imageUrl};
    await _fireDatabase
        .collection('Users')
        .doc(loggedInPersonEmail)
        .set(userData);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserData(
      String loggedInPersonEmail) async {
    return await _fireDatabase
        .collection('Users')
        .doc(loggedInPersonEmail)
        .get();
  }

  Future<String?> getCurrentUserByName(String loggedInPersonEmail) async {
    DocumentSnapshot<Map<String, dynamic>> userData =
        await _fireDatabase.collection('Users').doc(loggedInPersonEmail).get();
    return userData.get('name');
  }

  Future<void> saveRiderData(String loggedInPersonEmail) async {
    String? imageUrl = await downloadUserImage(loggedInPersonEmail);
    String? userByName = await getCurrentUserByName(loggedInPersonEmail);
    final Map<String, dynamic> rideData = {
      'image': imageUrl,
      'name': userByName,
      'from': 'Pretoria ,sammyMarksSquare',
      'to': 'Tzaneen CBD',
      'pickUpTime': '10:00 am',
      'pay': 'R200',
      'date': '10 Feb 2023'
    };
    await _fireDatabase.collection('Rides').doc().set(rideData);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getRidesData() {
    return _fireDatabase.collection('Rides').snapshots();
  }
}
