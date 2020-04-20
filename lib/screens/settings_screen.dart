import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:hackathon/screens/settings_screen.dart';

bool value=false;
int colorDarkness;

ThemeData darkTheme= ThemeData(
  primarySwatch: Colors.deepPurple,
  accentColor: Colors.deepPurple,
  brightness: Brightness.dark,
);

ThemeData lightTheme=ThemeData(
  primarySwatch: Colors.deepOrange,
  brightness: Brightness.light,
);

class SettingsScreen extends StatefulWidget{
  final Function(ThemeData) onThemeChange;
  @override
  SettingsScreen(this.onThemeChange);
  _SettingsScreen createState() => _SettingsScreen(onThemeChange);
}

ThemeData inUse;

class _SettingsScreen extends State<SettingsScreen> {

  changeValue(bool newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('value', value);
  }

  _SettingsScreen(this.onThemeChange);
  final Function(ThemeData) onThemeChange;
  @override
  Widget build(BuildContext context) {
    return SettingsList(
        sections: [
          SettingsSection(
            title: 'General',
            tiles: [
              SettingsTile(
                title: 'Language',
                subtitle: 'English',
                leading: Icon(Icons.language),
                onTap: () {
                },
              ),
              SettingsTile.switchTile(
                title: 'Dark Mode',
                leading: Icon(Icons.brightness_3),
                switchValue: value,
                onToggle: (bool newValue) {
                  setState(() {
                    value= newValue;
                    if(value){
                      inUse=darkTheme;
                      colorDarkness=900;
                    } else{
                      inUse=lightTheme;
                      colorDarkness=100;
                    }
                    onThemeChange(inUse);
                    changeValue(newValue);
                  });
                },
              ),
            ],
          ),
          SettingsSection(
            title: 'Account',
            tiles: [
              SettingsTile(
                title: 'Signout',
                subtitle: 'Signout of the account.',
                leading: Icon(Icons.exit_to_app),
                onTap: () {
                },
              ),
              SettingsTile.switchTile(
                title: 'Notifications',
                leading: Icon(Icons.notifications),
                switchValue: true,
                onToggle: (bool newValue) {
                },
              ),
            ],
          ),
        ],
    );
  }
}