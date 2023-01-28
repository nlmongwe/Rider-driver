import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rider_driver/Utill/FIrebaseHelper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const homePageRoute = 'home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Rider Driver"),
      ),
      body: Center(
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
                        backgroundImage:
                            NetworkImage(userData.data!['imageUrl']),
                      ),
                    ]);
                  }
                  return const CircularProgressIndicator(
                    color: Colors.orange,
                  );
                }),
          ],
        ),
      ),
      // floatingActionButton: IconButton(
      //     onPressed: () async {
      //       print('getting data');
      //       var data = await firebaseHelper
      //           .getUserData(loggedInPerson.email.toString());
      //       print(data!.data());
      //     },
      //     icon: const Icon(Icons.add)),
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
