import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);
  final String videoUrl;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  double currentDuration = 0;
  bool isLandscape = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
    _controllerObserver();
  }

  _controllerObserver() {
    _controller.addListener(() {
      setState(() {});
      currentDuration = _controller.value.position.inMilliseconds.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("VIDEO ASPECT RATIO:${_controller.value.aspectRatio}");

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Video Player"),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(
                        _controller,
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
            Slider(
                divisions: 20,
                max: _controller.value.duration.inMilliseconds.toDouble(),
                value: currentDuration,
                onChanged: (v) {
                  setState(() {});
                  _controller.seekTo(Duration(seconds: v.toInt()));
                }),
            IconButton(
              onPressed: () {
                currentDuration += 1000;
                _controller
                    .seekTo(Duration(milliseconds: currentDuration.toInt()));
              },
              icon: Text("+1 sekund"),
            ),
            IconButton(
              onPressed: () {
                currentDuration -= 1000;
                _controller
                    .seekTo(Duration(milliseconds: currentDuration.toInt()));
              },
              icon: Text("-1 sekund"),
            ),
            IconButton(
              onPressed: () {
                if (isLandscape) {
                  isLandscape = false;
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown,
                  ]);
                } else {
                  isLandscape = true;
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.landscapeRight,
                    DeviceOrientation.landscapeLeft,
                  ]);
                }
              },
              icon: const Icon(Icons.fullscreen),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
