import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPickerDialog extends StatefulWidget {
  final File videoUrl;

  const VideoPickerDialog({super.key, required this.videoUrl});

  @override
  State<VideoPickerDialog> createState() => _VideoPickerDialogState();
}

class _VideoPickerDialogState extends State<VideoPickerDialog> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _initialized = true;
        });
        _controller.play();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: double.infinity,
        height: 400,
        child: _initialized
            ? AspectRatio(
                aspectRatio: 9 / 13,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: VideoPlayer(_controller)),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
