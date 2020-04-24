import 'package:flutter/material.dart';
import 'package:hackathon/authenticate/wrapper.dart';
import 'package:hackathon/main _afterSignIn.dart';
import 'package:hackathon/services/loginWithGoogle.dart';

void main() {
  if(isSignedIn) return runApp(MyApp());
  else return runApp(MySideBarApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
    );
  }
}
