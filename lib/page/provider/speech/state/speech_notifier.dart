import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'speech_state.dart';

class SpeechNotifier extends StateNotifier<SpeechState> {
  final FlutterTts flutterTts;
  SpeechNotifier({required this.flutterTts}) : super(SpeechState.initial()) {
    _initialFunction();
  }
  Map<int, SpeechStateConcreteState> hh = {5: SpeechStateConcreteState.paused};
  String? language;
  String? engine;
  double volume = 1.0;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;
  int currentItemId = 0;

  String? _newVoiceText;
  int? _inputLength;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isWeb => kIsWeb;
  dynamic _initialFunction() async {
    _inputLength = await flutterTts.getMaxSpeechInputLength;
    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      print("Playing");
      state = state.copyWith(
          state: SpeechStateConcreteState.playing,
          currentState: {currentItemId: SpeechStateConcreteState.playing});
    });

    flutterTts.setCompletionHandler(() {
      print("Complete");
      state = state.copyWith(
          state: SpeechStateConcreteState.stopped,
          currentState: {currentItemId: SpeechStateConcreteState.stopped});
      currentItemId = -1;
    });

    flutterTts.setCancelHandler(() {
      print("Cancel");
      state = state.copyWith(
          state: SpeechStateConcreteState.stopped,
          currentState: {currentItemId: SpeechStateConcreteState.stopped});
    });

    flutterTts.setPauseHandler(() {
      print("Paused");
      state = state.copyWith(
          state: SpeechStateConcreteState.paused,
          currentState: {currentItemId: SpeechStateConcreteState.paused});
    });

    flutterTts.setContinueHandler(() {
      print("Continued");
      state = state.copyWith(
          state: SpeechStateConcreteState.continued,
          currentState: {currentItemId: SpeechStateConcreteState.playing});
    });
    flutterTts.setErrorHandler((msg) {
      print("error: $msg");
      state = state.copyWith(
          state: SpeechStateConcreteState.stopped,
          currentState: {currentItemId: SpeechStateConcreteState.stopped});
    });
  }

  Future<dynamic> _getLanguages() async => await flutterTts.getLanguages;

  Future<dynamic> _getEngines() async => await flutterTts.getEngines;

  Future<void> _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future<void> _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }

  Future<void> speak({String? msg, int? itemId}) async {
    if (itemId != currentItemId) {
      await stop();
    }
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (msg != null && msg.isNotEmpty) {
      currentItemId = itemId!;
      var result = await flutterTts.speak(msg);
      print(result);
      state = state.copyWith(
          currentState: {currentItemId: SpeechStateConcreteState.playing});
    }
  }

  Future<void> _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future<void> stop() async {
    var result = await flutterTts.stop();
    if (result == 1) {
      state = state.copyWith(
          state: SpeechStateConcreteState.stopped,
          currentState: {currentItemId: SpeechStateConcreteState.stopped});
    }
  }

  Future<void> pause() async {
    var result = await flutterTts.pause();
    if (result == 1) {
      state = state.copyWith(
          state: SpeechStateConcreteState.paused,
          currentState: {currentItemId: SpeechStateConcreteState.paused});
    }
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }
}
