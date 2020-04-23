import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathon/screens/secondscreenRegister.dart';
import 'package:hackathon/services/loginWithGoogle.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  dynamic checkAvailability() {
    if (imageUrl != null) {
      return (NetworkImage(imageUrl));
    } else {
      return (NetworkImage(
          "https://www.google.com/url?sa=i&url=https%3A%2F%2Ffavpng.com%2Fpng_view%2Fawesome-font-awesome-user-font-png%2FijN4xsWy&psig=AOvVaw17x8HqxaxB6yZU16f2LIyC&ust=1587737135047000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCMCizvLb_ugCFQAAAAAdAAAAABAD"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black,
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'WELCOME TO ANON_BLOC',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                          fontSize: 45.0,
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      CircleAvatar(
                        backgroundImage: checkAvailability(),
                        radius: 60.0,
                        backgroundColor: Colors.orange,
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        '${name} We would like to know a bit more about you ,in order to serve you better',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return SecondRegisterScreen();
                              }),
                            );
                          },
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.orange,
                          child: Text(
                            'CONTINUE',
                            style: TextStyle(
                              color: Color(0xFF527DAA),
                              letterSpacing: 1.5,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
