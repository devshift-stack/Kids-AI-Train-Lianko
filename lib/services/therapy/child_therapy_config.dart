import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/audiogram/audiogram_model.dart';

/// =================================================================
/// KONFIGURATION FÜR 4-JÄHRIGEN JUNGEN MIT SCHWEREM HÖRVERLUST
/// =================================================================
/// 
/// Medizinische Daten:
/// - Alter: 4 Jahre
/// - Linkes Ohr: ~60% Hörverlust (55-65 dB)
/// - Rechtes Ohr: ~70% Hörverlust (70-80 dB)
/// - Hörgeräte: Ja, bilateral
/// - Sprachstand: Wenige Wörter
/// - Sprache: Bosnisch (bs-BA)
/// =================================================================

class ChildTherapyConfig {
  /// Name des Kindes (wird bei Onboarding gesetzt)
  final String childName;
  
  /// Alter in Jahren
  final int age;
  
  /// Audiogramm-Daten
  final AudiogramData audiogram;
  
  /// Sprache
  final String languageCode;
  
  /// Trägt Hörgeräte
  final bool hasHearingAids;
  
  /// Aktuelles Therapie-Level (1-5)
  final int therapyLevel;
  
  /// Tägliches Zeitlimit in Minuten
  final int dailyTimeLimitMinutes;
  
  /// Eltern-Aufnahmen aktiviert
  final bool parentRecordingsEnabled;

  const ChildTherapyConfig({
    required this.childName,
    required this.age,
    required this.audiogram,
    this.languageCode = 'bs-BA',
    this.hasHearingAids = true,
    this.therapyLevel = 1,
    this.dailyTimeLimitMinutes = 15,
    this.parentRecordingsEnabled = true,
  });

  /// Standard-Konfiguration für das Kind
  factory ChildTherapyConfig.defaultForChild() {
    return ChildTherapyConfig(
      childName: 'Dijete', // Wird bei Onboarding überschrieben
      age: 4,
      audiogram: AudiogramData(
        leftEar: EarAudiogram(values: {
          250: 50,   // Tiefe Töne noch am besten
          500: 55,
          1000: 60,
          2000: 65,
          4000: 70,
          8000: 75,  // Hohe Töne am schlechtesten (Hochtonverlust)
        }),
        rightEar: EarAudiogram(values: {
          250: 60,
          500: 65,
          1000: 70,
          2000: 75,
          4000: 80,
          8000: 85,
        }),
        measuredAt: DateTime.now(),
        confirmedByParent: true,
        notes: 'Schwerer asymmetrischer Hörverlust mit Hochtonabfall',
      ),
    );
  }

  /// Kopie mit Änderungen
  ChildTherapyConfig copyWith({
    String? childName,
    int? age,
    AudiogramData? audiogram,
    String? languageCode,
    bool? hasHearingAids,
    int? therapyLevel,
    int? dailyTimeLimitMinutes,
    bool? parentRecordingsEnabled,
  }) {
    return ChildTherapyConfig(
      childName: childName ?? this.childName,
      age: age ?? this.age,
      audiogram: audiogram ?? this.audiogram,
      languageCode: languageCode ?? this.languageCode,
      hasHearingAids: hasHearingAids ?? this.hasHearingAids,
      therapyLevel: therapyLevel ?? this.therapyLevel,
      dailyTimeLimitMinutes: dailyTimeLimitMinutes ?? this.dailyTimeLimitMinutes,
      parentRecordingsEnabled: parentRecordingsEnabled ?? this.parentRecordingsEnabled,
    );
  }
}

/// =================================================================
/// THERAPIE-EINSTELLUNGEN BASIEREND AUF AUDIOGRAMM
/// =================================================================

class TherapySettings {
  /// Sprechgeschwindigkeit (0.1 - 1.0, Standard: 0.5)
  final double speechRate;
  
  /// Stimmhöhe (0.5 - 2.0, Standard: 1.0)
  final double pitch;
  
  /// Lautstärke (0.0 - 1.0)
  final double volume;
  
  /// Untertitel immer anzeigen
  final bool subtitlesAlwaysOn;
  
  /// Größere Animationen
  final bool enlargedAnimations;
  
  /// Text-Skalierung (1.0 - 2.0)
  final double textScale;
  
