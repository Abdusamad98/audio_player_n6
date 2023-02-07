import 'package:audio_player_n6/ui/audio/all_audios_screen.dart';
import 'package:audio_player_n6/ui/audio/widgets/volume_changer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({Key? key}) : super(key: key);

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final AudioPlayer player = AudioPlayer();

  double _currentSliderValue = 0.2;

  double volume = 0.3;

  bool isPlaying = false;

  Duration duration = Duration.zero;
  Duration currentDuration = Duration.zero;

  @override
  void initState() {
    //_init();
    _getStoragePermission();
    super.initState();
  }

  _init() async {
    await player.setSource(AssetSource("mp3/mozart.mp3"));
    player.onDurationChanged.listen((Duration d) {
      setState(() {
        duration = d;
      });
    });

    player.onPositionChanged.listen((Duration d) {
      setState(() {
        currentDuration = d;
      });
    });

    player.onPlayerComplete.listen((event) {
      isPlaying = false;
      duration = Duration.zero;
      currentDuration = Duration.zero;
      setState(() {});
    });
  }

  _getStoragePermission() async {
    await Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Audio Screen"),
      ),
      body: Container(
        child: Center(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    if (isPlaying) {
                      player.pause();
                    } else {
                      await player.play(AssetSource("mp3/mozart.mp3"));
                    }
                    isPlaying = !isPlaying;
                    setState(() {});
                  },
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                ),
                const SizedBox(width: 50),
                IconButton(
                  onPressed: () async {
                    isPlaying = false;
                    await player.stop();
                    currentDuration = Duration.zero;
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.stop,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            Text("Max Duration: ${duration.inSeconds.toString()}"),
            Text("Current Duration: ${currentDuration.inSeconds.toString()}"),
            VolumeChanger(
                currentVolume: (volume * 10).toInt(),
                onVolumeChanged: (onNewVolume) {
                  volume = onNewVolume / 10;
                  player.setVolume(volume);
                  setState(() {});
                  print("NEW VOLUME:$onNewVolume");
                }),
            TextButton(
              onPressed: () async {
                if (currentDuration.inSeconds > 10) {
                  await player
                      .seek(Duration(seconds: currentDuration.inSeconds - 10));
                }
                setState(() {});
              },
              child: const Text("- 10 sekund"),
            ),
            TextButton(
              onPressed: () async {
                await player
                    .seek(Duration(seconds: currentDuration.inSeconds + 10));
                setState(() {});
              },
              child: const Text("+ 10 sekund"),
            ),
            const SizedBox(height: 20),
            Slider(
              value: _currentSliderValue,
              max: 1,
              divisions: 10,

              //label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                print(value);
                setState(() {
                  _currentSliderValue = value;
                });
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  var storagePerStatus = await Permission.storage.isGranted;
                  if (!mounted) return;
                  print("STORAGE PERMISSON:$storagePerStatus");
                  if (storagePerStatus) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AllAudiosScreen();
                        },
                      ),
                    );
                  }else{
                    Permission.storage.request();
                  }
                },
                child: Text("Get All Songs"))
          ],
        )),
      ),
    );
  }
}
