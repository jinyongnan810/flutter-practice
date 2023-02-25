// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:collection';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart' hide Logger;
import 'package:logging/logging.dart';

import 'songs.dart';
import 'sounds.dart';

/// Allows playing music and sound. A facade to `package:audioplayers`.
class AudioController {
  final _logger = Logger('AudioController');

  late AudioCache _sfxCache;

  final AudioPlayer _musicPlayer;

  /// This is a list of [AudioPlayer] instances which are rotated to play
  /// sound effects.
  ///
  /// Normally, we would just call [AudioCache.play] and let it procure its
  /// own [AudioPlayer] every time. But this seems to lead to errors and
  /// bad performance on iOS devices.
  final List<AudioPlayer> _sfxPlayers;

  int _currentSfxPlayer = 0;

  final Queue<Song> _playlist;

  final Random _random = Random();

  final sfxPrefix = 'assets/sfx/';
  final musicPrefix = 'assets/music/';

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
                    )..setPlayerMode(PlayerMode.lowLatency))
            .toList(growable: false),
        _playlist = Queue.of(List<Song>.of(songs)..shuffle()) {
    _sfxCache = AudioCache(
      prefix: sfxPrefix,
    );
    _musicPlayer.onPlayerComplete.listen(_changeSong);
  }

  void dispose() {
    _stopAllSound();
    _musicPlayer.dispose();
    for (final player in _sfxPlayers) {
      player.dispose();
    }
  }

  /// Preloads all sound effects.
  Future<void> initialize() async {
    // This assumes there is only a limited number of sound effects in the game.
    // If there are hundreds of long sound effect files, it's better
    // to be more selective when preloading.
    await _sfxCache
        .loadAll(SfxType.values.expand(soundTypeToFilename).toList());
  }

  /// Plays a single sound effect, defined by [type].
  ///
  /// The controller will ignore this call when the attached settings'
  /// [SettingsController.muted] is `true` or if its
  /// [SettingsController.soundsOn] is `false`.
  void playSfx(SfxType type) {
    final options = soundTypeToFilename(type);
    final filename = options[_random.nextInt(options.length)];
    _logger.info('playing sfx:$filename');
    final sfxUri = _sfxCache.loadedFiles[filename];
    _sfxPlayers[_currentSfxPlayer].play(
        sfxUri != null
            ? UrlSource(sfxUri.path)
            : UrlSource('$sfxPrefix$filename'),
        volume: soundTypeToVolume(type));
    _currentSfxPlayer = (_currentSfxPlayer + 1) % _sfxPlayers.length;
  }

  void _changeSong(void _) {
    // Put the song that just finished playing to the end of the playlist.
    _playlist.addLast(_playlist.removeFirst());
    // Play the next song.
    _musicPlayer.play(UrlSource('$musicPrefix${_playlist.first.filename}'));
  }

  Future<void> _resumeMusic() async {
    switch (_musicPlayer.state) {
      case PlayerState.paused:
        try {
          await _musicPlayer.resume();
        } catch (e) {
          // Sometimes, resuming fails with an "Unexpected" error.
          print(e);
          await _musicPlayer
              .play(UrlSource('$musicPrefix${_playlist.first.filename}'));
        }
        break;
      case PlayerState.stopped:
        await _musicPlayer
            .play(UrlSource('$musicPrefix${_playlist.first.filename}'));
        break;
      case PlayerState.playing:
        break;
      case PlayerState.completed:
        await _musicPlayer
            .play(UrlSource('$musicPrefix${_playlist.first.filename}'));
        break;
    }
  }

  void _soundsOnHandler() {
    for (final player in _sfxPlayers) {
      if (player.state == PlayerState.playing) {
        player.stop();
      }
    }
  }

  void startMusic() {
    _musicPlayer.play(UrlSource('$musicPrefix${_playlist.first.filename}'));
    _logger.info('music started');
  }

  void _stopAllSound() {
    if (_musicPlayer.state == PlayerState.playing) {
      _musicPlayer.pause();
    }
    for (final player in _sfxPlayers) {
      player.stop();
    }
  }

  void stopMusic() {
    if (_musicPlayer.state == PlayerState.playing) {
      _musicPlayer.pause();
      _logger.info('music stopped');
    }
  }
}
