import 'package:flutter/material.dart';
import 'package:hackathon/services/loginWithGoogle.dart';
import 'package:hackathon/screens/login_screen.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
                radius: 60.0,
                backgroundColor: Colors.transparent,
              )
            ],
          ),
        ),
      ),
    );
  }
}