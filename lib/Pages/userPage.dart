import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Utill/FIrebaseHelper.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final FirebaseHelper firebaseHelper = FirebaseHelper();
  final _firebaseAuth = FirebaseAuth.instance;
  late User loggedInPerson;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
              future:
                  firebaseHelper.getUserData(loggedInPerson.email.toString()),
              builder: (context, userData) {
                if (userData.hasData) {
                  return Column(children: [
                    Text(userData.data!['name']),
                    CircleAvatar(
                      backgroundImage: NetworkImage(userData.data!['imageUrl']),
                    ),
                  ]);
                }
                return const CircularProgressIndicator(
                  color: Colors.orange,
                );
              }),
        ],
      ),
    );
  }

  void getCurrentUser() {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      loggedInPerson = user;
      print("logged in person: ${user.email}");
    }
  }
}
