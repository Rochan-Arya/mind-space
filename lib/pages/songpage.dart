import 'package:flutter/material.dart';
import 'package:mind_space/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class Songpage extends StatelessWidget {
  const Songpage({super.key});

  String formatTime(Duration duration) {
    String twodigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, "0");
    String formattedTime = "${duration.inMinutes}:$twodigitSeconds";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context, value, child) {
      //get playlist
      final playlist = value.playList;

      //get the song now playing
      final currentSong = playlist[value.currentSongIndex ?? 0];

      //ui
      return Scaffold(
        backgroundColor: Colors.grey[850],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //back
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        )),

                    //title
                    Text(
                      "T R A C K",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 169, 169),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    //menu bar
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ))
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Container(
                      height: 400,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade900,
                              offset: Offset(5, 5),
                              blurRadius: 15.0,
                              spreadRadius: 0.4,
                            ),
                            BoxShadow(
                              color: Colors.grey.shade800,
                              offset: Offset(-5, -5),
                              blurRadius: 20.0,
                              spreadRadius: 0.4,
                            )
                          ]),
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(currentSong.albumArtimgPath),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          //artist name
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    currentSong.songName,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    currentSong.artistName,
                                    style: TextStyle(
                                        color: Colors.grey.shade300,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ],
                              ),

                              //heart icon
                              Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            ],
                          )
                        ],
                      )),
                ),
                SizedBox(
                  height: 30,
                ),

                //song bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatTime(value.currentDuration),
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            formatTime(value.totalDuration),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 0)),
                        child: Slider(
                          min: 0,
                          max: value.totalDuration.inSeconds.toDouble(),
                          value: value.currentDuration.inSeconds.toDouble(),
                          activeColor: Color.fromARGB(255, 255, 169, 169),
                          onChanged: (double double) {},
                          onChangeEnd: (double double) {
                            value.seek(Duration(seconds: double.toInt()));
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                //front back pause
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //prev
                    GestureDetector(
                      onTap: value.playPreviousSong,
                      child: Container(
                        height: 60,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey[850],
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade900,
                                offset: Offset(5, 5),
                                blurRadius: 15.0,
                                spreadRadius: 0.4,
                              ),
                              BoxShadow(
                                color: Colors.grey.shade800,
                                offset: Offset(-5, -5),
                                blurRadius: 20.0,
                                spreadRadius: 0.4,
                              )
                            ]),
                        child: Icon(
                          Icons.skip_previous_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    //pause
                    GestureDetector(
                      onTap: value.pauseOrResume,
                      child: Container(
                        height: 60,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.grey[850],
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade900,
                                offset: Offset(5, 5),
                                blurRadius: 15.0,
                                spreadRadius: 0.4,
                              ),
                              BoxShadow(
                                color: Colors.grey.shade800,
                                offset: Offset(-5, -5),
                                blurRadius: 20.0,
                                spreadRadius: 0.4,
                              )
                            ]),
                        child: Icon(
                          value.isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    //next
                    GestureDetector(
                      onTap: value.playNextSong,
                      child: Container(
                        height: 60,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey[850],
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade900,
                                offset: Offset(5, 5),
                                blurRadius: 15.0,
                                spreadRadius: 0.4,
                              ),
                              BoxShadow(
                                color: Colors.grey.shade800,
                                offset: Offset(-5, -5),
                                blurRadius: 20.0,
                                spreadRadius: 0.4,
                              )
                            ]),
                        child: Icon(
                          Icons.skip_next_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
