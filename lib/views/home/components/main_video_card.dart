import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final VoidCallback onTap;

  const VideoPlayerWidget({
    Key? key,
    required this.onTap,
    required this.videoUrl,
  }) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late final VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        _controller.pause();
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        alignment: Alignment.center,
        children: [
          VideoPlayer(_controller),
          Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: IconButton(
                onPressed: widget.onTap, icon: Icon(Icons.play_arrow)),
          )
        ],
      ),
    );
  }
}