  /// Haptic Feedback aktivieren
  final bool hapticFeedback;
  
  /// Anzahl Wiederholungen pro Wort
  final int repeatCount;
  
  /// Pause zwischen Wörtern (ms)
  final int pauseBetweenWordsMs;
  
  /// Wartezeit für Antwort (Sekunden)
  final int responseTimeoutSeconds;
  
  /// Silben einzeln aussprechen
  final bool speakSyllablesSeparately;

  const TherapySettings({
    required this.speechRate,
    required this.pitch,
    required this.volume,
    required this.subtitlesAlwaysOn,
    required this.enlargedAnimations,
    required this.textScale,
    required this.hapticFeedback,
    required this.repeatCount,
    required this.pauseBetweenWordsMs,
    required this.responseTimeoutSeconds,
    required this.speakSyllablesSeparately,
  });

  /// Berechnet optimale Einstellungen aus Audiogramm
  factory TherapySettings.fromAudiogram(AudiogramData audiogram, int age) {
    final level = audiogram.hearingLossLevel;
    final hasHighFreqLoss = audiogram.hasHighFrequencyLoss;
    
    // Je schwerer der Hörverlust, desto langsamer und tiefer
    double speechRate;
    double pitch;
    int repeatCount;
    int pauseMs;
    int timeout;
    
    switch (level) {
      case HearingLossLevel.normal:
        speechRate = 0.5;
        pitch = 1.0;
        repeatCount = 1;
        pauseMs = 300;
        timeout = 5;
        break;
        
      case HearingLossLevel.mild:
        speechRate = 0.45;
        pitch = hasHighFreqLoss ? 0.9 : 1.0;
        repeatCount = 2;
        pauseMs = 500;
        timeout = 6;
        break;
        
      case HearingLossLevel.moderate:
        speechRate = 0.4;
        pitch = hasHighFreqLoss ? 0.85 : 0.95;
        repeatCount = 2;
        pauseMs = 700;
        timeout = 8;
        break;
        
      case HearingLossLevel.severe:
        // ← Das Kind fällt hier rein
        speechRate = 0.3;
        pitch = hasHighFreqLoss ? 0.75 : 0.85;
        repeatCount = 3;
        pauseMs = 1000;
        timeout = 10;
        break;
        
      case HearingLossLevel.profound:
        speechRate = 0.25;
        pitch = 0.7;
        repeatCount = 3;
        pauseMs = 1200;
        timeout = 12;
        break;
    }
    
    // Altersanpassung: Jüngere Kinder brauchen mehr Zeit
    if (age <= 4) {
      speechRate *= 0.9; // 10% langsamer
      pauseMs = (pauseMs * 1.3).round();
      timeout += 2;
    }
    
    return TherapySettings(
      speechRate: speechRate,
      pitch: pitch,
      volume: 1.0, // Immer maximale Lautstärke
      subtitlesAlwaysOn: level.index >= HearingLossLevel.moderate.index,
      enlargedAnimations: level.index >= HearingLossLevel.moderate.index,
      textScale: level.index >= HearingLossLevel.severe.index ? 1.3 : 1.1,
      hapticFeedback: true, // Immer an für zusätzlichen Kanal
      repeatCount: repeatCount,
      pauseBetweenWordsMs: pauseMs,
      responseTimeoutSeconds: timeout,
      speakSyllablesSeparately: level.index >= HearingLossLevel.moderate.index,
    );
  }

  /// Standard für schweren Hörverlust (4-Jähriger)
  factory TherapySettings.defaultForSevereHearingLoss() {
    return const TherapySettings(
      speechRate: 0.27,         // Sehr langsam
      pitch: 0.75,              // Tiefer (Hochtonverlust)
      volume: 1.0,              // Maximum
      subtitlesAlwaysOn: true,  // Immer Untertitel
      enlargedAnimations: true, // Große Animationen
      textScale: 1.3,           // Größerer Text
      hapticFeedback: true,     // Vibration
      repeatCount: 3,           // 3x wiederholen
      pauseBetweenWordsMs: 1000,// 1 Sekunde Pause
      responseTimeoutSeconds: 12,// 12 Sekunden warten
      speakSyllablesSeparately: true, // Silben einzeln
    );
  }
}

/// =================================================================
/// RIVERPOD PROVIDERS
/// =================================================================

