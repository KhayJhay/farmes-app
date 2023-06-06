import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase2/Pages/profile.dart';
import 'package:firebase2/Pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase2/main.dart';
import 'farmer_home';
import 'forgotPass_page.dart';
import 'home.dart';

class login_screen extends StatefulWidget {
  final VoidCallback SignUp;
  const login_screen({Key? key, required this.SignUp}) : super(key: key);
  

  @override
  State<login_screen> createState() => _login_screenState();
  
}


enum Role {
  buyer,
  farmer,
}


class _login_screenState extends State<login_screen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final contactController=TextEditingController();
  var prefixIcon;

  Role? _choice;
  String? myEmail;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    contactController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? choice1;
    
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
                'Login',
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
                textInputAction: TextInputAction.done,
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
           

SizedBox(height: 20,),

Row(
  mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Radio(
              activeColor: Colors.green,
              value: Role.buyer,
              groupValue: _choice,
              onChanged: (value) {
                setState(() {
                   _choice = value as Role?;
                });
              },
            ),
            Text('Buyer'),
            
            SizedBox(width: 80,),

            Radio(
              activeColor: Colors.green,
              value: Role.farmer,
              groupValue: _choice,
              onChanged: (value) {
                setState(() {
                  _choice= value as Role?;
                });
              },
            ),
            Text('Farmer'),
          ],
        ),

            SizedBox(height: 20,),

            GestureDetector(
              onTap: () {
                if(_choice==Role.buyer){
                signIn2();
                } else if(_choice==Role.farmer){
                signIn();
                }
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
                  'Login',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 17, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ForgotPasswordPage();
                    }));
                    },
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(fontSize: 18, fontFamily: 'Arial'),
                    ),
                  ),
                 GestureDetector(
  onTap: () {
   showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text('Sign Up'),
      content: Text('Do you want to sign up as a buyer or a farmer?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'buyer');
          },
          child: Text('Buyer'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'farmer');
          },
          child: Text('Farmer'),
        ),
      ],
    );
  },
).then((value) {
  if (value != null) {
    // handle user choice here
    if (value == 'buyer') {
      widget.SignUp();
    } else if (value == 'farmer') {
        Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(
                                  HomePage: () => HomePage(),
                                )));
    }
  }
});

  },
  child: Text(
    'Sign up',
    style: TextStyle(fontSize: 18, fontFamily: 'Arial'),
  ),
),

                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  Future signIn() async {
    showDialog(
      context:context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );
    } on FirebaseException catch (e) {
      // TODO
      print(e);
      showDialog(context: context, builder: (context){
         return AlertDialog(
           content: Text(e.message.toString()),
         );
      });
    }

    navigationKey.currentState!.popUntil((route) => route.isFirst);
  }



Future signIn2()  async{
  showDialog(
      context:context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      ),
    );


QuerySnapshot querySnapshot = await FirebaseFirestore.instance
    .collection('users')
    .get();

List<DocumentSnapshot> users = querySnapshot.docs;

bool foundUser = false;

for (int i = 0; i < users.length; i++) {
  Map<String, dynamic>? data = users[i].data() as Map<String, dynamic>?;
  if (data?["Email"] == emailController.text &&
      data?['Contact'] == passController.text.toString()) {
    foundUser = true;
    break;
  }
}

if (foundUser) {
  // Navigate to farmpage
   Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FarmPage()),
        );
      
} else {
  // Show an error message or dialog
  
  
}


 
}

}




