# 🎯 Lianko Therapie App - Kompletter Plan & Dokumentation

**Version:** 1.0  
**Zielgruppe:** 4-jähriger Junge mit schwerem Hörverlust  
**Sprache:** Bosnisch (bs-BA)  
**Letzte Aktualisierung:** Dezember 2025

---

## 📋 Inhaltsverzeichnis

1. [Projekt-Übersicht](#1-projekt-übersicht)
2. [Medizinisches Profil](#2-medizinisches-profil)
3. [Therapie-Ziele](#3-therapie-ziele)
4. [Technologie-Stack](#4-technologie-stack)
5. [App-Module](#5-app-module)
6. [Gamification-Konzept](#6-gamification-konzept)
7. [Entwicklungsplan](#7-entwicklungsplan)
8. [API-Integrationen](#8-api-integrationen)
9. [Sicherheit & Datenschutz](#9-sicherheit--datenschutz)
10. [Roadmap](#10-roadmap)

---

## 1. Projekt-Übersicht

### 1.1 Vision
Eine AI-gestützte Therapie-App, die als **virtueller Logopäde und Audiologe** fungiert. Die App soll dem Kind spielerisch helfen, Sprache zu entwickeln und sein Hören optimal zu nutzen - so motivierend, dass er **jeden Tag** damit arbeiten will.

### 1.2 Kernfunktionen

| Funktion | Beschreibung |
|----------|--------------|
| **Sprachtraining** | Kind hört → spricht nach → bekommt Feedback |
| **Hörtraining** | Geräusche erkennen, Richtungshören, Tonhöhen unterscheiden |
| **Audiogramm-Adaption** | App passt sich automatisch an Hörverlust an |
| **Familien-Stimme** | Eltern können Wörter aufnehmen (vertraute Stimme) |
| **Fortschrittstracking** | Eltern sehen tägliche Fortschritte |
| **Belohnungssystem** | Sterne, Sticker, Abzeichen motivieren |

### 1.3 Warum diese App?

```
┌─────────────────────────────────────────────────────────────────┐
│  TRADITIONELLE THERAPIE          LIANKO THERAPIE APP            │
├─────────────────────────────────────────────────────────────────┤
│  1-2x pro Woche                  Jeden Tag 10-15 Min            │
│  Teuer                           Einmalige Kosten               │
│  Keine Übung zuhause             Übung überall möglich          │
│  Kind hat Angst                  Kind liebt Alanko (Charakter)  │
│  Eltern wissen wenig             Eltern sehen alles             │
└─────────────────────────────────────────────────────────────────┘
```

---

## 2. Medizinisches Profil

### 2.1 Hörverlust-Analyse

```
AUDIOGRAMM-INTERPRETATION:

Linkes Ohr:  ~60% Hörverlust = ca. 55-65 dB = SCHWERER Hörverlust
Rechtes Ohr: ~70% Hörverlust = ca. 70-80 dB = SCHWERER bis HOCHGRADIGER Hörverlust

Nach WHO-Klassifikation:
├── 41-60 dB = Mittelgradiger Hörverlust
├── 61-80 dB = Schwerer Hörverlust ← HIER
└── >80 dB   = Hochgradiger Hörverlust
```

### 2.2 Konfiguration für das Kind

```dart
// Audiogramm-Daten für die App
final childAudiogram = AudiogramData(
  leftEar: EarAudiogram(values: {
    250: 50,   // Tiefe Töne noch am besten
    500: 55,
    1000: 60,
    2000: 65,
    4000: 70,
    8000: 75,  // Hohe Töne am schlechtesten
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
);

// Daraus berechnete Einstellungen:
// - Sprechgeschwindigkeit: 0.3 (sehr langsam)
// - Pitch: 0.75-0.85 (tiefer, weil Hochtonverlust)
// - Untertitel: IMMER an
// - Visuelle Unterstützung: MAXIMAL
```

### 2.3 App-Anpassungen basierend auf Profil

| Einstellung | Wert | Grund |
|-------------|------|-------|
| `speechRate` | 0.30 | Sehr langsam für besseres Verstehen |
| `pitch` | 0.75 | Tiefere Stimme (Hochtonverlust) |
| `subtitlesAlwaysOn` | true | Visuelle Unterstützung wichtig |
| `enlargedAnimations` | true | Größere, auffälligere Animationen |
| `textScale` | 1.3 | Größerer Text |
| `hapticFeedback` | true | Vibration als zusätzlicher Kanal |
| `repeatCount` | 3 | Jedes Wort 3x wiederholen |
| `pauseBetweenWords` | 1000ms | Lange Pausen |

---

## 3. Therapie-Ziele

### 3.1 Kurzfristige Ziele (0-3 Monate)

```
STUFE 1: GRUNDLAGEN
├── 🎯 10 Kernwörter sprechen können
│   ├── Mama, Papa, Da (Ja), Ne (Nein)
│   ├── Daj (Gib), Hoću (Ich will)
│   ├── Voda (Wasser), Hljeb (Brot)
│   ├── Auto, Lopta (Ball), Pas (Hund)
│
├── 🎯 Auf Namen reagieren
├── 🎯 Einfache Anweisungen verstehen
│   ├── "Dođi" (Komm)
│   ├── "Daj mi" (Gib mir)
│   └── "Pogledaj" (Schau)
│
└── 🎯 3 Tiergeräusche nachahmen
    ├── Vau-vau (Hund)
    ├── Mijau (Katze)
    └── Muuu (Kuh)
```

### 3.2 Mittelfristige Ziele (3-6 Monate)

```
STUFE 2: WORTSCHATZ-ERWEITERUNG
├── 🎯 50 Wörter aktiv sprechen
├── 🎯 2-Wort-Kombinationen
│   ├── "Mama daj" (Mama gib)
│   ├── "Hoću vodu" (Ich will Wasser)
│   └── "Još malo" (Noch ein bisschen)
│
├── 🎯 Farben benennen (5 Grundfarben)
├── 🎯 Zahlen 1-5 sprechen
└── 🎯 Körperteile zeigen und benennen
```

### 3.3 Langfristige Ziele (6-12 Monate)

```
STUFE 3: SÄTZE & KOMMUNIKATION
├── 🎯 100+ Wörter aktiv
├── 🎯 3-Wort-Sätze
├── 🎯 Einfache Fragen beantworten
├── 🎯 Kurze Geschichten verstehen
└── 🎯 Mit anderen Kindern kommunizieren
```

---

## 4. Technologie-Stack

### 4.1 Kernkomponenten

```
┌─────────────────────────────────────────────────────────────────┐
│                        LIANKO APP                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │   FLUTTER    │  │   GEMINI AI  │  │  WHISPER     │          │
│  │   Frontend   │  │   Chat/Quiz  │  │  Speech→Text │          │
│  └──────────────┘  └──────────────┘  └──────────────┘          │
│                                                                  │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │ ELEVENLABS   │  │  FIREBASE    │  │  SPEECHBRAIN │          │
│  │ Voice Clone  │  │  Backend     │  │  Adaptive AI │          │
│  └──────────────┘  └──────────────┘  └──────────────┘          │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 4.2 Technologie-Details

#### A) Flutter (Frontend)
- **Version:** 3.x
- **Packages:**
  - `flutter_tts` - Text-to-Speech
  - `speech_to_text` - Spracherkennung
  - `flutter_sound` - Audio-Aufnahme
  - `flutter_animate` - Animationen
  - `riverpod` - State Management

#### B) OpenAI Whisper (Spracherkennung)
```dart
// Integration via API oder lokal
class WhisperService {
  /// Analysiert Kinderaussprache
  Future<SpeechAnalysis> analyzeChildSpeech(Uint8List audioData) async {
    // 1. Audio zu Whisper senden
    // 2. Transkription erhalten
    // 3. Aussprache-Score berechnen
    // 4. Feedback generieren
  }
}

class SpeechAnalysis {
  final String transcription;      // Was das Kind sagte
  final double confidence;         // Wie sicher Whisper ist
  final double pronunciationScore; // 0-100 Aussprache-Qualität
  final List<String> issues;       // Z.B. ["S-Laut undeutlich"]
}
```

#### C) ElevenLabs (Personalisierte Stimme)
```dart
// Eltern-Stimme klonen für Motivation
class ElevenLabsService {
  /// Klont Stimme aus 1-5 Minuten Audio
  Future<String> cloneVoice({
    required String name,
    required List<Uint8List> audioSamples,
  }) async {
    // Voice ID zurückgeben
  }
  
  /// Generiert Audio mit geklonter Stimme
  Future<Uint8List> generateSpeech({
    required String text,
    required String voiceId,
    double stability = 0.5,
    double similarity = 0.75,
  }) async {
    // Audio-Bytes zurückgeben
  }
}
```

#### D) Google Gemini (AI-Chat & Quiz)
```dart
// Bereits implementiert in gemini_service.dart
// Anpassung für Therapie:
final therapyPrompt = '''
Du bist Lianko, ein liebevoller Therapie-Assistent für ein 4-jähriges
Kind mit schwerem Hörverlust. Du sprichst IMMER Bosnisch.

WICHTIGE REGELN:
- Benutze NUR sehr einfache Wörter
- Maximale Satzlänge: 3-4 Wörter
- Wiederhole wichtige Wörter oft
- Lobe IMMER, auch bei Fehlern
- Zeige Geduld und Liebe

BEISPIELE:
- "Bravo! Super!"
- "Hajmo opet! Ti to možeš!"
- "Mama te voli! Papa te voli!"
''';
```

### 4.3 Bestehende Services nutzen

Die App hat bereits folgende Services, die genutzt werden:

| Service | Datei | Funktion |
|---------|-------|----------|
| `SpeechTrainingService` | `speech_training_service.dart` | TTS + STT |
| `AIAudiogramReaderService` | `ai_audiogram_reader_service.dart` | Audiogramm aus Foto lesen |
| `AudiogramAdaptiveTTSService` | `audiogram_adaptive_tts_service.dart` | TTS an Hörverlust anpassen |
| `AdaptiveLearningService` | `adaptive_learning_service.dart` | Schwierigkeit anpassen |
| `RewardService` | `reward_service.dart` | Belohnungen verwalten |

---

## 5. App-Module

### 5.1 Modul-Übersicht

```
┌─────────────────────────────────────────────────────────────────┐
│                     LIANKO THERAPIE APP                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │ 🗣️ GOVOR   │  │ 👂 SLUH    │  │ 📚 RIJEČI   │              │
│  │ Sprechen   │  │ Hören      │  │ Wörter     │              │
│  └─────────────┘  └─────────────┘  └─────────────┘              │
│                                                                  │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │ 🎵 SLOGOVI │  │ 🎮 IGRE    │  │ 📖 PRIČE   │              │
│  │ Silben     │  │ Spiele     │  │ Geschichten│              │
│  └─────────────┘  └─────────────┘  └─────────────┘              │
│                                                                  │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐              │
│  │ 🏆 NAGRADE │  │ 👨‍👩‍👧 RODITELJI│  │ ⚙️ POSTAVKE │              │
│  │ Belohnungen│  │ Eltern     │  │ Einstellungen│             │
│  └─────────────┘  └─────────────┘  └─────────────┘              │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 5.2 Modul: Sprachtraining (Govor)

#### Ablauf einer Übung:

```
1. LIANKO ZEIGT BILD      → 🐕 (Hund)
         ↓
2. LIANKO SPRICHT         → "Pas" (langsam, 3x)
         ↓
3. KIND SIEHT UNTERTITEL  → "P-A-S" (große Buchstaben)
         ↓
4. MIKROFON AKTIVIERT     → 🎤 (mit Animation)
         ↓
5. KIND SPRICHT           → "Pas" (versucht)
         ↓
6. AI ANALYSIERT          → Whisper + Aussprache-Score
         ↓
7. FEEDBACK               → "Bravo!" oder "Hajmo opet!"
         ↓
8. BELOHNUNG              → ⭐ + Animation + Haptic
```

#### Code-Struktur:

```dart
// lib/screens/therapy/speech_therapy_screen.dart
class SpeechTherapyScreen extends ConsumerStatefulWidget {
  final TherapyLevel level;
  final List<TherapyWord> words;
  
  @override
  ConsumerState createState() => _SpeechTherapyScreenState();
}

class _SpeechTherapyScreenState extends ConsumerState<SpeechTherapyScreen> {
  int currentWordIndex = 0;
  TherapyState state = TherapyState.showing;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Fortschrittsbalken
            TherapyProgressBar(
              current: currentWordIndex,
              total: widget.words.length,
            ),
            
            // Hauptbereich
            Expanded(
              child: AnimatedSwitcher(
                child: _buildCurrentState(),
              ),
            ),
            
            // Untertitel (IMMER sichtbar)
            TherapySubtitle(
              word: widget.words[currentWordIndex],
              emphasized: state == TherapyState.speaking,
            ),
            
            // Mikrofon-Button
            if (state == TherapyState.listening)
              MicrophoneButton(
                onRecordingComplete: _analyzeRecording,
              ),
          ],
        ),
      ),
    );
  }
}
```

### 5.3 Modul: Hörtraining (Sluh)

#### Übungstypen:

```
A) GERÄUSCHE ERKENNEN
├── Tiergeräusche (Hund, Katze, Vogel...)
├── Haushaltsgeräusche (Telefon, Türklingel...)
└── Naturgeräusche (Regen, Wind, Donner...)

B) RICHTUNGSHÖREN
├── "Wo kommt der Ton her?" (Links/Rechts)
└── Wichtig für Hörgeräte-Training

C) TONHÖHEN UNTERSCHEIDEN
├── Hoch vs. Tief
├── Laut vs. Leise
└── Schnell vs. Langsam

D) WÖRTER UNTERSCHEIDEN
├── Ähnlich klingende Wörter
│   ├── "Pas" vs. "Bas"
│   ├── "Kuća" vs. "Kuca"
│   └── "Ruka" vs. "Muka"
└── Wichtig für Sprachverständnis
```

### 5.4 Modul: Wortschatz (Riječi)

#### Bosnische Therapie-Wörter:

```dart
// lib/data/therapy_vocabulary_bs.dart
class TherapyVocabularyBS {
  
  // STUFE 1: Erste 10 Wörter
  static const level1 = [
    TherapyWord(
      word: 'mama',
      syllables: ['ma', 'ma'],
      imageAsset: 'assets/therapy/mama.png',
      category: 'porodica',
      difficulty: 1,
      audioTips: 'Öffne den Mund weit für "a"',
    ),
    TherapyWord(
      word: 'papa',
      syllables: ['pa', 'pa'],
      imageAsset: 'assets/therapy/papa.png',
      category: 'porodica',
      difficulty: 1,
    ),
    TherapyWord(
      word: 'da',
      syllables: ['da'],
      imageAsset: 'assets/therapy/da.png',
      category: 'osnovno',
      difficulty: 1,
    ),
    TherapyWord(
      word: 'ne',
      syllables: ['ne'],
      imageAsset: 'assets/therapy/ne.png',
      category: 'osnovno',
      difficulty: 1,
    ),
    TherapyWord(
      word: 'voda',
      syllables: ['vo', 'da'],
      imageAsset: 'assets/therapy/voda.png',
      category: 'hrana',
      difficulty: 1,
    ),
    // ... weitere Wörter
  ];

  // STUFE 2: Erweiterte Wörter (20 Wörter)
  static const level2 = [
    // Tiere
    TherapyWord(word: 'pas', syllables: ['pas'], category: 'životinje'),
    TherapyWord(word: 'mačka', syllables: ['mač', 'ka'], category: 'životinje'),
    TherapyWord(word: 'ptica', syllables: ['pti', 'ca'], category: 'životinje'),
    
    // Essen
    TherapyWord(word: 'jabuka', syllables: ['ja', 'bu', 'ka'], category: 'hrana'),
    TherapyWord(word: 'banana', syllables: ['ba', 'na', 'na'], category: 'hrana'),
    TherapyWord(word: 'hljeb', syllables: ['hljeb'], category: 'hrana'),
    
    // Körper
    TherapyWord(word: 'ruka', syllables: ['ru', 'ka'], category: 'tijelo'),
    TherapyWord(word: 'noga', syllables: ['no', 'ga'], category: 'tijelo'),
    TherapyWord(word: 'glava', syllables: ['gla', 'va'], category: 'tijelo'),
    
    // ... weitere
  ];

  // STUFE 3: Sätze (2-Wort-Kombinationen)
  static const level3Phrases = [
    TherapyPhrase(
      phrase: 'Daj mi',
      words: ['daj', 'mi'],
      meaning: 'Gib mir',
      context: 'Wenn du etwas möchtest',
    ),
    TherapyPhrase(
      phrase: 'Hoću jesti',
      words: ['hoću', 'jesti'],
      meaning: 'Ich will essen',
      context: 'Wenn du hungrig bist',
    ),
    // ... weitere
  ];
}
```

### 5.5 Modul: Silben-Training (Slogovi)

```dart
// Speziell für Logopädie-Training
class SyllableTherapy {
  
  // Einfache Silben (CV-Struktur: Konsonant-Vokal)
  static const basicSyllables = [
    'ma', 'pa', 'ba', 'da', 'ta', 'na',  // Mit A
    'mi', 'pi', 'bi', 'di', 'ti', 'ni',  // Mit I
    'mo', 'po', 'bo', 'do', 'to', 'no',  // Mit O
    'mu', 'pu', 'bu', 'du', 'tu', 'nu',  // Mit U
  ];
  
  // Silben-Ketten (für Rhythmus)
  static const syllableChains = [
    ['ma', 'ma', 'ma'],      // Einfach
    ['pa', 'pa', 'pa'],
    ['ma', 'pa', 'ma'],      // Wechsel
    ['pa', 'ma', 'pa'],
    ['ma', 'pa', 'ba'],      // Drei verschiedene
  ];
  
  // Übung: Silben klatschen
  static void practiceWithClapping(String word, List<String> syllables) {
    // 1. Wort zeigen
    // 2. Silben einzeln sprechen + klatschen
    // 3. Kind macht nach
    // 4. Zusammen klatschen
  }
}
```

### 5.6 Modul: Spiele (Igre)

```
SPIELE FÜR MOTIVATION:

1. 🎯 POGODI SLIKU (Bild erraten)
   - Lianko sagt ein Wort
   - Kind tippt auf richtige Bild
   - Große, bunte Buttons

2. 🔊 ŠTA ČUJEŠ? (Was hörst du?)
   - Geräusch abspielen
   - Kind wählt passendes Bild
   - Trainiert Hören

3. 🎤 PONOVI ZA MNOM (Sprich mir nach)
   - Lianko spricht Wort
   - Kind wiederholt
   - Sterne für jeden Versuch

4. 🧩 SLOŽI SLOVO (Buchstaben zusammensetzen)
   - Silben zu Wörtern kombinieren
   - Drag & Drop Interface

5. 🎨 OBOJI RIJEČ (Farbe und Wort)
   - Lianko sagt Farbe
   - Kind malt in der Farbe
   - Kombiniert Malen + Sprache
```

---

## 6. Gamification-Konzept

### 6.1 Belohnungssystem

```
STERNE (⭐)
├── 1 Stern pro geübtem Wort
├── 3 Sterne für perfekte Aussprache
└── Bonus-Sterne für Streak

STICKER (🏆)
├── Nach jeder Kategorie
├── Sammeln im Album
└── Animierte Sticker

ABZEICHEN (🎖️)
├── "Erstes Wort" 
├── "10 Wörter Meister"
├── "7 Tage Streak"
├── "Silben-König"
└── "Super-Zuhörer"

LEVEL-SYSTEM
├── Level 1: Baby Lianko (0-50 Sterne)
├── Level 2: Kleiner Lianko (51-150 Sterne)
├── Level 3: Starker Lianko (151-300 Sterne)
├── Level 4: Super Lianko (301-500 Sterne)
└── Level 5: Champion Lianko (500+ Sterne)
```

### 6.2 Tägliche Motivation

```dart
// Tägliche Herausforderungen
class DailyChallenge {
  static List<Challenge> getForToday(DateTime date, int childLevel) {
    return [
      Challenge(
        id: 'daily_words',
        title: '5 riječi danas',  // 5 Wörter heute
        description: 'Vježbaj 5 riječi',
        target: 5,
        reward: 10,  // Bonus-Sterne
      ),
      Challenge(
        id: 'listening_game',
        title: 'Igra slušanja',  // Hör-Spiel
        description: 'Igraj 1 igru slušanja',
        target: 1,
        reward: 5,
      ),
      Challenge(
        id: 'perfect_pronunciation',
        title: 'Savršen izgovor',  // Perfekte Aussprache
        description: 'Izgovori 3 riječi savršeno',
        target: 3,
        reward: 15,
      ),
    ];
  }
}
```

### 6.3 Eltern-Kind-Interaktion

```
FAMILIEN-FEATURES:

1. 👨‍👩‍👧 ZAJEDNIČKO VJEŽBANJE (Gemeinsames Üben)
   - Eltern sprechen Wort vor (in App aufnehmen)
   - Kind hört vertraute Stimme
   - Emotionale Bindung + Motivation

2. 📱 NACHRICHTEN VON MAMA/PAPA
   - Eltern nehmen Lob-Nachrichten auf
   - Kind hört sie als Belohnung
   - "Bravo sine, mama te voli!"

3. 📊 FORTSCHRITTS-FOTOS
   - Wöchentliche "Erfolgs-Karte"
   - Eltern teilen mit Familie
   - Oma/Opa können kommentieren
```

---

## 7. Entwicklungsplan

### 7.1 Phase 1: MVP (Wochen 1-4)

```
WOCHE 1-2: Grundstruktur
├── [ ] Therapie-spezifische Screens erstellen
├── [ ] Bosnische Wörter-Datenbank (Stufe 1)
├── [ ] Audiogramm-Profil für das Kind konfigurieren
└── [ ] TTS-Anpassungen testen

WOCHE 3-4: Kernfunktionen
├── [ ] Sprachtraining-Modul
├── [ ] Einfaches Hörtraining
├── [ ] Basis-Belohnungssystem
└── [ ] Eltern-Dashboard (einfach)
```

### 7.2 Phase 2: Erweiterung (Wochen 5-8)

```
WOCHE 5-6: AI-Integration
├── [ ] Whisper-Integration für Aussprache-Analyse
├── [ ] Gemini für adaptive Übungen
├── [ ] Fortschritts-Tracking verbessern
└── [ ] Schwierigkeitsanpassung

WOCHE 7-8: Gamification
├── [ ] Spiele-Module
├── [ ] Vollständiges Belohnungssystem
├── [ ] Tägliche Herausforderungen
└── [ ] Level-System
```

### 7.3 Phase 3: Premium (Wochen 9-12)

```
WOCHE 9-10: Familien-Features
├── [ ] Eltern-Aufnahmen integrieren
├── [ ] ElevenLabs Voice-Cloning (optional)
├── [ ] Familien-Nachrichten
└── [ ] Detaillierte Berichte

WOCHE 11-12: Polish & Launch
├── [ ] Testing mit echten Nutzern
├── [ ] Performance-Optimierung
├── [ ] Fehler beheben
└── [ ] App Store Vorbereitung
```

---

## 8. API-Integrationen

### 8.1 OpenAI Whisper

```dart
// lib/services/whisper_service.dart
class WhisperService {
  static const _apiUrl = 'https://api.openai.com/v1/audio/transcriptions';
  
  Future<TranscriptionResult> transcribe(Uint8List audioData) async {
    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
      body: {
        'file': audioData,
        'model': 'whisper-1',
        'language': 'bs',  // Bosnisch
        'response_format': 'verbose_json',
      },
    );
    
    return TranscriptionResult.fromJson(jsonDecode(response.body));
  }
  
  /// Bewertet Aussprache
  double calculatePronunciationScore(
    String expected, 
    String transcribed,
    double confidence,
  ) {
    // Levenshtein-Distanz + Confidence
    final similarity = _calculateSimilarity(expected, transcribed);
    return (similarity * 0.7) + (confidence * 0.3);
  }
}
```

### 8.2 ElevenLabs

```dart
// lib/services/elevenlabs_service.dart
class ElevenLabsService {
  static const _apiUrl = 'https://api.elevenlabs.io/v1';
  
  /// Klont Eltern-Stimme
  Future<String> cloneVoice({
    required String name,
    required List<Uint8List> samples,
  }) async {
    final response = await http.post(
      Uri.parse('$_apiUrl/voices/add'),
      headers: {
        'xi-api-key': apiKey,
      },
      body: {
        'name': name,
        'files': samples,
      },
    );
    
    return jsonDecode(response.body)['voice_id'];
  }
  
  /// Generiert Sprache mit geklonter Stimme
  Future<Uint8List> generateSpeech({
    required String text,
    required String voiceId,
  }) async {
    final response = await http.post(
      Uri.parse('$_apiUrl/text-to-speech/$voiceId'),
      headers: {
        'xi-api-key': apiKey,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'text': text,
        'model_id': 'eleven_multilingual_v2',
        'voice_settings': {
          'stability': 0.5,
          'similarity_boost': 0.75,
          'style': 0.5,
          'use_speaker_boost': true,
        },
      }),
    );
    
    return response.bodyBytes;
  }
}
```

### 8.3 Firebase (Backend)

```dart
// Firestore-Struktur für Therapie-Daten

/users/{userId}/
  ├── profile/
  │   ├── name: "Ahmed"
  │   ├── age: 4
  │   ├── audiogram: {...}
  │   └── settings: {...}
  │
  ├── progress/
  │   ├── totalWords: 45
  │   ├── totalStars: 230
  │   ├── currentLevel: 2
  │   ├── streak: 5
  │   └── lastPractice: "2025-12-17"
  │
  ├── words/
  │   ├── {wordId}/
  │   │   ├── word: "mama"
  │   │   ├── practicedCount: 15
  │   │   ├── bestScore: 0.95
  │   │   ├── lastPracticed: "2025-12-17"
  │   │   └── status: "mastered"
  │   └── ...
  │
  └── recordings/
      ├── {recordingId}/
      │   ├── word: "mama"
      │   ├── audioUrl: "..."
      │   ├── score: 0.85
      │   ├── timestamp: "..."
      │   └── feedback: "Sehr gut! Nächstes Mal..."
      └── ...
```

---

## 9. Sicherheit & Datenschutz

### 9.1 DSGVO-Konformität

```
DATENSCHUTZ-MASSNAHMEN:

✅ Keine Cloud-Uploads ohne Einwilligung
✅ Audio-Aufnahmen lokal verarbeiten (optional)
✅ Eltern-Zustimmung für alle Daten
✅ Daten-Export möglich
✅ Löschung auf Anfrage
✅ Keine Werbung
✅ Keine Tracking-Cookies
```

### 9.2 Kinderschutz

```
KINDERSCHUTZ-FEATURES:

✅ Eltern-Code für Einstellungen
✅ Zeitlimit pro Session (einstellbar)
✅ Kein externer Chat möglich
✅ Positive Inhalte only
✅ Keine Strafen, nur Ermutigung
✅ Pausen-Erinnerungen
```

---

## 10. Roadmap

### Version 1.0 (MVP)
- ✅ Grundlegendes Sprachtraining
- ✅ Einfaches Hörtraining
- ✅ Basis-Belohnungen
- ✅ Eltern-Übersicht

### Version 1.5
- ⬜ Whisper-Integration
- ⬜ Aussprache-Scoring
- ⬜ Erweiterte Spiele
- ⬜ Tägliche Herausforderungen

### Version 2.0
- ⬜ ElevenLabs Voice-Cloning
- ⬜ Familien-Nachrichten
- ⬜ Detaillierte Berichte
- ⬜ Export für Therapeuten

### Version 3.0
- ⬜ AR-Elemente (z.B. Lianko in echtem Raum)
- ⬜ Multiplayer mit anderen Kindern
- ⬜ Integration mit echten Therapeuten

---

## 📞 Kontakt & Ressourcen

### Nützliche Links:
- [Flutter TTS Docs](https://pub.dev/packages/flutter_tts)
- [OpenAI Whisper API](https://platform.openai.com/docs/guides/speech-to-text)
- [ElevenLabs API](https://elevenlabs.io/docs/api-reference)
- [Google Gemini](https://ai.google.dev/)

### Community:
- Flutter Discord
- Reddit r/speechtherapy
- Hearing Loss Support Groups

---

**💙 Dieses Projekt wird mit Liebe für Kinder mit Hörbehinderung entwickelt.**

*"Svako dijete zaslužuje glas."* - Jedes Kind verdient eine Stimme.
