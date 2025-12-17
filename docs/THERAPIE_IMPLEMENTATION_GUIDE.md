# 🛠️ Implementierungs-Leitfaden: Therapie-App

**Stand:** Dezember 2025  
**Ziel:** Schrittweise Anleitung zur Integration der Therapie-Module

---

## 📁 Erstellte Dateien

### 1. Dokumentation
```
/docs/THERAPIE_APP_PLAN.md          # Kompletter Plan & Architektur
/docs/THERAPIE_IMPLEMENTATION_GUIDE.md  # Diese Datei
```

### 2. Models
```
/lib/models/therapy/therapy_vocabulary_bs.dart
├── TherapyWord           # Therapie-Wort mit Silben
├── TherapyPhrase         # 2-3 Wort-Sätze
├── TherapyCategory       # Kategorien (Porodica, Životinje, etc.)
├── TherapyVocabularyBS   # Alle bosnischen Wörter
├── AnimalSound           # Tiergeräusche für Hörtraining
├── SyllableTrainingBS    # Silben-Übungsdaten
└── TherapyFeedbackBS     # Feedback-Texte auf Bosnisch
```

### 3. Services
```
/lib/services/therapy/child_therapy_config.dart
├── ChildTherapyConfig    # Kind-Konfiguration (Audiogramm, Alter, etc.)
├── TherapySettings       # TTS-Einstellungen basierend auf Hörverlust
├── TherapySession        # Session-Tracking
└── Provider              # Riverpod Provider

/lib/services/therapy/speech_therapy_service.dart
├── SpeechTherapyService  # Hauptservice für Sprachtraining
├── TherapyState          # Zustände (showing, speaking, listening, etc.)
├── TherapyResult         # Übungsergebnis
└── Provider              # Stream Provider für UI
```

### 4. Screens
```
/lib/screens/therapy/therapy_home_screen.dart
├── TherapyHomeScreen     # Hauptbildschirm mit Kategorien
├── _CategoryCard         # Kategorie-Karte
├── _RewardsSheet         # Belohnungs-Übersicht
└── _StatCard             # Statistik-Widget

/lib/screens/therapy/speech_therapy_screen.dart
├── SpeechTherapyScreen   # Übungsbildschirm
├── _ControlButton        # Steuerungsbuttons
├── _MicrophoneButton     # Animierter Mikrofon-Button
└── _StatRow              # Statistik-Zeile
```

---

## 🔧 Integration in bestehende App

### Schritt 1: Navigation hinzufügen

In `/lib/screens/home/home_screen.dart` hinzufügen:

```dart
import '../therapy/therapy_home_screen.dart';

// In _getCategoriesForAge():
{
  'title': 'Terapija',
  'icon': Icons.medical_services,
  'color': const Color(0xFF4CAF50),
  'route': '/therapy',
},

// In _openCategory():
case '/therapy':
  screen = const TherapyHomeScreen();
  break;
```

### Schritt 2: Assets vorbereiten

Erstelle Ordnerstruktur für Bilder:

```
assets/
└── therapy/
    ├── porodica/
    │   ├── mama.png
    │   ├── papa.png
    │   ├── tata.png
    │   ├── baba.png
    │   ├── deda.png
    │   └── beba.png
    ├── osnovno/
    │   ├── da.png
    │   ├── ne.png
    │   ├── evo.png
    │   ├── daj.png
    │   ├── hocu.png
    │   ├── necu.png
    │   ├── molim.png
    │   └── hvala.png
    ├── zivotinje/
    │   ├── pas.png
    │   ├── maca.png
    │   ├── koka.png
    │   ├── ptica.png
    │   ├── riba.png
    │   ├── konj.png
    │   ├── krava.png
    │   ├── ovca.png
    │   ├── patka.png
    │   └── zeka.png
    ├── hrana/
    │   ├── voda.png
    │   ├── sok.png
    │   ├── hljeb.png
    │   ├── jabuka.png
    │   ├── banana.png
    │   ├── mlijeko.png
    │   ├── kolac.png
    │   └── jaje.png
    ├── tijelo/
    │   ├── ruka.png
    │   ├── noga.png
    │   ├── oko.png
    │   ├── uho.png
    │   ├── nos.png
    │   ├── usta.png
    │   ├── glava.png
    │   └── trbuh.png
    ├── boje/
    │   └── [Farbbilder]
    ├── igracke/
    │   └── [Spielzeugbilder]
    ├── brojevi/
    │   └── [1-5 Bilder]
    ├── fraze/
    │   └── [Satzbilder]
    └── sounds/
        ├── pas.mp3
        ├── macka.mp3
        ├── krava.mp3
        └── [weitere Tiergeräusche]
```

