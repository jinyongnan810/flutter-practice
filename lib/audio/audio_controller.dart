// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:logging/logging.dart';

import 'songs.dart';
import 'sounds.dart';

/// Allows playing music and sound. A facade to `package:audioplayers`.
class AudioController {
  final _logger = Logger('AudioController');

  final AudioPlayer _musicPlayer;
  final List<AudioPlayer> _sfxPlayers;

  int _currentSfxPlayer = 0;

  final Queue<Song> _playlist;

  final Random _random = Random();

  final sfxPrefix = 'sfx/';
  final musicPrefix = 'music/';

  final hasSetup = Completer();

  /// Creates an instance that plays music and sound.
  ///
  /// Use [polyphony] to configure the number of sound effects (SFX) that can
  /// play at the same time. A [polyphony] of `1` will always only play one
  /// sound (a new sound will stop the previous one). See discussion
  /// of [_sfxPlayers] to learn why this is the case.
  ///
  /// Background music does not count into the [polyphony] limit. Music will
  /// never be overridden by sound effects.
  AudioController({int polyphony = 2})
      : assert(polyphony >= 1),
        _musicPlayer = AudioPlayer(playerId: 'musicPlayer'),
        _sfxPlayers = Iterable.generate(
          polyphony,
          (i) => AudioPlayer(
            playerId: 'sfxPlayer#$i',
          ),
        ).toList(growable: false),
        _playlist = Queue.of(List<Song>.of(songs)..shuffle()) {
    setup();
  }

  Future<void> setup() async {
    _musicPlayer.onPlayerComplete.listen(_changeSong);
    _musicPlayer.setVolume(0.5);
    _musicPlayer.setReleaseMode(ReleaseMode.stop);
    for (var player in _sfxPlayers) {
      player.setVolume(0.8);
      player
        ..setPlayerMode(PlayerMode.lowLatency)
        ..setReleaseMode(ReleaseMode.stop);
    }
    hasSetup.complete();
  }

  void dispose() {
    _stopAllSound();
    _musicPlayer.dispose();
    for (final player in _sfxPlayers) {
      player.dispose();
    }
  }

  /// Plays a single sound effect, defined by [type].
  ///
  /// The controller will ignore this call when the attached settings'
  /// [SettingsController.muted] is `true` or if its
  /// [SettingsController.soundsOn] is `false`.
  Future<void> playSfx(SfxType type) async {
    await hasSetup.future;
    final options = soundTypeToFilename(type);
    final filename = options[_random.nextInt(options.length)];
    _logger.info('playing sfx:$filename');
    _sfxPlayers[_currentSfxPlayer].play(
      AssetSource('$sfxPrefix$filename'),
      volume: soundTypeToVolume(type),
    );
    _currentSfxPlayer = (_currentSfxPlayer + 1) % _sfxPlayers.length;
  }

  Future<void> _changeSong(void _) async {
    await hasSetup.future;
    // Put the song that just finished playing to the end of the playlist.
    _playlist.addLast(_playlist.removeFirst());
    // Play the next song.
    _musicPlayer.play(AssetSource('$musicPrefix${_playlist.first.filename}'));
  }

  Future<void> startMusic() async {
    await hasSetup.future;
    switch (_musicPlayer.state) {
      case PlayerState.paused:
        try {
          await _musicPlayer.resume();
          _logger.info('music resumed');
        } catch (e) {
          // Sometimes, resuming fails with an "Unexpected" error.
          _logger.info(e);
          await _musicPlayer
              .play(AssetSource('$musicPrefix${_playlist.first.filename}'));
        }
        break;
      case PlayerState.stopped:
        await _musicPlayer
            .play(AssetSource('$musicPrefix${_playlist.first.filename}'));
        _logger.info('music started');
        break;
      case PlayerState.playing:
        break;
      case PlayerState.completed:
        await _musicPlayer
            .play(AssetSource('$musicPrefix${_playlist.first.filename}'));
        _logger.info('music started');
        break;
      case PlayerState.disposed:
        break;
    }
  }

  Future<void> _stopAllSound() async {
    await hasSetup.future;
    if (_musicPlayer.state == PlayerState.playing) {
      _musicPlayer.pause();
    }
    for (final player in _sfxPlayers) {
      player.stop();
    }
  }

  Future<void> stopMusic() async {
    await hasSetup.future;
    if (_musicPlayer.state == PlayerState.playing) {
      _musicPlayer.pause();
      _logger.info('music stopped');
    }
  }
}
