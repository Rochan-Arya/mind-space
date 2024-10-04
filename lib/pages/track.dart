import 'package:flutter/material.dart';
import 'package:mind_space/models/playlist_provider.dart';
import 'package:mind_space/models/song.dart';
import 'package:mind_space/pages/songpage.dart';
import 'package:provider/provider.dart';

class TrackPage extends StatefulWidget {
  const TrackPage({super.key, required song});

  @override
  State<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  //provider get

  late final dynamic playListProvider;

  void initState() {
    super.initState();

    playListProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void gotoSong(int songIndex) {
    playListProvider.currentSongIndex = songIndex;

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Songpage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Consumer<PlaylistProvider>(builder: (context, value, child) {
        //get playlisttt
        final List<Song> playList = value.playList;

        return ListView.builder(
          itemCount: playList.length,
          itemBuilder: (context, index) {
            final Song song = playList[index];

            return ListTile(
              title: Text(
                song.songName,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                song.artistName,
                style: TextStyle(color: Colors.white),
              ),
              leading: Image.asset(song.albumArtimgPath),
              onTap: () => gotoSong(index),
            );
          },
        );
      }),
    );
  }
}
