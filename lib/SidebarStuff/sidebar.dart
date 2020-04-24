import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/SidebarStuff/YourDefaultPage.dart';
import 'package:hackathon/SidebarStuff/mobile_sidebar.dart';
import 'package:hackathon/SidebarStuff/share_us.dart';
import 'package:hackathon/screens/investor/investorHome.dart';
import 'package:hackathon/screens/settings_screen.dart';
import 'package:hackathon/screens/startup/startupHome.dart';
import 'package:hackathon/services/loginWithGoogle.dart';

TabChild sideBarListObjGeneric(
    Icon customicon, String text, Color colortobepassed) {
  return TabChild(
    icon: customicon,
    title: text,
    builder: (context) => YourDefaultPage(
      customicon: customicon,
      text: text,
      bgcolour: colortobepassed,
    ),
  );
}

TabChild sideBarListObjSpecific(
    Icon customicon, String text, Color colortobepassed, Widget nextScreen) {
  return TabChild(
    icon: customicon,
    title: text,
    builder: (context) => nextScreen,
  );
}

List<String> titles = [
  'My Home',
  'My feed',
  'My Favs',
  'My likes',
  'My Profile',
  'Settings',
  'Share the App',
  'Report a Bug',
  'Contact Us'
];

// <Frontend>
class SideBarScreen extends StatefulWidget {
  final Function(ThemeData) onThemeChange;
  @override
  SideBarScreen(this.onThemeChange);
  _SideBarScreen createState() => _SideBarScreen(onThemeChange);
}

class _SideBarScreen extends State<SideBarScreen> {
  String industry;
  Future<bool> getfirebasedata() async {
    var document = await Firestore.instance
        .collection(uid)
        .document('details')
        .get()
        .then((DocumentSnapshot) =>
            {industry = DocumentSnapshot.data['organizationType'].toString()});
    return null;
  }

  _SideBarScreen(this.onThemeChange);
  final Function(ThemeData) onThemeChange;
  int index = 0;
  double iconsize = 40.0;
  bool searching = false;
  String sideBarTitle;

  Widget setSpecificHome() {
    getfirebasedata();
    if (industry == 'startup') {
      return StartupList();
    } else {
      return InvestorList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: MobileSidebar(
        theme: ThemeData.dark(),
        currentIndex: index,
        onTabChanged: (val) {
          if (mounted)
            setState(() {
              index = val;
              sideBarTitle = titles[val];
            });
        },
        isSearching: searching,
        isSearchChanged: (val) {
          if (mounted)
            setState(() {
              searching = val;
            });
        },
        titleBuilder: (context) {
          return FancyTitle(
            title: Text(
              titles[index],
              style: TextStyle(fontSize: 20),
            ),
            logo: FlutterLogo(),
          );
        },
        showSearchButton: false,
        tabs: <TabChild>[
          sideBarListObjSpecific(
              Icon(
                Icons.home,
                color: Colors.grey,
                size: iconsize,
              ),
              titles[0],
              Colors.blue[colorDarkness],
              setSpecificHome()),
          sideBarListObjGeneric(
              Icon(
                Icons.subscriptions,
                color: Colors.deepOrangeAccent,
                size: iconsize,
              ),
              titles[1],
              Colors.red[colorDarkness]),
          sideBarListObjGeneric(
              Icon(
                Icons.favorite,
                color: Colors.pinkAccent,
                size: iconsize,
              ),
              titles[2],
              Colors.pink[colorDarkness]),
          sideBarListObjGeneric(
              Icon(
                Icons.thumb_up,
                color: Colors.blue,
                size: iconsize,
              ),
              titles[3],
              Colors.blue[colorDarkness]),
          sideBarListObjGeneric(
              Icon(
                Icons.account_circle,
                color: Colors.deepOrangeAccent,
                size: iconsize,
              ),
              titles[4],
              Colors.red[colorDarkness]),
          sideBarListObjSpecific(
              Icon(
                Icons.settings,
                color: Colors.grey,
                size: iconsize,
              ),
              titles[5],
              Colors.grey[colorDarkness],
              SettingsScreen(onThemeChange)),
          sideBarListObjSpecific(
              Icon(
                Icons.share,
                color: Colors.green,
                size: iconsize,
              ),
              titles[6],
              Colors.green[colorDarkness],
              ShareUs(bgcolour: Colors.green[colorDarkness])),
          sideBarListObjGeneric(
              Icon(
                Icons.bug_report,
                color: Colors.red,
                size: iconsize,
              ),
              titles[7],
              Colors.red[colorDarkness]),
          sideBarListObjGeneric(
              Icon(
                Icons.contact_mail,
                color: Colors.blue,
                size: iconsize,
              ),
              titles[8],
              Colors.blue[colorDarkness]),
        ],
      ),
    ));
  }
}

class PageTitle extends StatefulWidget {
  final Widget title;
  PageTitle(this.title);
  @override
  _PageTitle createState() => _PageTitle(title);
}

class _PageTitle extends State<PageTitle> {
  final Widget title;
  _PageTitle(this.title);
  Widget build(BuildContext context) {
    return title;
  }
}

class FancyTitle extends StatelessWidget {
  const FancyTitle({
    Key key,
    @required this.title,
    this.logo,
  }) : super(key: key);

  final Widget logo;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    if (logo == null) {
      return logo;
    }
    return Row(
      children: <Widget>[
        logo,
        Container(width: 8.0),
        PageTitle(title),
      ],
    );
  }
}

class NewScreen extends StatelessWidget {
  const NewScreen({
    Key key,
    @required this.color,
    @required this.name,
  }) : super(key: key);

  final Color color;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: RaisedButton.icon(
          icon: Icon(Icons.arrow_right),
          label: Text("Push to Screen"),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => Scaffold(
                appBar: AppBar(),
                body: NewScreen(color: color, name: name),
              ),
            ));
          },
        ),
      ),
    );
  }
}
