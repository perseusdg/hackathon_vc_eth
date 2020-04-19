import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:settings_ui/settings_ui.dart';

  @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Settings UI Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.deepOrange,
//         brightness: Brightness.light,
//       ),
//       darkTheme: ThemeData(
//         primarySwatch: Colors.deepPurple,
//         accentColor: Colors.deepPurple,
//         brightness: Brightness.dark,
//       ),
//       home: SettingsScreen(),
//     );
// }

class SettingsScreen extends StatefulWidget{
    @override
  _SettingsScreen createState() => _SettingsScreen();
}

bool value = true;

class _SettingsScreen extends State<SettingsScreen> {
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
                switchValue: value,
                onToggle: (bool newValue) {
                  setState(() {
                    value= newValue;
                  });
                },
              ),
            ],
          ),
        ],
    );
  }
}

// class SettingsPage extends StatefulWidget {
//     _loadCounter() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _darkmode = (prefs.getInt('darkmode') ?? 0);
//     });
//   }
//     _SideBarScreen createState() => _SideBarScreen();
// }

// Widget build(BuildContext context) {
//     return Container(
    
//     );
//   }