### Schritt 3: pubspec.yaml aktualisieren

```yaml
flutter:
  assets:
    - assets/therapy/
    - assets/therapy/porodica/
    - assets/therapy/osnovno/
    - assets/therapy/zivotinje/
    - assets/therapy/hrana/
    - assets/therapy/tijelo/
    - assets/therapy/boje/
    - assets/therapy/igracke/
    - assets/therapy/brojevi/
    - assets/therapy/fraze/
    - assets/therapy/sounds/
```

### Schritt 4: Kind-Profil konfigurieren

Beim Onboarding das Audiogramm setzen:

```dart
// Im Onboarding oder Eltern-Dashboard:
ref.read(childTherapyConfigProvider.notifier).state = 
    ChildTherapyConfig(
      childName: 'Ahmed',  // Name des Kindes
      age: 4,
      audiogram: AudiogramData(
        leftEar: EarAudiogram(values: {
          250: 50, 500: 55, 1000: 60, 2000: 65, 4000: 70, 8000: 75,
        }),
        rightEar: EarAudiogram(values: {
          250: 60, 500: 65, 1000: 70, 2000: 75, 4000: 80, 8000: 85,
        }),
        measuredAt: DateTime.now(),
        confirmedByParent: true,
      ),
    );
```

---

## 🎨 Empfohlene Bildstile

Für 4-jährige Kinder mit Hörverlust:

1. **Stil:** Cartoon, freundlich, bunt
2. **Hintergrund:** Einfarbig oder transparent
3. **Größe:** Mindestens 512x512 px
4. **Kontrast:** Hoch (wichtig für visuelle Unterstützung)
5. **Inhalt:** Eindeutig erkennbar, keine Ablenkungen

**Bildquellen (kostenlos):**
- Freepik Kids Illustrations
- Flaticon (Sticker-Style)
- OpenClipart
- KI-generiert (DALL-E, Midjourney)

---

## 🔊 Audio-Einstellungen

### TTS für schweren Hörverlust:

```dart
// Die App setzt automatisch:
speechRate: 0.27    // Sehr langsam
pitch: 0.75         // Tiefer (Hochtonverlust)
volume: 1.0         // Maximum
```

### Bluetooth/Hörgeräte-Kompatibilität:

```dart
// iOS - bereits konfiguriert in speech_therapy_service.dart:
await _tts.setIosAudioCategory(
  IosTextToSpeechAudioCategory.playback,
  [
    IosTextToSpeechAudioCategoryOptions.allowBluetooth,
    IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
  ],
  IosTextToSpeechAudioMode.voicePrompt,
);
```

---

## 🧪 Testen

### 1. TTS-Test
```dart
final service = ref.read(speechTherapyServiceProvider);
service.speak('Zdravo, ja sam Lianko!');
```

### 2. Vollständiger Übungstest
```dart
final word = TherapyVocabularyBS.porodica.words.first;
service.startExercise(word);
```

### 3. Audiogramm-Test
```dart
final settings = ref.read(therapySettingsProvider);
print('Speech Rate: ${settings.speechRate}');
print('Pitch: ${settings.pitch}');
print('Subtitles: ${settings.subtitlesAlwaysOn}');
```

---

## 📱 Nächste Schritte

1. **Assets erstellen:** Bilder für alle Wörter erstellen/beschaffen
2. **Testen mit Kind:** Erste Testläufe mit echtem Kind
3. **Whisper-Integration:** OpenAI Whisper für bessere Spracherkennung
4. **ElevenLabs:** Eltern-Stimme klonen für Motivation
5. **Eltern-Dashboard:** Fortschrittsberichte für Eltern

---

## 📞 Support

Bei Fragen zum Code oder zur Implementierung:
- GitHub Issues im Repository erstellen
- Dokumentation in `/docs/` lesen

---

**💙 Entwickelt für Kinder mit Hörbehinderung**

*"Svako dijete zaslužuje glas."*
