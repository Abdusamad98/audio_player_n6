import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllAudiosScreen extends StatefulWidget {
  const AllAudiosScreen({Key? key}) : super(key: key);

  @override
  State<AllAudiosScreen> createState() => _AllAudiosScreenState();
}

class _AllAudiosScreenState extends State<AllAudiosScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Audios screen'),
      ),
      body: FutureBuilder<List<SongModel>>(
          future: _audioQuery.querySongs(),
          builder: (context, AsyncSnapshot<List<SongModel>> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  ...List.generate(snapshot.data!.length, (index) {
                    var item = snapshot.data![index];
                    return ListTile(
                      title: Text(item.title),
                    );
                  })
                ],
              );
            } else {
              return const Center(
                child: Text("Loading..."),
              );
            }
          }),
    );
  }
}
