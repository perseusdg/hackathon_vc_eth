import 'package:hackathon/SidebarStuff/mobile_sidebar.dart';
import 'package:hackathon/SidebarStuff/YourDefaultPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hackathon/screens/settings_screen.dart';

TabChild sideBarListObjGeneric(Icon customicon,String text, Color colortobepassed){
  return TabChild(
    icon: customicon,
    title: text,
    builder: (context) => YourDefaultPage(customicon:customicon,text:text,bgcolour: colortobepassed,),
  );
}

TabChild sideBarListObjSpecific(Icon customicon,String text, Color colortobepassed, Widget nextScreen){
  return TabChild(
    icon: customicon,
    title: text,
    builder: (context) => nextScreen,
  );
}

// <Frontend>
class SideBarScreen extends StatefulWidget {
  @override
  _SideBarScreen createState() => _SideBarScreen();
}

class _SideBarScreen extends State<SideBarScreen> {
  int index = 0;
  double iconsize = 40.0;
  bool searching = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MobileSidebar(
          currentIndex: index,
          onTabChanged: (val) {
            if (mounted)
              setState(() {
                index = val;
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
              title: Text("My Logo"),
              logo: FlutterLogo(),
            );
          },
          showSearchButton: true,
          tabs: <TabChild>[
            sideBarListObjGeneric(Icon(Icons.favorite,color: Colors.pinkAccent,size: iconsize,),'Your Favs',Colors.pinkAccent[100]),
            sideBarListObjGeneric(Icon(Icons.thumb_up,color: Colors.blue,size: iconsize,),'Your Likes',Colors.blue[100]),
            sideBarListObjGeneric(Icon(Icons.chat,color: Colors.green,size: iconsize,),'Your Chats',Colors.green[100]),
            sideBarListObjGeneric(Icon(Icons.account_circle,color: Colors.deepOrangeAccent,size: iconsize,),'Your Profile', Colors.grey[100]),
            sideBarListObjSpecific(Icon(Icons.settings,color: Colors.grey,size: iconsize,),'Settings', Colors.grey[100], SettingsScreen()),
            sideBarListObjGeneric(Icon(Icons.share,color: Colors.green,size: iconsize,),'Share (AppName)',Colors.green[100]),
            sideBarListObjGeneric(Icon(Icons.bug_report,color: Colors.red,size: iconsize,),'Report A Bug',Colors.red[100]),
            sideBarListObjGeneric(Icon(Icons.contact_mail,color: Colors.blue,size: iconsize,),'Contact Us',Colors.blue[100]),
          ],
        ),
      )
    );
  }
}

class FancyTitle extends StatelessWidget {
  const FancyTitle({
    Key key,
    @required this.title,
    this.logo,
  }) : super(key: key);

  final Widget title;
  final Widget logo;

  @override
  Widget build(BuildContext context) {
    if (logo == null) {
      return logo;
    }
    return Row(
      children: <Widget>[
        logo,
        Container(width: 4.0),
        title,
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