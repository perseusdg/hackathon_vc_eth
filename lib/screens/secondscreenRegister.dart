import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathon/screens/investor/investorFirstScreen.dart';
import 'package:hackathon/screens/startup/startupFirstScreen.dart';
import 'package:hackathon/services/loginWithGoogle.dart';
import 'package:hackathon/utilities/constants.dart';


class SecondRegisterScreen extends StatefulWidget {
  @override
  _SecondRegisterScreenState createState() => _SecondRegisterScreenState();
}

class _SecondRegisterScreenState extends State<SecondRegisterScreen> {
  bool investor = false;
  bool startup = false;
  bool pressAttention;

  Color setcolor(bool investor,bool startup){
    if(startup){
      return Colors.orange;
    }
    else{
      return Colors.white;
    }
  }

  Widget checkInvestorOrStartup(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Are you a Startup or an Investor?',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 20.0,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 40.0,),
              RaisedButton(
                elevation: 5.0,
                onPressed: () async{
                  setState(() {
                    investor = false;
                    startup = true;
                  });
                },
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: startup ? Colors.orange : Colors.white,
                child: Text(
                  'Startup',
                  style: TextStyle(
                    color: Color(0xFF527DAA),
                    letterSpacing: 1.5,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
              SizedBox(width: 20.0,),
              RaisedButton(
                elevation: 5.0,
                onPressed: () async{
                  setState(() {
                    investor = true;
                    startup = false;
                  });
                },
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: investor ? Colors.orange : Colors.white,
                child: Text(
                  'Investor',
                  style: TextStyle(
                    color: Color(0xFF527DAA),
                    letterSpacing: 1.5,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget continueNextPage(){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          alignment: Alignment.bottomRight,
          child: Row(
            children: <Widget>[
              SizedBox(width: 180,),
              RaisedButton(
                elevation: 5.0,
                onPressed: () async{
                  if(investor){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) {
                            return InvestorFirstPage();
                          }
                      ),
                    );
                  }
                  else{
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) {
                            return StartupFirstPage();
                          }
                      ),
                    );
                  }
                },
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                color: Colors.orange,
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Color(0xFF527DAA),
                    letterSpacing: 1.5,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),

              )
            ],
          ),
        ),
      ],

    );

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
                    vertical: 40.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 170.0,),
                      Text(
                        "Let's get on with it",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.orange[300],
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            fontSize:35.0
                          ),
                      ),
                      SizedBox(height: 40.0),
                      checkInvestorOrStartup(),
                      SizedBox(height: 40.0,),
                      continueNextPage(),
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
