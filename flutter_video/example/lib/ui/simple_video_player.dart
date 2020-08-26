import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_example/provider/LockMode.dart';
import 'package:flutter_video_example/test_url.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';

class SimpleVideoPlayer extends StatefulWidget {
  @override
  _SimpleVideoPlayerState createState() => _SimpleVideoPlayerState();
}

class _SimpleVideoPlayerState extends State<SimpleVideoPlayer> {
  VideoPlayerController _controller;
  GlobalKey playerKey;

  @override
  void initState() {
    super.initState();
    playerKey = GlobalKey();
    _controller = VideoPlayerController.network(
      TestUrl.testM3U8,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLocked = context.watch<LockMode>().isLock;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                key: playerKey,
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
//                  ClosedCaption(text: _controller.value.caption.text),
                  isLocked
                      ? Container(width: 0, height: 0)
                      : _ProgressBarOverlay(controller: _controller),
                  _LockScreenOverlay(controller: _controller),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({Key key, this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 50),
        reverseDuration: Duration(milliseconds: 200),
        child: controller.value.isPlaying
            ? Icon(
                Icons.pause,
                color: Colors.white,
                size: 30.0,
              )
            : Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 30.0,
              ),
      ),
      onTap: () {
        controller.value.isPlaying ? controller.pause() : controller.play();
      },
    );
  }
}

class _ProgressBarOverlay extends StatelessWidget {
  const _ProgressBarOverlay({Key key, this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 40, child: _PlayPauseOverlay(controller: controller)),
        Expanded(
            child: VideoProgressIndicator(controller, allowScrubbing: true)),
      ],
    );
  }
}

class _LockScreenOverlay extends StatelessWidget {
  const _LockScreenOverlay({Key key, this.controller}) : super(key: key);
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    bool isLocked = context.watch<LockMode>().isLock;

    return Container(
      padding: EdgeInsets.only(left: 15),
      height: double.infinity,
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: isLocked
              ? Icon(
                  Icons.lock,
                  color: Colors.yellow,
                  size: 30,
                )
              : Icon(
                  Icons.lock_open,
                  color: Colors.white,
                  size: 30,
                ),
        ),
        onTap: () {
          context.read<LockMode>().setLock(!isLocked);
        },
      ),
    );
  }
}
