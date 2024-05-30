import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllAudiosScreen extends StatelessWidget {
  const AllAudiosScreen({Key? key, required this.onMusicChosen})
      : super(key: key);

  final ValueChanged<String> onMusicChosen;

  @override
  Widget build(BuildContext context) {
    final OnAudioQuery _audioQuery = OnAudioQuery();

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
                      trailing: QueryArtworkWidget(
                        id: item.id,
                        type: ArtworkType.ARTIST,
                      ),
                      onTap: () {
                        print('''
                        TITLE:  ${item.title},
                        DATA:  ${item.data},
                        ID:  ${item.id},
                        ALBUM:  ${item.album},
                        URI:  ${item.uri},
                        SIZE:  ${item.size},
                        ARTIST:  ${item.artist},
                        displayName:  ${item.displayName},
                        genre:  ${item.genre},
                        isMusic:  ${item.isMusic},
                          ''');
                        onMusicChosen.call(item.data);
                        Navigator.pop(context);
                      },
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
