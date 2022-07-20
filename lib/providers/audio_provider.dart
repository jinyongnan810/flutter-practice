import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_practice/audio/audio_controller.dart';

final audioControllerProvider = StateProvider.autoDispose<AudioController>(
  (ref) => AudioController()..initialize(),
);
