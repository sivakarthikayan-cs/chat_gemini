import 'package:chat_gemini/page/provider/speech/state/speech_notifier.dart';
import 'package:chat_gemini/page/provider/speech/state/speech_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

final speechStateNotifierProvider =
    StateNotifierProvider<SpeechNotifier, SpeechState>(
  (ref) {
    final FlutterTts flutterTts = FlutterTts();
    return SpeechNotifier(flutterTts: flutterTts);
  },
);