/// Child Therapy Config Provider
final childTherapyConfigProvider = StateProvider<ChildTherapyConfig>((ref) {
  return ChildTherapyConfig.defaultForChild();
});

/// Therapy Settings Provider (berechnet aus Config)
final therapySettingsProvider = Provider<TherapySettings>((ref) {
  final config = ref.watch(childTherapyConfigProvider);
  return TherapySettings.fromAudiogram(config.audiogram, config.age);
});

/// Ist Hörverlust schwer?
final isSevereHearingLossProvider = Provider<bool>((ref) {
  final config = ref.watch(childTherapyConfigProvider);
  final level = config.audiogram.hearingLossLevel;
  return level == HearingLossLevel.severe || level == HearingLossLevel.profound;
});

/// =================================================================
/// EXTENSIONS FÜR THERAPIE
/// =================================================================

extension TherapyAudiogramExtension on AudiogramData {
  
  /// Empfohlene Frequenzen für Training
  /// Bei Hochtonverlust: Fokus auf tiefe Töne
  List<int> get recommendedTrainingFrequencies {
    if (hasHighFrequencyLoss) {
      // Fokus auf tiefe Frequenzen, die besser gehört werden
      return [250, 500, 1000];
    }
    return [500, 1000, 2000];
  }
  
  /// Beschreibung für Eltern
  String get parentDescription {
    final level = hearingLossLevel;
    final leftPta = leftEar.pta.round();
    final rightPta = rightEar.pta.round();
    
    String levelDesc;
    switch (level) {
      case HearingLossLevel.normal:
        levelDesc = 'normalno';
        break;
      case HearingLossLevel.mild:
        levelDesc = 'blagi gubitak sluha';
        break;
      case HearingLossLevel.moderate:
        levelDesc = 'umjereni gubitak sluha';
        break;
      case HearingLossLevel.severe:
        levelDesc = 'težak gubitak sluha';
        break;
      case HearingLossLevel.profound:
        levelDesc = 'jako težak gubitak sluha';
        break;
    }
    
    return 'Lijevo uho: $leftPta dB, Desno uho: $rightPta dB - $levelDesc';
  }
}

/// =================================================================
/// THERAPY SESSION TRACKING
/// =================================================================

class TherapySession {
  final DateTime startTime;
  final List<TherapyExercise> exercises;
  int totalStars;
  int wordsAttempted;
  int wordsCorrect;
  
  TherapySession({
    DateTime? startTime,
    List<TherapyExercise>? exercises,
    this.totalStars = 0,
    this.wordsAttempted = 0,
    this.wordsCorrect = 0,
  }) : startTime = startTime ?? DateTime.now(),
       exercises = exercises ?? [];
  
  /// Dauer der Session
  Duration get duration => DateTime.now().difference(startTime);
  
  /// Erfolgsrate
  double get successRate => 
      wordsAttempted > 0 ? wordsCorrect / wordsAttempted : 0;
  
  /// Session beenden
  TherapySessionResult end() {
    return TherapySessionResult(
      duration: duration,
      wordsAttempted: wordsAttempted,
      wordsCorrect: wordsCorrect,
      starsEarned: totalStars,
      exercises: exercises,
    );
  }
}

class TherapyExercise {
  final String wordId;
  final String word;
  final DateTime timestamp;
  final bool correct;
  final double? pronunciationScore;
  final int responseTimeMs;
  
  const TherapyExercise({
    required this.wordId,
    required this.word,
    required this.timestamp,
    required this.correct,
    this.pronunciationScore,
    required this.responseTimeMs,
  });
}

class TherapySessionResult {
  final Duration duration;
  final int wordsAttempted;
  final int wordsCorrect;
  final int starsEarned;
  final List<TherapyExercise> exercises;
  
  const TherapySessionResult({
    required this.duration,
    required this.wordsAttempted,
    required this.wordsCorrect,
    required this.starsEarned,
    required this.exercises,
  });
  
  /// Erfolgsrate als Prozent
  int get successRatePercent => 
      wordsAttempted > 0 ? ((wordsCorrect / wordsAttempted) * 100).round() : 0;
  
  /// Dauer in Minuten
  int get durationMinutes => duration.inMinutes;
}

/// Active Session Provider
final activeTherapySessionProvider = StateProvider<TherapySession?>((ref) => null);
