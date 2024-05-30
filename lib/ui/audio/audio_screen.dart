import 'dart:io';

import 'package:audio_player_n6/ui/audio/all_audios_screen.dart';
import 'package:audio_player_n6/ui/audio/widgets/volume_changer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({Key? key}) : super(key: key);

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final AudioPlayer player = AudioPlayer();

  bool _hasPermission = false;

  String url = "";

  double _currentSliderValue = 0.2;

  double volume = 0.3;

  bool isPlaying = false;

  Duration duration = Duration.zero;
  Duration currentDuration = Duration.zero;

  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  void initState() {
    //_init();
    super.initState();
  }

  _init() async {
    await player.setSource(DeviceFileSource(url));
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

  _getStoragePermission({bool retry = false}) async {
    final info = await DeviceInfoPlugin().androidInfo;
    if (Platform.isAndroid && info.version.sdkInt > 29) {
      await Permission.manageExternalStorage.request();
    } else {
      await Permission.storage.request();
    }
    // The param 'retryRequest' is false, by default.
    _hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: retry,
    );

    // Only call update the UI if application has all required permissions.
    _hasPermission ? setState(() {}) : null;

    return await Permission.storage.request().isGranted;
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
                      await player.play(DeviceFileSource(url));
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
                  _getStoragePermission();
                  var storagePerStatus = await Permission.storage.isGranted ||
                      await Permission.manageExternalStorage.isGranted;
                  if (!mounted) return;
                  print("STORAGE PERMISSON:$storagePerStatus");
                  if (storagePerStatus) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AllAudiosScreen(
                            onMusicChosen: (uri) {
                              url = uri;
                              _init();
                            },
                          );
                        },
                      ),
                    );
                  } else {
                    _getStoragePermission();
                  }
                },
                child: Text("Get All Songs"))
          ],
        )),
      ),
    );
  }
}
