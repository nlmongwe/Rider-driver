import 'package:flutter/material.dart';
import 'package:rider_driver/Pages/drivers.dart';
import 'package:rider_driver/Pages/riders.dart';
import 'package:rider_driver/Pages/userPage.dart';
import 'package:rider_driver/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const homePageRoute = 'home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _pageController = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Rider Driver"),
      ),
      body: PageView(controller: _pageController, children: const [
        Riders(),
        UserPage(),
        Drivers(),
      ]),
      persistentFooterAlignment: AlignmentDirectional.topCenter,
      persistentFooterButtons: <Widget>[
        KFooterNavButtons(
            title: "RIDERS",
            onTap: () {
              _selectPage(0);
            }),
        const SizedBox(
          width: 25,
        ),
        KFooterNavButtons(
            title: "HOME",
            onTap: () {
              _selectPage(1);
            }),
        const SizedBox(
          width: 25,
        ),
        KFooterNavButtons(
            title: "DRIVERS",
            onTap: () {
              _selectPage(2);
            })
      ],
    );
  }

  void _selectPage(int pageIndex) {
    _pageController.jumpToPage(pageIndex);
  }
}
