import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Analytics Service für Lianko
///
/// Trackt:
/// - Screen Views (welche Seiten besucht)
/// - Game Events (Spiele gestartet, beendet, Score)
/// - Learning Events (Wörter gelernt, Schwierigkeiten)
/// - Hearing Aid Events (Check bestanden/nicht bestanden)
/// - User Properties (Alter, Sprache, Hörverlust-Level)
class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // ============================================================
  // INITIALISIERUNG
  // ============================================================

  /// Initialisiert Analytics + Crashlytics
  Future<void> initialize() async {
    // Analytics aktivieren
    await _analytics.setAnalyticsCollectionEnabled(!kDebugMode);

    // Crashlytics aktivieren
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);

    // Flutter Errors an Crashlytics senden
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    // Async Errors
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    if (kDebugMode) {
      print('📊 Analytics Service initialisiert (Debug-Mode: Events deaktiviert)');
    }
  }

  // ============================================================
  // USER PROPERTIES
  // ============================================================

  /// Setzt User Properties für Segmentierung
  Future<void> setUserProperties({
    required String childId,
    required int age,
    required String language,
    String? hearingLossLevel,
  }) async {
    await _analytics.setUserId(id: childId);
    await _analytics.setUserProperty(name: 'age_group', value: _getAgeGroup(age));
    await _analytics.setUserProperty(name: 'language', value: language);
    if (hearingLossLevel != null) {
      await _analytics.setUserProperty(name: 'hearing_loss_level', value: hearingLossLevel);
    }

    // Auch für Crashlytics
    FirebaseCrashlytics.instance.setUserIdentifier(childId);
    FirebaseCrashlytics.instance.setCustomKey('age', age);
    FirebaseCrashlytics.instance.setCustomKey('language', language);
  }

  String _getAgeGroup(int age) {
    if (age <= 4) return '3-4';
    if (age <= 6) return '5-6';
    if (age <= 8) return '7-8';
    if (age <= 10) return '9-10';
    return '11-12';
  }

  // ============================================================
  // SCREEN TRACKING
  // ============================================================

  /// Trackt Screen-Ansichten
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClass ?? screenName,
    );
  }

  // ============================================================
  // GAME EVENTS
  // ============================================================

  /// Spiel gestartet
  Future<void> logGameStart({
    required String gameId,
    required String gameName,
    int? level,
  }) async {
    await _analytics.logEvent(
      name: 'game_start',
      parameters: {
        'game_id': gameId,
        'game_name': gameName,
        'level': level ?? 1,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Spiel beendet
  Future<void> logGameComplete({
    required String gameId,
    required String gameName,
    required int score,
    required int maxScore,
    required Duration duration,
    int? level,
  }) async {
    await _analytics.logEvent(
      name: 'game_complete',
      parameters: {
        'game_id': gameId,
        'game_name': gameName,
        'score': score,
        'max_score': maxScore,
        'success_rate': (score / maxScore * 100).round(),
        'duration_seconds': duration.inSeconds,
        'level': level ?? 1,
      },
    );
  }

  /// Level abgeschlossen
  Future<void> logLevelUp({
    required String gameId,
    required int newLevel,
  }) async {
    await _analytics.logLevelUp(
      level: newLevel,
      character: gameId,
    );
  }

  // ============================================================
  // LEARNING EVENTS
  // ============================================================

  /// Wort gelernt/geübt
  Future<void> logWordPractice({
    required String word,
    required String category,
    required bool success,
    required int attempts,
  }) async {
    await _analytics.logEvent(
      name: 'word_practice',
      parameters: {
        'word': word,
        'category': category,
        'success': success ? 1 : 0,
        'attempts': attempts,
      },
    );
  }

  /// Lern-Schwierigkeit
  Future<void> logLearningDifficulty({
    required String word,
    required String category,
    required int attempts,
  }) async {
    await _analytics.logEvent(
      name: 'learning_difficulty',
      parameters: {
        'word': word,
        'category': category,
        'attempts': attempts,
      },
    );
  }

  /// Übung abgeschlossen
  Future<void> logExerciseComplete({
    required String exerciseType,
    required int correctCount,
    required int totalCount,
    required Duration duration,
  }) async {
    await _analytics.logEvent(
      name: 'exercise_complete',
      parameters: {
        'exercise_type': exerciseType,
        'correct_count': correctCount,
        'total_count': totalCount,
        'success_rate': (correctCount / totalCount * 100).round(),
        'duration_seconds': duration.inSeconds,
      },
    );
  }

  // ============================================================
  // HEARING AID EVENTS (LIANKO-SPEZIFISCH)
  // ============================================================

  /// Hörgeräte-Check durchgeführt
  Future<void> logHearingAidCheck({
    required bool detected,
    required String context,
    double? confidence,
  }) async {
    await _analytics.logEvent(
      name: 'hearing_aid_check',
      parameters: {
        'detected': detected ? 1 : 0,
        'context': context,
        'confidence': confidence ?? 0,
      },
    );
  }

  /// Audiogramm hochgeladen
  Future<void> logAudiogramUpload({
    required String method, // 'photo' oder 'manual'
    required String hearingLossLevel,
    double? geminiConfidence,
  }) async {
    await _analytics.logEvent(
      name: 'audiogram_upload',
      parameters: {
        'method': method,
        'hearing_loss_level': hearingLossLevel,
        'gemini_confidence': geminiConfidence ?? 0,
      },
    );
  }

  // ============================================================
  // SESSION EVENTS
  // ============================================================

  /// App-Session gestartet
  Future<void> logSessionStart() async {
    await _analytics.logEvent(
      name: 'session_start',
      parameters: {
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// App-Session beendet
  Future<void> logSessionEnd({
    required Duration duration,
    required int gamesPlayed,
    required int wordsLearned,
  }) async {
    await _analytics.logEvent(
      name: 'session_end',
      parameters: {
        'duration_minutes': duration.inMinutes,
        'games_played': gamesPlayed,
        'words_learned': wordsLearned,
      },
    );
  }

  // ============================================================
  // ENGAGEMENT EVENTS
  // ============================================================

  /// Feature genutzt
  Future<void> logFeatureUsed({
    required String featureName,
    Map<String, dynamic>? parameters,
  }) async {
    await _analytics.logEvent(
      name: 'feature_used',
      parameters: {
        'feature_name': featureName,
        ...?parameters,
      },
    );
  }

  /// Button geklickt
  Future<void> logButtonClick({
    required String buttonName,
    required String screen,
  }) async {
    await _analytics.logEvent(
      name: 'button_click',
      parameters: {
        'button_name': buttonName,
        'screen': screen,
      },
    );
  }

  // ============================================================
  // ERROR LOGGING
  // ============================================================

  /// Fehler loggen (nicht-fatal)
  Future<void> logError({
    required String error,
    required String context,
    StackTrace? stackTrace,
  }) async {
    await FirebaseCrashlytics.instance.recordError(
      Exception(error),
      stackTrace,
      reason: context,
      fatal: false,
    );
  }

  /// Custom Log für Debugging
  void log(String message) {
    FirebaseCrashlytics.instance.log(message);
  }
}

// ============================================================
// RIVERPOD PROVIDERS
// ============================================================

/// Analytics Service Provider
final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  return AnalyticsService();
});

/// Navigator Observer für automatisches Screen-Tracking
class AnalyticsNavigatorObserver extends NavigatorObserver {
  final AnalyticsService analytics;

  AnalyticsNavigatorObserver(this.analytics);

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name != null) {
      analytics.logScreenView(screenName: route.settings.name!);
    }
  }
}

/// Navigator Observer Provider
final analyticsObserverProvider = Provider<AnalyticsNavigatorObserver>((ref) {
  final analytics = ref.watch(analyticsServiceProvider);
  return AnalyticsNavigatorObserver(analytics);
});
