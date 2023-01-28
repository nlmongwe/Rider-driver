import 'package:flutter/material.dart';
import 'package:rider_driver/Pages/login.dart';
import 'package:rider_driver/Pages/register.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);
  static const welcomePageRoute = 'welcome';
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Rider Driver')),
      body: Center(
        child: Column(
          children: <Widget>[
            TextButton(onPressed: _openLogin, child: const Text('login')),
            TextButton(onPressed: _openRegister, child: const Text('Register'))
          ],
        ),
      ),
    );
  }

  void _openRegister() {
    Navigator.of(context).pushNamed(Register.registerPageRoute);
  }

  void _openLogin() {
    Navigator.of(context).pushNamed(Login.loginPageRoute);
  }
}
