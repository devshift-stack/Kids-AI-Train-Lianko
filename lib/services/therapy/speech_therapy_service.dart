import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../models/therapy/therapy_vocabulary_bs.dart';
import 'child_therapy_config.dart';

/// =================================================================
/// SPEECH THERAPY SERVICE
/// =================================================================
/// 
/// Hauptservice für Logopädie-Training bei schwerhörigen Kindern.
/// 
/// Ablauf einer Übung:
/// 1. Wort/Bild anzeigen
/// 2. Lianko spricht vor (langsam, mehrfach)
/// 3. Kind bekommt Zeit zum Nachsprechen
/// 4. Aussprache wird analysiert
/// 5. Feedback + Belohnung
/// =================================================================

/// Zustände des Therapie-Trainings
enum TherapyState {
  idle,           // Bereit für nächste Übung
  showing,        // Bild wird gezeigt
  speaking,       // Lianko spricht
  waiting,        // Warte auf Kind
  listening,      // Kind spricht
  analyzing,      // Analyse läuft
  feedback,       // Feedback wird gegeben
  celebration,    // Feier bei Erfolg
}

/// Ergebnis einer Sprechübung
class TherapyResult {
  final TherapyWord word;
  final String spokenText;
  final double confidence;
  final double pronunciationScore; // 0-100
  final bool isCorrect;
  final String feedbackText;
  final int starsEarned;
  final int responseTimeMs;

  const TherapyResult({
    required this.word,
    required this.spokenText,
    required this.confidence,
    required this.pronunciationScore,
    required this.isCorrect,
    required this.feedbackText,
    required this.starsEarned,
    required this.responseTimeMs,
  });
}

/// Hauptservice für Sprachtherapie
class SpeechTherapyService {
  final FlutterTts _tts = FlutterTts();
  final SpeechToText _stt = SpeechToText();
  final Ref _ref;

  bool _isInitialized = false;
  bool _sttAvailable = false;
  TherapyState _state = TherapyState.idle;
  TherapyWord? _currentWord;
  DateTime? _exerciseStartTime;

  // Stream Controllers
  final _stateController = StreamController<TherapyState>.broadcast();
  final _currentWordController = StreamController<TherapyWord?>.broadcast();
  final _subtitleController = StreamController<String>.broadcast();
  final _currentSyllableController = StreamController<int>.broadcast();
  final _resultController = StreamController<TherapyResult>.broadcast();
  final _progressController = StreamController<double>.broadcast();

  // Streams
  Stream<TherapyState> get stateStream => _stateController.stream;
  Stream<TherapyWord?> get currentWordStream => _currentWordController.stream;
  Stream<String> get subtitleStream => _subtitleController.stream;
  Stream<int> get currentSyllableStream => _currentSyllableController.stream;
  Stream<TherapyResult> get resultStream => _resultController.stream;
  Stream<double> get progressStream => _progressController.stream;

  TherapyState get currentState => _state;
  TherapyWord? get currentWord => _currentWord;

  SpeechTherapyService(this._ref) {
    _initServices();
  }

  /// Initialisiert TTS und STT
  Future<void> _initServices() async {
    if (_isInitialized) return;

    try {
      await _initTts();
      await _initStt();
      _isInitialized = true;
      
      if (kDebugMode) {
        print('🎤 Speech Therapy Service initialisiert');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Speech Therapy Service Fehler: $e');
      }
    }
  }

