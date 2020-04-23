import 'package:flutter/material.dart';
import 'utilities/Investor.dart';
import 'package:youtube_player/youtube_player.dart';


class InvestorCard extends StatelessWidget {

  //this class takes in an investor class instance as input and outputs a card
  //for it to be displayed on the user's screen

  final Investor investor;

  InvestorCard({this.investor});

  @override

  Widget build(BuildContext context) {

       return Column(
         children: <Widget>[
           Container(
             width: 160.0,
             child: YoutubePlayer(
               context: context,
               source: investor.url,
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
