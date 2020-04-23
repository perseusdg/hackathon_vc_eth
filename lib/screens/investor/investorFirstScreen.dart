import 'package:flutter/material.dart';
import 'package:hackathon/screens/investor/investorHome.dart';
import 'package:hackathon/services/loginWithGoogle.dart';
import 'package:hackathon/screens/secondscreenRegister.dart';
import 'package:hackathon/utilities/constants.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final userReference = Firestore.instance.collection(uid);

class InvestorFirstPage extends StatefulWidget {
  @override
  _InvestorFirstPageState createState() => _InvestorFirstPageState();
}

class _InvestorFirstPageState extends State<InvestorFirstPage> {
  String investorName = " ";
  String InvestorDescription = " ";
  DateTime dateTimeInvestor = null;
  String level;
  String fieldOfFunding;
  String InvestorWants = " ";
  List<String> fundinglevel = [
    'Pre seed',
    'Seed',
    'Level A',
    ' Level B',
    'Level C',
    'Others'
  ];
  List<String> fields = [
    'Artificial Intelligence',
    'Auto Industry',
    'HealthCare',
    'Agriculture',
    'Others'
  ];

  Widget _buildInvestorTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "What is the name of your company?",
          style: TextStyle(
            color: Colors.orange[300],
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 30.0,
          child: TextField(
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.business,
                  color: Colors.black,
                )),
            onChanged: (val) {
              setState(() => investorName = val);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInvestorDateTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "When was your company established?",
          style: TextStyle(
            color: Colors.orange[300],
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 30.0,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.orange[400],
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: dateTimeInvestor == null
                    ? DateTime.now()
                    : dateTimeInvestor,
                firstDate: DateTime(200),
                lastDate: DateTime.now(),
                builder: (BuildContext context, Widget child) {
                  return Theme(
                    data: ThemeData.dark().copyWith(
                      primaryColor: Colors.black,
                      canvasColor: Colors.orange,
                      cardColor: Colors.black,
                      accentColor: Colors.orange,
                      backgroundColor: Colors.orange[400],
                    ),
                    child: child,
                  );
                },
              ).then((date) {
                setState(() {
                  dateTimeInvestor = date;
                });
              });
            },
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.date_range,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  dateTimeInvestor == null
                      ? 'Nothing has been selected yet'
                      : dateTimeInvestor.toString().split(' ')[0],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInvestorFundingLevel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "What levels are you willing to fund",
          style: TextStyle(
            color: Colors.orange[300],
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 17.0,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 30.0,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.list,
                color: Colors.black,
              ),
              SizedBox(width: 20.0),
              Theme(
                data: ThemeData.dark().copyWith(
                    primaryColor: Colors.black,
                    canvasColor: Colors.orange,
                    cardColor: Colors.black,
                    accentColor: Colors.orange,
                    backgroundColor: Colors.orange[400]),
                child: DropdownButton<String>(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  items: fundinglevel.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                  onChanged: (String newValueSelected) {
                    setState(() {
                      this.level = newValueSelected;
                      print(level);
                    });
                  },
                  value: level,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInvestorInfoTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "What fields is your company interested in investing?",
          style: TextStyle(
            color: Colors.orange[300],
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 30.0,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.work,
                color: Colors.black,
              ),
              SizedBox(width: 20.0),
              Theme(
                data: ThemeData.dark().copyWith(
                    primaryColor: Colors.black,
                    canvasColor: Colors.orange,
                    cardColor: Colors.black,
                    accentColor: Colors.orange,
                    backgroundColor: Colors.orange[400]),
                child: DropdownButton<String>(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  items: fields.map((String dropDownString1Item) {
                    return DropdownMenuItem<String>(
                      value: dropDownString1Item,
                      child: Text(dropDownString1Item),
                    );
                  }).toList(),
                  onChanged: (String newValueSelected) {
                    setState(() {
                      this.fieldOfFunding = newValueSelected;
                      print(fieldOfFunding);
                    });
                  },
                  value: fieldOfFunding,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInvestorDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Describe your compnay ",
          style: TextStyle(
            color: Colors.orange[300],
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 100.0,
          child: TextField(
            minLines: 3,
            maxLines: 10,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.description,
                  color: Colors.black,
                )),
            onChanged: (val) async {
              setState(() => InvestorDescription = val);
              print(InvestorDescription);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInvestorWants() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "What do you look for in startups? ",
          style: TextStyle(
            color: Colors.orange[300],
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 100.0,
          child: TextField(
            minLines: 3,
            maxLines: 10,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.description,
                  color: Colors.black,
                )),
            onChanged: (val) async {
              setState(() => InvestorDescription = val);
              print(InvestorDescription);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInvestorLookingFor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "A video describing your startups product",
          style: TextStyle(
            color: Colors.orange[300],
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 40.0,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 15.0,
              ),
              Icon(
                Icons.video_library,
                color: Colors.black,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          await userReference.document("details").setData({
            "name": name,
            "organizationType": "investor",
            "photo": imageUrl,
            "dateEstablished": dateTimeInvestor,
            "description": InvestorDescription,
            "investprName": investorName,
            "currentFundingLevel": level,
            "currentFieldOfinterest": fieldOfFunding,
            "InvestorRequirements": InvestorWants,
          }
          );

          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return InvestorList();
            }),
          );

        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'FINISH',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
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
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
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
                      Text(
                        '    And some more..',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.orange[300],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      _buildInvestorTF(),
                      SizedBox(height: 15.0),
                      _buildInvestorDateTF(),
                      SizedBox(
                        height: 15.0,
                      ),
                      _buildInvestorFundingLevel(),
                      SizedBox(
                        height: 15.0,
                      ),
                      _buildInvestorInfoTF(),
                      SizedBox(
                        height: 15.0,
                      ),
                      _buildInvestorDescription(),
                      SizedBox(
                        height: 15.0,
                      ),
                      _buildInvestorWants(),
                      SizedBox(
                        height: 15.0,
                      ),
                      _buildLoginButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
