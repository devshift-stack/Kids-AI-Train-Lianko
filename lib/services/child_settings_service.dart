import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Einstellungen für ein Kind - werden vom Parent Dashboard gesteuert
class ChildSettings {
  final bool subtitlesEnabled;      // Untertitel an/aus (default: aus)
  final String language;            // Sprache (default: bs)
  final double speechRate;          // Sprechgeschwindigkeit (0.3-0.6)
  final bool autoRepeat;            // Automatisch wiederholen bei Fehler
  final int maxAttempts;            // Max. Versuche pro Wort

  const ChildSettings({
    this.subtitlesEnabled = false,  // Standard: AUS
    this.language = 'bs',
    this.speechRate = 0.4,
    this.autoRepeat = true,
    this.maxAttempts = 3,
  });

  ChildSettings copyWith({
    bool? subtitlesEnabled,
    String? language,
    double? speechRate,
    bool? autoRepeat,
    int? maxAttempts,
  }) {
    return ChildSettings(
      subtitlesEnabled: subtitlesEnabled ?? this.subtitlesEnabled,
      language: language ?? this.language,
      speechRate: speechRate ?? this.speechRate,
      autoRepeat: autoRepeat ?? this.autoRepeat,
      maxAttempts: maxAttempts ?? this.maxAttempts,
    );
  }

  Map<String, dynamic> toJson() => {
    'subtitlesEnabled': subtitlesEnabled,
    'language': language,
    'speechRate': speechRate,
    'autoRepeat': autoRepeat,
    'maxAttempts': maxAttempts,
  };

  factory ChildSettings.fromJson(Map<String, dynamic> json) {
    return ChildSettings(
      subtitlesEnabled: json['subtitlesEnabled'] ?? false,
      language: json['language'] ?? 'bs',
      speechRate: (json['speechRate'] ?? 0.4).toDouble(),
      autoRepeat: json['autoRepeat'] ?? true,
      maxAttempts: json['maxAttempts'] ?? 3,
    );
  }
}

/// Service zum Laden/Speichern der Kind-Einstellungen
/// Diese werden vom Parent Dashboard über Firebase/SharedPreferences synchronisiert
class ChildSettingsService {
  static const _keyPrefix = 'lianko_child_';

  /// Lädt Einstellungen für ein Kind
  Future<ChildSettings> loadSettings(String childId) async {
    final prefs = await SharedPreferences.getInstance();

    return ChildSettings(
      subtitlesEnabled: prefs.getBool('${_keyPrefix}${childId}_subtitles') ?? false,
      language: prefs.getString('${_keyPrefix}${childId}_language') ?? 'bs',
      speechRate: prefs.getDouble('${_keyPrefix}${childId}_speechRate') ?? 0.4,
      autoRepeat: prefs.getBool('${_keyPrefix}${childId}_autoRepeat') ?? true,
      maxAttempts: prefs.getInt('${_keyPrefix}${childId}_maxAttempts') ?? 3,
    );
  }

  /// Speichert Einstellungen für ein Kind (wird vom Parent Dashboard aufgerufen)
  Future<void> saveSettings(String childId, ChildSettings settings) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('${_keyPrefix}${childId}_subtitles', settings.subtitlesEnabled);
    await prefs.setString('${_keyPrefix}${childId}_language', settings.language);
    await prefs.setDouble('${_keyPrefix}${childId}_speechRate', settings.speechRate);
    await prefs.setBool('${_keyPrefix}${childId}_autoRepeat', settings.autoRepeat);
    await prefs.setInt('${_keyPrefix}${childId}_maxAttempts', settings.maxAttempts);
  }

  /// Setzt nur Untertitel an/aus
  Future<void> setSubtitles(String childId, bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${_keyPrefix}${childId}_subtitles', enabled);
  }

  /// Setzt nur Sprache
  Future<void> setLanguage(String childId, String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('${_keyPrefix}${childId}_language', language);
  }
}

// Providers
final childSettingsServiceProvider = Provider<ChildSettingsService>((ref) {
  return ChildSettingsService();
});

/// Provider für aktuelle Kind-Einstellungen
/// childId muss übergeben werden
final childSettingsProvider = FutureProvider.family<ChildSettings, String>((ref, childId) async {
  final service = ref.watch(childSettingsServiceProvider);
  return service.loadSettings(childId);
});

/// Globale Einstellungen (ohne childId, für einfache Fälle)
final currentChildSettingsProvider = StateProvider<ChildSettings>((ref) {
  return const ChildSettings(); // Default: Untertitel AUS
});
