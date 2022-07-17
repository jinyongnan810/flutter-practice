import 'package:flutter/material.dart';
import 'package:flutter_practice/audio/audio_controller.dart';
import 'package:flutter_practice/audio/sounds.dart';
import 'package:flutter_practice/shared/demo-widget.dart';
import 'package:provider/provider.dart';

class PlaySoundDemo extends StatefulWidget implements DemoWidget {
  const PlaySoundDemo({Key? key}) : super(key: key);
  static const String _title = 'Play Sound Demo';
  static const String _description =
      'Practice Caching and Playing Sound and all';

  @override
  State<PlaySoundDemo> createState() => _PlaySoundDemoState();
  @override
  String get title => PlaySoundDemo._title;

  @override
  String get description => PlaySoundDemo._description;

  @override
  Icon get icon => const Icon(Icons.music_note);
}

class _PlaySoundDemoState extends State<PlaySoundDemo> {
  bool playingMusic = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                final audioController =
                    Provider.of<AudioController>(context, listen: false);
                audioController.playSfx(SfxType.buttonTap);
              },
              child: const Text('play sfx')),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                final audioController =
                    Provider.of<AudioController>(context, listen: false);
                if (playingMusic) {
                  audioController.stopMusic();
                  setState(() {
                    playingMusic = false;
                  });
                } else {
                  audioController.startMusic();
                  setState(() {
                    playingMusic = true;
                  });
                }
              },
              child: Text(playingMusic ? 'stop music' : 'play music'))
        ],
      ),
    );
  }
}
