import 'package:firebase2/Pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final VoidCallback login_screen;
  const SignUp({Key? key, required this.login_screen}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final comfirmPassController = TextEditingController();
  var prefixIcon;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    comfirmPassController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(top: 50, bottom: 30, left: 50, right: 50),
              height: 300,
              width: 500,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/three.png'),
                      fit: BoxFit.fitWidth)),
            ),
            Container(
              child: Text(
                'Register',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.only(
                left: 0,
              ),
              height: 50,
              width: 350,
              child: TextField(
                controller: emailController,
                cursorColor: Colors.green,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    prefixIcon: prefixIcon ??
                        Icon(
                          Icons.perm_identity,
                          color: Colors.green,
                        ),
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 0),
              height: 50,
              width: 350,
              child: TextField(
                controller: passController,
                cursorColor: Colors.green,
                textInputAction: TextInputAction.next,
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: prefixIcon ??
                        Icon(
                          Icons.lock,
                          color: Colors.green,
                        ),
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 20, color: Colors.green)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 0),
              height: 50,
              width: 350,
              child: TextField(
                controller: comfirmPassController,
                cursorColor: Colors.green,
                textInputAction: TextInputAction.done,
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: prefixIcon ??
                        Icon(
                          Icons.lock,
                          color: Colors.green,
                        ),
                    hintText: 'Confirm Password',
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(fontSize: 20, color: Colors.green)),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                SignUp();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.green,
                ),
                padding: EdgeInsets.only(left: 150, top: 11),
                height: 50,
                width: 350,
                child: Text(
                  'SignUp',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.only(left: 17, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Already have an account?',
                      style: TextStyle(fontSize: 18, fontFamily: 'Arial'),
                    ),
                  ),
                  GestureDetector(
                      onTap: widget.login_screen,
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 18, fontFamily: 'Arial'),
                      )),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  Future SignUp() async {
    try {
      if (passwordConfirmed()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passController.text.trim());
      }
    } on FirebaseAuthException catch (e) {
      // TODO
       
    }
  }

  bool passwordConfirmed() {
    if (passController.text.trim() == comfirmPassController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }
}
