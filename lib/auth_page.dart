import 'package:firebase2/Pages/login_screen.dart';
import 'package:firebase2/Pages/sign_up.dart';
import 'package:flutter/material.dart';

class Auth_Page extends StatefulWidget {
  const Auth_Page({Key? key}) : super(key: key);

  @override
  State<Auth_Page> createState() => _Auth_PageState();
}


class _Auth_PageState extends State<Auth_Page> {

  bool showLogin=true;

void toogleScreens(){
  setState(() {
    showLogin=!showLogin;
  });
  
}
  @override
  Widget build(BuildContext context) {
    if(showLogin){
      return login_screen(SignUp: toogleScreens);
    }else{
      return SignUp(login_screen: toogleScreens);
    }
  }
}