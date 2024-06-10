


import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../Const/const.dart';

class AudioView extends StatefulWidget {
  final String audio;
  const AudioView({Key? key, required this.audio}) : super(key: key);

  @override
  State<AudioView> createState() => _AudioViewState();
}

class _AudioViewState extends State<AudioView> {
  final player = AudioPlayer();
@override
  void initState() {
  if (widget.audio != "") {
    player.setUrl("$media${widget.audio}").then((value) {});
  }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 8, bottom: 8, left: 10),
      child: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.black,
        child: Center(
          child: StreamBuilder<PlayerState>(
            stream: player.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState =
                  playerState?.processingState;
              final playing = playerState?.playing;
              if (processingState ==
                  ProcessingState.loading ||
                  processingState ==
                      ProcessingState.buffering) {
                return GestureDetector(
                  child: const Icon(Icons.play_arrow,
                      color: Colors.white),
                  onTap: player.play,
                );
              } else if (playing != true) {
                return GestureDetector(
                  child: const Icon(Icons.play_arrow,
                      color: Colors.white),
                  onTap: player.play,
                );
              } else if (processingState !=
                  ProcessingState.completed) {
                return GestureDetector(
                  child: const Icon(Icons.pause,
                      color: Colors.white),
                  onTap: player.pause,
                );
              } else {
                return GestureDetector(
                  child: const Icon(Icons.replay,
                      color: Colors.white),
                  onTap: () {
                    player.seek(Duration.zero);
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
