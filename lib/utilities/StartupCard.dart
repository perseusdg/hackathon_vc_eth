import 'package:flutter/material.dart';
import 'package:hackathon/utilities/Startup.dart';
import 'package:youtube_player/youtube_player.dart';


class StartupCard extends StatelessWidget {

  //this class takes in a startup class instance as input and outputs a card
  //for it to be displayed on the user's screen

  final Startup startup;

  StartupCard({this.startup});

  @override

  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Container(
          width: 160.0,
          child: YoutubePlayer(
            context: context,
            source: startup.url,
            quality: YoutubeQuality.LOW,
            aspectRatio: 16/9,
            showThumbnail: true,
            autoPlay: false,
            startFullScreen: true,
          ),
        ),
        Row(
          children: <Widget> [
            FlatButton(
              onPressed: () {},
              child: Icon(Icons.phone),
            ),
            FlatButton(
              onPressed: () {},
              child: Icon(Icons.email),
            ),
          ],
        ),
      ],
    );

  }
}
