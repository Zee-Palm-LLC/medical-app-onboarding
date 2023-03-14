import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final String videoUrl;

  const VideoScreen({super.key, required this.videoUrl});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _videoPlayerController;

  bool _isPlaying = false;
  double _videoDuration = 0;
  double _videoPosition = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() {
        setState(() {
          _videoDuration =
              _videoPlayerController.value.duration.inMilliseconds.toDouble();
          _videoPosition =
              _videoPlayerController.value.position.inMilliseconds.toDouble();
        });
      })
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Duration fullDuration = _videoPlayerController.value.duration;
    final Duration position = _videoPlayerController.value.position;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back, color: Colors.white)),
        ),
        body: Column(
          children: <Widget>[
            const Spacer(),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: VideoPlayer(_videoPlayerController),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: IconButton(
                      icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                      onPressed: () {
                        setState(() {
                          _isPlaying = !_isPlaying;
                          if (_isPlaying) {
                            _videoPlayerController.play();
                            _timer = Timer.periodic(Duration(milliseconds: 500),
                                (timer) {
                              setState(() {
                                _videoPosition = _videoPlayerController
                                    .value.position.inMilliseconds
                                    .toDouble();
                              });
                            });
                          } else {
                            _videoPlayerController.pause();
                            _timer.cancel();
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      trackShape: CustomTrackShape(),
                    ),
                    child: Slider(
                      value: _videoPosition,
                      min: 0,
                      activeColor: Colors.red,
                      inactiveColor: Colors.grey,
                      max: _videoDuration,
                      onChanged: (value) {
                        setState(() {
                          _videoPosition = value;
                        });
                        _videoPlayerController
                            .seekTo(Duration(milliseconds: value.toInt()));
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '${fullDuration.inMinutes}:${(fullDuration.inSeconds % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: IconButton(
                    constraints: BoxConstraints(),
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.fullscreen_outlined, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
