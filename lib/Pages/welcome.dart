import 'package:firebase2/Pages/main_screen.dart';
import 'package:firebase2/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';


class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Color.fromARGB(255, 2, 2, 2).withOpacity(0.6),
                  BlendMode.darken),
              image: AssetImage('assets/images/two.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
              padding: EdgeInsets.only(top: 300),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to Easy Farm',
                    style: GoogleFonts.prompt(
                        fontSize: 38,
                        color: Color.fromARGB(255, 255, 255, 255),
                        decoration: TextDecoration.none),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.h),
                    child: Text(
                      'Your best digital farm marketing app',
                      style: GoogleFonts.prompt(
                        fontSize: 2.5.h,
                        color: Color.fromARGB(255, 216, 216, 216),
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StreamBuilder<User?>(
                              stream: FirebaseAuth.instance.authStateChanges(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.green,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Something went wrong'),
                                  );
                                } else if (snapshot.hasData) {
                                  return MainScreen();
                                } else {
                                  return Auth_Page();
                                }
                              }),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 15, left: 120),
                      height: 60,
                      width: 360,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.green),
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 30,
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Arial',
                        ),
                      ),
                    ),
                  )
                ],
              ))),
    );
  }
}
