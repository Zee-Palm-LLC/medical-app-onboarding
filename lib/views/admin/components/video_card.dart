import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerCard extends StatefulWidget {
  final File videoFile;
  VideoPlayerCard({required this.videoFile});

  @override
  _VideoPlayerCardState createState() => _VideoPlayerCardState();
}

class _VideoPlayerCardState extends State<VideoPlayerCard> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        setState(() {});
      });
    _controller.addListener(() {
      setState(() {
        _isPlaying = _controller.value.isPlaying;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleVideoPlayback,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: VideoPlayer(_controller)),
          _buildPlayPauseButton(),
        ],
      ),
    );
  }

  Widget _buildPlayPauseButton() {
    if (_isPlaying) {
      return Container();
    }

    return Container(
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: IconButton(
        icon: Icon(Icons.play_arrow),
        onPressed: _toggleVideoPlayback,
      ),
    );
  }

  void _toggleVideoPlayback() {
    if (_controller.value.isPlaying) {
      _controller.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      _controller.play();
      setState(() {
        _isPlaying = true;
      });
    }
  }
}

class SmallVideoPlayerCard extends StatefulWidget {
  final String videoFile;

  final bool isDetailPage;

  SmallVideoPlayerCard({required this.videoFile, this.isDetailPage = false});

  @override
  _SmallVideoPlayerCardState createState() => _SmallVideoPlayerCardState();
}

class _SmallVideoPlayerCardState extends State<SmallVideoPlayerCard> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoFile)
      ..initialize().then((_) {
        setState(() {});
      });
    _controller.addListener(() {
      setState(() {
        _isPlaying = _controller.value.isPlaying;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isDetailPage ? null : _toggleVideoPlayback,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: VideoPlayer(_controller)),
          _buildPlayPauseButton(),
        ],
      ),
    );
  }

  Widget _buildPlayPauseButton() {
    if (_isPlaying) {
      return Container();
    }

    return Container(
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: IconButton(
        constraints: BoxConstraints(),
        padding: EdgeInsets.all(2),
        icon: Icon(Icons.play_arrow, size: 20),
        onPressed: _toggleVideoPlayback,
      ),
    );
  }

  void _toggleVideoPlayback() {
    if (_controller.value.isPlaying) {
      _controller.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      _controller.play();
      setState(() {
        _isPlaying = true;
      });
    }
  }
}
