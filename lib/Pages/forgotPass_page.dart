import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  var prefixIcon;

  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content:
                  Text("Password reset link has been sent! Check your email"),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      // TODO
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Enter your Email and we will send you a password reseting link',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 0,
            ),
            height: 50,
            width: 350,
            child: TextField(
              controller: _emailController,
              cursorColor: Colors.green,
              textInputAction: TextInputAction.done,
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
            height: 10,
          ),
          MaterialButton(
            onPressed: () {
              passwordReset();
            },
            child: Text(
              "Reset Password",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.green,
          ),
          
        ],
      ),
    );
  }
}