  /// TTS für hörgeräteoptimierte Sprachausgabe
  Future<void> _initTts() async {
    final settings = _ref.read(therapySettingsProvider);
    
    // Bosnisch einstellen
    await _tts.setLanguage('bs-BA');
    
    // Therapie-optimierte Einstellungen
    await _tts.setSpeechRate(settings.speechRate);
    await _tts.setPitch(settings.pitch);
    await _tts.setVolume(settings.volume);

    if (Platform.isAndroid) {
      await _tts.setEngine('com.google.android.tts');
    }

    if (Platform.isIOS) {
      await _tts.setSharedInstance(true);
      await _tts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.playback,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
        ],
        IosTextToSpeechAudioMode.voicePrompt,
      );
    }

    // Callbacks
    _tts.setStartHandler(() {
      _updateState(TherapyState.speaking);
    });

    _tts.setCompletionHandler(() {
      if (_state == TherapyState.speaking) {
        _updateState(TherapyState.waiting);
      }
    });

    // Wort-für-Wort Progress für Untertitel
    _tts.setProgressHandler((text, start, end, word) {
      _subtitleController.add(word);
    });
  }

  /// STT für Spracherkennung
  Future<void> _initStt() async {
    _sttAvailable = await _stt.initialize(
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          if (_state == TherapyState.listening) {
            _updateState(TherapyState.analyzing);
          }
        }
      },
      onError: (error) {
        if (kDebugMode) {
          print('STT Error: $error');
        }
        _updateState(TherapyState.idle);
      },
    );

    if (kDebugMode) {
      print('STT verfügbar: $_sttAvailable');
    }
  }

  void _updateState(TherapyState newState) {
    _state = newState;
    _stateController.add(newState);
  }

  /// =================================================================
  /// HAUPTMETHODEN FÜR THERAPIE
  /// =================================================================

  /// Startet eine Übung mit einem Wort
  Future<void> startExercise(TherapyWord word) async {
    if (!_isInitialized) await _initServices();
    
    _currentWord = word;
    _currentWordController.add(word);
    _exerciseStartTime = DateTime.now();

    // Phase 1: Bild zeigen
    _updateState(TherapyState.showing);
    await Future.delayed(const Duration(milliseconds: 500));

    // Phase 2: Wort vorsprechen
    await _speakWord(word);

    // Phase 3: Warten auf Kind
    _updateState(TherapyState.waiting);
    await Future.delayed(const Duration(seconds: 2));

    // Phase 4: Zuhören
    await _listenForResponse(word);
  }

  /// Spricht ein Wort mit Therapie-Einstellungen
  Future<void> _speakWord(TherapyWord word) async {
    final settings = _ref.read(therapySettingsProvider);
    
    _subtitleController.add(word.word);
    _updateState(TherapyState.speaking);

    if (settings.speakSyllablesSeparately && word.syllables.length > 1) {
      // Silben einzeln sprechen
      for (int i = 0; i < word.syllables.length; i++) {
        _currentSyllableController.add(i);
        await _tts.speak(word.syllables[i]);
        await Future.delayed(Duration(milliseconds: settings.pauseBetweenWordsMs));
      }
      
      // Dann das ganze Wort
      await Future.delayed(const Duration(milliseconds: 500));
      await _tts.speak(word.word);
    } else {
      // Wort als Ganzes sprechen
      for (int i = 0; i < settings.repeatCount; i++) {
        await _tts.speak(word.word);
        if (i < settings.repeatCount - 1) {
          await Future.delayed(Duration(milliseconds: settings.pauseBetweenWordsMs));
        }
      }
    }
  }

  /// Hört auf die Aussprache des Kindes
  Future<void> _listenForResponse(TherapyWord word) async {
    if (!_sttAvailable) {
      _finishWithResult(_createErrorResult(word, 'Mikrofon nicht verfügbar'));
      return;
    }

    final settings = _ref.read(therapySettingsProvider);
    _updateState(TherapyState.listening);
    _subtitleController.add('🎤'); // Mikrofon-Symbol

    String recognizedText = '';
    double confidence = 0;

    await _stt.listen(
      onResult: (result) {
        recognizedText = result.recognizedWords;
        confidence = result.confidence;
        _subtitleController.add(recognizedText);
      },
      listenFor: Duration(seconds: settings.responseTimeoutSeconds),
      pauseFor: const Duration(seconds: 3),
      localeId: 'bs-BA',
      listenMode: ListenMode.dictation,
    );

    // Warten bis Timeout oder Ergebnis
    await Future.delayed(Duration(seconds: settings.responseTimeoutSeconds + 2));

    // Auswertung
    _updateState(TherapyState.analyzing);
    final result = _evaluateSpeech(word, recognizedText, confidence);
    _finishWithResult(result);
  }

  /// Wertet die Aussprache aus
  TherapyResult _evaluateSpeech(TherapyWord word, String spoken, double confidence) {
    final responseTime = _exerciseStartTime != null
        ? DateTime.now().difference(_exerciseStartTime!).inMilliseconds
        : 5000;

    final targetLower = word.word.toLowerCase().trim();
    final spokenLower = spoken.toLowerCase().trim();

    // Berechne Ähnlichkeit
    double similarity = 0;
    bool isCorrect = false;
    int stars = 0;
    String feedback;

    if (spokenLower.isEmpty) {
      // Nichts erkannt
      similarity = 0;
      isCorrect = false;
      stars = 1; // Trost-Stern fürs Versuchen
      feedback = TherapyFeedbackBS.encouragement[
          DateTime.now().millisecond % TherapyFeedbackBS.encouragement.length
      ];
    } else if (targetLower == spokenLower) {
      // Exakt richtig
      similarity = 1.0;
      isCorrect = true;
      stars = 3;
      feedback = TherapyFeedbackBS.correct[
          DateTime.now().millisecond % TherapyFeedbackBS.correct.length
      ];
    } else {
      similarity = _calculateSimilarity(targetLower, spokenLower);
      
      if (similarity >= 0.8) {
        // Fast perfekt
        isCorrect = true;
        stars = 2;
        feedback = TherapyFeedbackBS.almostCorrect[
            DateTime.now().millisecond % TherapyFeedbackBS.almostCorrect.length
        ];
      } else if (similarity >= 0.5) {
        // Erkennbar, aber nicht richtig
        isCorrect = false;
        stars = 1;
        feedback = TherapyFeedbackBS.tryAgain[
            DateTime.now().millisecond % TherapyFeedbackBS.tryAgain.length
        ];
      } else {
        // Kaum ähnlich
        isCorrect = false;
        stars = 1;
        feedback = TherapyFeedbackBS.encouragement[
            DateTime.now().millisecond % TherapyFeedbackBS.encouragement.length
        ];
      }
    }

    return TherapyResult(
      word: word,
      spokenText: spoken,
      confidence: confidence,
      pronunciationScore: similarity * 100,
      isCorrect: isCorrect,
      feedbackText: feedback,
      starsEarned: stars,
      responseTimeMs: responseTime,
    );
  }

  /// Berechnet Ähnlichkeit zwischen zwei Strings
  double _calculateSimilarity(String s1, String s2) {
    if (s1.isEmpty || s2.isEmpty) return 0;
    if (s1 == s2) return 1;

    final maxLen = s1.length > s2.length ? s1.length : s2.length;
    final distance = _levenshteinDistance(s1, s2);
    return 1 - (distance / maxLen);
  }

  int _levenshteinDistance(String s1, String s2) {
    final m = s1.length;
    final n = s2.length;
    final dp = List.generate(m + 1, (_) => List.filled(n + 1, 0));

    for (var i = 0; i <= m; i++) dp[i][0] = i;
    for (var j = 0; j <= n; j++) dp[0][j] = j;

    for (var i = 1; i <= m; i++) {
      for (var j = 1; j <= n; j++) {
        final cost = s1[i - 1] == s2[j - 1] ? 0 : 1;
        dp[i][j] = [
          dp[i - 1][j] + 1,
          dp[i][j - 1] + 1,
          dp[i - 1][j - 1] + cost,
        ].reduce((a, b) => a < b ? a : b);
      }
    }

    return dp[m][n];
  }

  /// Beendet Übung mit Ergebnis
  Future<void> _finishWithResult(TherapyResult result) async {
    // Feedback geben
    _updateState(TherapyState.feedback);
    await _tts.speak(result.feedbackText);
    await Future.delayed(const Duration(milliseconds: 500));

    // Bei Erfolg: Feier
    if (result.isCorrect) {
      _updateState(TherapyState.celebration);
      await Future.delayed(const Duration(seconds: 2));
    }

    // Ergebnis senden
    _resultController.add(result);

    // Session aktualisieren
    _updateSession(result);

    _updateState(TherapyState.idle);
    _currentWord = null;
    _currentWordController.add(null);
  }

  TherapyResult _createErrorResult(TherapyWord word, String error) {
    return TherapyResult(
      word: word,
      spokenText: '',
      confidence: 0,
      pronunciationScore: 0,
      isCorrect: false,
      feedbackText: error,
      starsEarned: 0,
      responseTimeMs: 0,
    );
  }

  void _updateSession(TherapyResult result) {
    final session = _ref.read(activeTherapySessionProvider);
    if (session != null) {
      session.wordsAttempted++;
      if (result.isCorrect) {
        session.wordsCorrect++;
      }
      session.totalStars += result.starsEarned;
      
      session.exercises.add(TherapyExercise(
        wordId: result.word.word,
        word: result.word.word,
        timestamp: DateTime.now(),
        correct: result.isCorrect,
        pronunciationScore: result.pronunciationScore,
        responseTimeMs: result.responseTimeMs,
      ));
    }
  }

  /// =================================================================
  /// HILFSMETHODEN
  /// =================================================================

  /// Wiederholt das aktuelle Wort
  Future<void> repeatCurrentWord() async {
    if (_currentWord != null) {
      await _speakWord(_currentWord!);
    }
  }

  /// Spricht eine einzelne Silbe
  Future<void> speakSyllable(String syllable, int index) async {
    _currentSyllableController.add(index);
    await _tts.speak(syllable);
  }

  /// Spricht beliebigen Text
  Future<void> speak(String text) async {
    await _tts.speak(text);
  }

  /// Stoppt alle Audio-Aktivitäten
  Future<void> stop() async {
    await _tts.stop();
    await _stt.stop();
    _updateState(TherapyState.idle);
  }

  /// Gibt Ressourcen frei
  void dispose() {
    _stateController.close();
    _currentWordController.close();
    _subtitleController.close();
    _currentSyllableController.close();
    _resultController.close();
    _progressController.close();
    _tts.stop();
    _stt.stop();
  }
}

