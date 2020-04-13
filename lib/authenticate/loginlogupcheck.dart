import 'package:flutter/material.dart';
import 'package:hackathon/screens/register_screen.dart';
import 'package:hackathon/screens/login_screen.dart';

class LoginLogupCheck extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<LoginLogupCheck> {
  bool showSignIn = true;
  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return LoginScreen(toggleView:toggleView);
    }
    else{
      return RegisterScreen(toggleView:toggleView);
    }
    
  }
}