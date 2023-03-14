import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SmallVideoCard extends StatefulWidget {
  final String videoUrl;

  SmallVideoCard({required this.videoUrl});

  @override
  _SmallVideoCardState createState() => _SmallVideoCardState();
}

class _SmallVideoCardState extends State<SmallVideoCard> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _initialized = true;
        });
        _controller.pause();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height:200,
      child: _initialized
          ? Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: VideoPlayer(_controller)),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
