import 'package:flutter/material.dart';
import 'package:rider_driver/Pages/home.dart';
import 'package:rider_driver/Pages/login.dart';
import 'package:rider_driver/Pages/resetPassword.dart';
import 'Pages/register.dart';
import 'Pages/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const RiderDriver());
}

class RiderDriver extends StatelessWidget {
  const RiderDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rider Driver',
      theme: ThemeData(primarySwatch: Colors.orange),
      initialRoute: Welcome.welcomePageRoute,
      debugShowCheckedModeBanner: false,
      routes: {
        Welcome.welcomePageRoute: (context) => const Welcome(),
        Register.registerPageRoute: (context) => const Register(),
        Home.homePageRoute: (context) => const Home(),
        Login.loginPageRoute: (context) => const Login(),
        ResetPassword.resetPasswordPageRoute: (context) => const ResetPassword()
      },
    );
  }
}
