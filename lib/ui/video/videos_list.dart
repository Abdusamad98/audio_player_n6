import 'package:audio_player_n6/ui/video/video_screen.dart';
import 'package:flutter/material.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Videos list"),
      ),
      body: ListView(
        children: [
          ...List.generate(
            videos.length,
            (index) => ListTile(
              title: Text(videos[index].videoName),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return VideoPlayerScreen(
                          videoUrl: videos[index].videoUrl);
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

List<VideoInfo> videos = [
  VideoInfo(
    videoName: "Asalari",
    videoUrl:
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
  ),
  VideoInfo(
    videoName: "Reklama",
    videoUrl: "https://www.w3docs.com/build/videos/arcnet.io(7-sec).mp4",
  )
];

class VideoInfo {
  VideoInfo({
    required this.videoUrl,
    required this.videoName,
  });

  String videoName;
  String videoUrl;
}
