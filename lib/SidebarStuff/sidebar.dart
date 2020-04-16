import 'package:hackathon/SidebarStuff/mobile_sidebar.dart';
import 'package:hackathon/SidebarStuff/YourDefaultPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


TabChild sideBarListObj(Icon customicon,String text, Color colortobepassed){
              return TabChild(
                  icon: customicon,
                  title: text,
                  builder: (context) => YourDefaultPage(customicon:customicon,text:text,bgcolour: colortobepassed,),
              );
}

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
            sideBarListObj(Icon(Icons.favorite,color: Colors.pinkAccent,size: iconsize,),'Your Favs',Colors.pinkAccent[100]),
            sideBarListObj(Icon(Icons.thumb_up,color: Colors.blue,size: iconsize,),'Your Likes',Colors.blue[100]),
            sideBarListObj(Icon(Icons.chat,color: Colors.green,size: iconsize,),'Your Chats',Colors.green[100]),
            sideBarListObj(Icon(Icons.account_circle,color: Colors.grey,size: iconsize,),'Your Profile', Colors.grey[100]),
            sideBarListObj(Icon(Icons.share,color: Colors.green,size: iconsize,),'Share (AppName)',Colors.green[100]),
            sideBarListObj(Icon(Icons.bug_report,color: Colors.red,size: iconsize,),'Report A Bug',Colors.red[100]),
            sideBarListObj(Icon(Icons.contact_mail,color: Colors.blue,size: iconsize,),'Contact Us',Colors.blue[100]),
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