import 'package:share/share.dart';
import 'package:flutter/material.dart';

class ShareUs extends StatelessWidget {
  final Color bgcolour;
  ShareUs({@required this.bgcolour});
  @override
  Widget build(BuildContext context) {
    String message='I recommend that you check \"Appname\", a meeting point for investors and startups!';
    Share.share(message, subject: 'Checkout This New App!');
    return Container(
      color: bgcolour,
      child: Center(
        child: Container(child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.share,color: Colors.green,size: 40,),
            Text('Thank you for sharing this app!',
              style: Theme.of(context).textTheme.title
            )
          ]
        ), 
      ) 
      )
    );
  }
}