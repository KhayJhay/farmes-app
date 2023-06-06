import 'package:firebase2/Pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:sizer/sizer.dart';
import 'dart:typed_data';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

final navigationKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: ((context, orientation, deviceType) {
      return MaterialApp(
        navigatorKey: navigationKey,
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          splash: 'assets/images/one.png',
          nextScreen: Welcome(),
          splashTransition: SplashTransition.rotationTransition,
          duration: 3000,
          backgroundColor: Colors.white,
        ),
      );
    }));
  }
}
