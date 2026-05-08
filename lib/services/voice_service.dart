import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

class VoiceService {
  VoiceService._();

  static final VoiceService instance = VoiceService._();

  final FlutterTts _tts = FlutterTts();
  bool _isInitialized = false;
  final ValueNotifier<bool> isMutedNotifier = ValueNotifier<bool>(false);

  bool get isMuted => isMutedNotifier.value;

  Future<void> _ensureInitialized() async {
    if (_isInitialized) return;
    await _tts.setSpeechRate(0.5);
    await _tts.setPitch(1.0);
    await _tts.setVolume(1.0);
    _isInitialized = true;
  }

  Future<void> speak(String text) async {
    if (isMuted) return;
    final String value = text.trim();
    if (value.isEmpty) return;

    await _ensureInitialized();
    await _tts.stop();
    await _tts.speak(value);
  }

  Future<void> setMuted(bool value) async {
    isMutedNotifier.value = value;
    if (value) {
      await _tts.stop();
    }
  }

  Future<void> toggleMute() async {
    final bool next = !isMuted;
    await setMuted(next);
    if (!next) {
      await speak('Voice on');
    }
  }
}
