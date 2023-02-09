import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rider_driver/AppAuth/userAuth.dart';
import 'package:rider_driver/Database/appDatabase.dart';
import 'package:rider_driver/Pages/login.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final Database _database = Database();
  // final _firebaseAuth = FirebaseAuth.instance;
  User? loggedInPerson;
  // late String userByName;
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
          loggedInPerson != null
              ? FutureBuilder(
                  future:
                      _database.getUserData(loggedInPerson!.email.toString()),
                  builder: (context, userData) {
                    if (userData.hasData) {
                      return Column(children: [
                        Text(userData.data!['name']),
                        // Text(userData.data),
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(userData.data!['imageUrl']),
                        ),
                      ]);
                    }
                    return const CircularProgressIndicator(
                      color: Colors.orange,
                    );
                  })
              : Column(
                  children: [
                    const Text("your not logged in"),
                    TextButton(
                        onPressed: _navToLoginPage, child: const Text('Login'))
                  ],
                ),
        ],
      ),
    );
  }

  void getCurrentUser() {
    //   User? user = _firebaseAuth.currentUser;
    //   if (user != null) {
    //     loggedInPerson = user;
    //     print("logged in person: ${user.email}");
    //   }
    loggedInPerson = UserAuthentication.getCurrentUser();
  }

  void _navToLoginPage() {
    Navigator.of(context).pushNamed(Login.loginPageRoute);
  }
}
