import 'package:flutter/material.dart';


class YourDefaultPage extends StatelessWidget {
  final Icon customicon;
  final String text;
  final Color bgcolour;
  YourDefaultPage({@required this.customicon, @required this.text, @required this.bgcolour});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgcolour,
      child: Center(
        child: Container(child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            customicon,
            Text('$text come here!',
              style: Theme.of(context).textTheme.title
            )
          ]
        ), 
      ) 
      )
    );
  }
}