/// =================================================================
/// RIVERPOD PROVIDERS
/// =================================================================

/// Speech Therapy Service Provider
final speechTherapyServiceProvider = Provider<SpeechTherapyService>((ref) {
  final service = SpeechTherapyService(ref);
  ref.onDispose(() => service.dispose());
  return service;
});

/// Therapy State Stream
final therapyStateProvider = StreamProvider<TherapyState>((ref) {
  final service = ref.watch(speechTherapyServiceProvider);
  return service.stateStream;
});

/// Current Word Stream
final currentTherapyWordProvider = StreamProvider<TherapyWord?>((ref) {
  final service = ref.watch(speechTherapyServiceProvider);
  return service.currentWordStream;
});

/// Subtitle Stream
final therapySubtitleProvider = StreamProvider<String>((ref) {
  final service = ref.watch(speechTherapyServiceProvider);
  return service.subtitleStream;
});

/// Current Syllable Index Stream
final currentSyllableIndexProvider = StreamProvider<int>((ref) {
  final service = ref.watch(speechTherapyServiceProvider);
  return service.currentSyllableStream;
});

/// Therapy Result Stream
final therapyResultProvider = StreamProvider<TherapyResult>((ref) {
  final service = ref.watch(speechTherapyServiceProvider);
  return service.resultStream;
});
