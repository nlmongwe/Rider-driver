import 'package:flutter/material.dart';
import 'package:rider_driver/AppAuth/userAuth.dart';
import 'package:rider_driver/Database/appDatabase.dart';
import 'package:rider_driver/Pages/drivers.dart';
import 'package:rider_driver/Pages/login.dart';
import 'package:rider_driver/Pages/riders.dart';
import 'package:rider_driver/Pages/userPage.dart';
import 'package:rider_driver/Utill/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const homePageRoute = 'home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _pageIndex = 1;
  final _pageController = PageController(initialPage: 1);
  // final UserAuthentication _userAuthentication = UserAuthentication();
  // late String? loggedInPersonEmail;

  // @override
  // void initState() {
  //   super.initState();
  //   // _getUserData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Rider Driver"),
        actions: [
          TextButton(
              onPressed: _signOut,
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.black87),
              ))
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _selectPage,
        children: const [
          Riders(),
          UserPage(),
          Drivers(),
        ],
      ),
      persistentFooterButtons: [
        // TextButton(onPressed: _signOut, child: const Text('Logout'))
        GestureDetector(onTap: _signOut, child: const Text('Logout')),
        const SizedBox(width: 3)
      ],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_walk), label: 'Riders'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.car_crash), label: 'Drivers')
        ],
      ),
    );
  }

  void _selectPage(int pageIndex) {
    _pageController.jumpToPage(pageIndex);
    setState(() {
      _pageIndex = pageIndex;
    });
  }

  void _navigateToLoginPage() {
    Navigator.of(context).pushNamed(Login.loginPageRoute);
  }

  Future<void> _signOut() async {
    await UserAuthentication.signOut();
    _navigateToLoginPage();
  }

  // void _getUserData() async {
  //   loggedInPersonEmail = _userAuthentication.getCurrentUser();
  // }
}
