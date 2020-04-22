import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoExample extends StatefulWidget {
  final String videoUrl = "";
  VideoExample(String videoUrl, {Key key}) : super(key: key);
  @override
  VideoState createState() => VideoState();
}

class VideoState extends State<VideoExample> {
  String Url;
  VideoPlayerController playerController;
  VoidCallback listener;

  @override
  void initState() {
    super.initState();
    listener = () {
      setState(() {});
      Url = widget.videoUrl;
    };
  }

  void createVideo(String url) {
    if (playerController == null) {
      playerController = VideoPlayerController.network(url)
        ..addListener(listener)
        ..setVolume(1.0)
        ..initialize()
        ..play();
    } else {
      if (playerController.value.isPlaying) {
        playerController.pause();
      } else {
        playerController.initialize();
        playerController.play();
      }
    }
  }

  @override
  void deactivate() {
    playerController.setVolume(0.0);
    playerController.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: GestureDetector(
          onTap: () {
            createVideo(Url);
            playerController.play();
          },
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: (playerController != null
                ? VideoPlayer(playerController)
                : Container()),
          ),
        ),
      ),
    );
  }
}
