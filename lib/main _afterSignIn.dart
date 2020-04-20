import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:hackathon/authenticate/wrapper.dart';
import 'package:hackathon/SidebarStuff/sidebar.dart';
import 'package:hackathon/screens/settings_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
    @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
    void initState() {
    super.initState();
    getValue();
  }

  getValue() async{   
    SharedPreferences prefs = await SharedPreferences.getInstance();
    value = (prefs.getBool('value') ?? false);
    setState(() {
      if(value){
      inUse=darkTheme;
      colorDarkness=900;
      } else{
      inUse=lightTheme;
      colorDarkness=100;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      debugShowCheckedModeBanner: false,
      theme: inUse,
      home: SideBarScreen((ThemeData newTheme) {setState(() {inUse=newTheme;});}),
    );
  }
}