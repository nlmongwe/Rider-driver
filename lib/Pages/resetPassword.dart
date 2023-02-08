import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rider_driver/AppAuth/userAuth.dart';
import 'package:rider_driver/Pages/login.dart';
import 'package:rider_driver/Utill/constants.dart';

import '../Utill/FirebaseExceptions.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);
  static const resetPasswordPageRoute = 'resetPassword';
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool displayExtraFields = false;
  String? _emailController;
  bool progress = false;

  final UserAuthentication _userAuthentication = UserAuthentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Re-Set Password'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: progress,
        child: Center(
          child: KEmailField(onEdit: _saveEmail),
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: _submitEmail,
        child: const Text('reset'),
      ),
    );
  }

  void _saveEmail(String email) {
    _emailController = email;
  }

  void _submitEmail() async {
    _modalHandler(true);
    if (EmailValidator.validate(_emailController!)) {
      try {
        await _userAuthentication.restPassword(_emailController);
        showMessage('reset link sent to email address');
        _modalHandler(false);
        _navToLoginPage();
      } on FirebaseAuthException catch (error) {
        FireExceptionHelper fireExceptionHelper = FireExceptionHelper();
        String? status = fireExceptionHelper.resetPasswordException(error.code);
        _modalHandler(false);
        showMessage(status!);
      }
    } else {
      _modalHandler(false);
      showMessage('provide valid email address');
    }
  }

  void _navToLoginPage() {
    Navigator.of(context).pushNamed(Login.loginPageRoute);
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
      ),
      backgroundColor: Colors.orange,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7), topRight: Radius.circular(7))),
    ));
  }

  void _modalHandler(bool state) {
    setState(() {
      progress = state;
    });
  }
}
