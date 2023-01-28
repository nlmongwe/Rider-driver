import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rider_driver/Pages/home.dart';
import 'package:rider_driver/Pages/register.dart';
import 'package:rider_driver/Utill/FIrebaseHelper.dart';
import 'package:rider_driver/Utill/FirebaseExceptions.dart';
import 'package:rider_driver/constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const loginPageRoute = 'login';
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? _emailController;
  String? _passwordController;
  FirebaseHelper firebaseHelper = FirebaseHelper();
  bool progress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Login')),
      body: ModalProgressHUD(
        inAsyncCall: progress,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            KEmailField(onEdit: saveEmail),
            KPasswordField(onEdit: savePassword),
            const TextButton(onPressed: null, child: Text('forgot password?')),
            TextButton(
                onPressed: navigateToRegisterPage,
                child: const Text("don't have and account?"))
          ],
        ),
      ),
      floatingActionButton:
          TextButton(onPressed: makeLogin, child: const Text('Login')),
    );
  }

  void saveEmail(String inputEmail) {
    _emailController = inputEmail;
  }

  void savePassword(String inputPassword) {
    _passwordController = inputPassword;
  }

  void navigateToHomePage() {
    Navigator.of(context).pushNamed(Home.homePageRoute);
  }

  void navigateToRegisterPage() {
    Navigator.of(context).pushNamed(Register.registerPageRoute);
  }

  void navigatorHandler(String errorCode) {
    if (errorCode == "user-not-found" || errorCode == "user-disabled") {
      Navigator.of(context).pushNamed(Register.registerPageRoute);
    }
  }

  void makeLogin() async {
    modalState(true);
    try {
      await firebaseHelper.loginWithEmailAndPassword(
          _emailController!, _passwordController!);
      modalState(false);
      navigateToHomePage();
    } on FirebaseAuthException catch (error) {
      modalState(false);
      FireExceptionHelper fireExceptionHelper = FireExceptionHelper();
      String? status =
          fireExceptionHelper.loginWithEmailAndPasswordException(error.code);
      showMessage(status!);
      navigatorHandler(error.code);
      print(error.code);
    }
  }

  void modalState(bool state) {
    setState(() {
      progress = state;
    });
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.orange,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7), topRight: Radius.circular(7))),
    ));
  }
}