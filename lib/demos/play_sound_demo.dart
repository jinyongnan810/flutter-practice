import 'package:flutter/material.dart';
import 'package:flutter_practice/audio/sounds.dart';
import 'package:flutter_practice/providers/audio_provider.dart';
import 'package:flutter_practice/shared/demo_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaySoundDemo extends ConsumerStatefulWidget implements DemoWidget {
  const PlaySoundDemo({super.key});
  static const String _title = 'Play Sound Demo';
  static const String _description =
      'Practice Caching and Playing Sound and all';

  @override
  ConsumerState<PlaySoundDemo> createState() => _PlaySoundDemoState();
  @override
  String get title => PlaySoundDemo._title;

  @override
  String get description => PlaySoundDemo._description;

  @override
  Widget get icon => const Icon(Icons.music_note);
}

class _PlaySoundDemoState extends ConsumerState<PlaySoundDemo> {
  bool playingMusic = false;

  @override
  Widget build(BuildContext context) {
    final audioController = ref.watch(audioControllerProvider);
    final content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              audioController.playSfx(SfxType.buttonTap);
            },
            child: const Text('play sfx'),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
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
            child: Text(playingMusic ? 'stop music' : 'play music'),
          ),
        ],
      ),
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: content,
      ),
    );
  }
}
