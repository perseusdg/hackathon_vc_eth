import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathon/services/loginWithGoogle.dart';
import 'package:hackathon/screens/secondscreenRegister.dart';
import 'package:hackathon/utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon/services/loginWithGoogle.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

final useReference = Firestore.instance.collection(uid);

class StartupFirstPage extends StatefulWidget {
  @override
  _StartupFirstPageState createState() => _StartupFirstPageState();
}

class _StartupFirstPageState extends State<StartupFirstPage> {
  String _uploadedFileUrl;
  String startupName = " ";
  String stateText = " ";
  String startupDescription = " ";
  DateTime dateTime = null;
  String level;
  String fieldOfWork;
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

  File _video;
  _pickvideo() async {
    File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    setState(() {
      _video = video;
      this.stateText = Path.basename(_video.path);
    });
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('${uid}/${Path.basename(_video.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_video);
    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((fileUrl) {
      setState(() {
        _uploadedFileUrl = fileUrl;
      });
    });
  }

  Widget _buildStartupTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "What is your Startup's name?",
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
              setState(() => startupName = val);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStartupDateTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "When was your Startup established?",
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
                initialDate: dateTime == null ? DateTime.now() : dateTime,
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
                  dateTime = date;
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
                  dateTime == null
                      ? 'Nothing has been selected yet'
                      : dateTime.toString().split(' ')[0],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStartupFundingLevel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "What is your current level of funding?",
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

  Widget _buildStartupInfoTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Your Startup's Field?",
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
                      this.fieldOfWork = newValueSelected;
                      print(fieldOfWork);
                    });
                  },
                  value: fieldOfWork,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStartupDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Describe Your Startup in a 100 words",
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
              setState(() => startupDescription = val);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStartupUploadMedia() {
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
        GestureDetector(
          onTap: () {
            _pickvideo();
          },
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 5.0,
                ),
                Icon(
                  Icons.video_library,
                  color: Colors.black,
                ),
                Text(
                  stateText,
                  overflow: TextOverflow.clip,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.white54,
                      fontFamily: 'OpenSans',
                      fontSize: 14.0),
                ),
              ],
            ),
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
        onPressed: () {
          uploadFile();
          useReference.document("details").setData({
            "name": name,
            "organizationType": "startup",
            "photo": imageUrl,
            "dateEstablished": dateTime,
            "description": startupDescription,
            "startupName": startupName,
            "currentFundingLevel": level,
            "currentFieldOfWork": fieldOfWork,
            "FirstVideo": _uploadedFileUrl,
          });
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
                      _buildStartupTF(),
                      SizedBox(height: 15.0),
                      _buildStartupDateTF(),
                      SizedBox(
                        height: 15.0,
                      ),
                      _buildStartupFundingLevel(),
                      SizedBox(
                        height: 15.0,
                      ),
                      _buildStartupInfoTF(),
                      SizedBox(
                        height: 15.0,
                      ),
                      _buildStartupDescription(),
                      SizedBox(
                        height: 15.0,
                      ),
                      _buildStartupUploadMedia(),
                      SizedBox(
                        height: 25.0,
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
