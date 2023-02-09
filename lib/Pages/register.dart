import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rider_driver/Pages/home.dart';
import 'package:rider_driver/Pages/login.dart';
import 'package:rider_driver/Utill/FirebaseExceptions.dart';
import 'package:rider_driver/Utill/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:email_validator/email_validator.dart';

import '../Model/appUser.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  static const registerPageRoute = 'register';
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late AppUser _appUser;
  final ImagePicker imagePicker = ImagePicker();
  bool progress = false;

  String? _nameController;
  String? _emailController;
  String? _passwordController;
  File? _profileFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Register'),
      ),
      body: ModalProgressHUD(
        blur: 1,
        color: Colors.orange,
        inAsyncCall: progress,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            KNameField(onEdit: saveName),
            KEmailField(onEdit: saveEmail),
            KPasswordField(onEdit: savePassword),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                "Provider User picture",
                style: TextStyle(color: Colors.orange),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              KUploadButton(
                  onTap: saveUserImageFromGallery,
                  horizontalPadding: 10,
                  verticalPadding: 0),
              KCaptureButton(
                  onTap: saveUserImageFromCamera,
                  horizontalPadding: 10,
                  verticalPadding: 0)
            ]),
            Flexible(
                child: KImageContainer(
                    width: 120, height: 150, profileFile: _profileFile)),
          ],
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: makeRegister,
        child: const Text("register"),
      ),
    );
  }

  void saveName(String userName) {
    _nameController = userName;
  }

  void saveEmail(String userEmail) {
    _emailController = userEmail;
  }

  void savePassword(String userPassword) {
    _passwordController = userPassword;
  }

  void modalHandler(bool state) {
    setState(() {
      progress = state;
    });
  }

  void makeRegister() async {
    //handling the registration here allows for detecting register exceptions
    // as buttons are clicked
    if (readyToRegister()) {
      _appUser = AppUser(_nameController!, _emailController!, _profileFile!);
      modalHandler(true);
      try {
        await _appUser.register(_passwordController!);
        await _appUser.uploadUserData();
        // **TO DO**
        // handle collection.put and collection.get errors from database.saveUser
        modalHandler(false);
        navigateToHomeScreen();
      } on FirebaseAuthException catch (error) {
        // To Do here
        modalHandler(false);
        FireExceptionHelper fireExceptionHelper = FireExceptionHelper();
        String? status = fireExceptionHelper
            .createUserWithEmailAndPasswordException(error.code);
        showMessage(status!);
        navigatorHandler(error.code);
      }
    }
  }

  void navigateToHomeScreen() {
    Navigator.of(context).pushNamed(Home.homePageRoute);
  }

  void navigatorHandler(String code) {
    if (code == "email-already-in-use") {
      Navigator.of(context).pushNamed(Login.loginPageRoute);
    }
  }

  Future<void> saveUserImageFromGallery() async {
    try {
      final XFile? uploadedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (uploadedImage != null) {
        setState(() {
          _profileFile = File(uploadedImage.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to save image'))); // print(e);
    }
  }

  Future<void> saveUserImageFromCamera() async {
    try {
      final XFile? uploadedImage =
          await imagePicker.pickImage(source: ImageSource.camera);
      if (uploadedImage != null) {
        setState(() {
          _profileFile = File(uploadedImage.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to save image'))); // print(e);
    }
  }

  bool readyToRegister() {
    if (_nameController == null || _nameController!.length < 3) {
      showMessage('provide name of at least three characters');
      return false;
    } else if (!EmailValidator.validate(_emailController!)) {
      showMessage('provide valid email address');
      return false;
    } else if (_passwordController == null || _passwordController!.length < 8) {
      showMessage('provide password of at least 8 characters');
      return false;
    } else if (_profileFile == null) {
      showMessage('provide profile image');
      return false;
    }
    return true;
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7), topRight: Radius.circular(7))),
    ));
  }
}
