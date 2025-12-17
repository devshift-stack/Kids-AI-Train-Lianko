# 🗓️ Implementierungs-Roadmap - Terapko AI

**Version:** 1.0  
**Datum:** 17. Dezember 2025  
**Gesamtdauer:** 20 Wochen (5 Monate)  
**Team-Größe:** 1-2 Entwickler

---

## 📋 Phasen-Übersicht

| Phase | Dauer | Fokus | Deliverable |
|-------|-------|-------|-------------|
| **Phase 0: Setup** | Woche 1 | Projekt-Setup, Tools | Development Environment |
| **Phase 1: MVP** | Wochen 2-5 | Core Features | Funktionierender Prototyp |
| **Phase 2: Gamification** | Wochen 6-9 | Game-Elemente | Motivierendes Erlebnis |
| **Phase 3: AI & Learning** | Wochen 10-13 | SpeechBrain, Adaptive Logic | Personalisierung |
| **Phase 4: Parent Dashboard** | Wochen 14-17 | Eltern-Features | Vollständige App |
| **Phase 5: Polish & Launch** | Wochen 18-20 | Testing, Optimierung | Production-Ready App |

**Meilensteine:**
- ✅ Woche 5: MVP Demo
- ✅ Woche 9: Alpha-Version (mit Gamification)
- ✅ Woche 13: Beta-Version (mit AI)
- ✅ Woche 17: Release Candidate
- ✅ Woche 20: 🚀 Launch!

---

## Phase 0: Setup & Vorbereitung (Woche 1)

### Tag 1-2: Projekt-Setup

**Flutter-Projekt initialisieren:**
```bash
# Neues Flutter-Projekt
flutter create terapko_ai
cd terapko_ai

# Dependencies hinzufügen
flutter pub add \
  flutter_riverpod \
  firebase_core \
  cloud_firestore \
  firebase_auth \
  firebase_storage \
  flutter_tts \
  speech_to_text \
  dio \
  hive_flutter \
  shared_preferences \
  google_generative_ai \
  lottie \
  cached_network_image

# Dev Dependencies
flutter pub add --dev \
  flutter_lints \
  build_runner \
  riverpod_generator \
  mocktail
```

**Git Repository:**
```bash
git init
git remote add origin https://github.com/[username]/terapko-ai.git
git checkout -b develop
```

**Ordnerstruktur anlegen:**
```bash
mkdir -p lib/{core,models,services,screens,widgets,providers}
mkdir -p lib/core/{theme,constants,utils}
mkdir -p lib/services/{speech,tts,learning,audiogram,rewards}
mkdir -p assets/{animations,audio,images,locales}
```

### Tag 3-4: Firebase Setup

**Firebase-Projekt erstellen:**
1. https://console.firebase.google.com → Neues Projekt
2. Name: "Terapko AI"
3. Enable: Firestore, Storage, Auth, Analytics, Crashlytics

**Firebase in Flutter integrieren:**
```bash
# FlutterFire CLI
dart pub global activate flutterfire_cli
flutterfire configure
```

**Firestore Collections anlegen:**
```javascript
// Firestore Security Rules
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
      match /{document=**} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
  }
}
```

### Tag 5: ElevenLabs & Gemini Setup

**ElevenLabs Account:**
- Registrieren auf https://elevenlabs.io
- API-Key erstellen
- In `.env` speichern (nicht in Git)

**Gemini API:**
- Google AI Studio: https://makersuite.google.com
- API-Key erstellen
- Testen mit Curl:
```bash
curl -X POST \
  "https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=YOUR_API_KEY" \
  -H 'Content-Type: application/json' \
  -d '{"contents":[{"parts":[{"text":"Hello"}]}]}'
```

### Tag 6-7: Lianko-Code-Review & Anpassung

**Von Lianko übernehmen:**
1. `audiogram_model.dart` → `/lib/models/audiogram/`
2. `ai_audiogram_reader_service.dart` → `/lib/services/audiogram/`
3. `speech_training_service.dart` → Anpassen für Whisper
4. `age_adaptive_service.dart` → Basis für Adaptive Learning
5. UI-Widgets: Untertitel, Buttons, Animationen

**Anpassungen machen:**
- Bosnisch als Hauptsprache
- Alters-Anpassung auf 4 Jahre fixieren
- Audiogramm-Werte auf 60-70% setzen (Test-Daten)

**Checklist:**
- [ ] Flutter-Projekt läuft (iOS & Android)
- [ ] Firebase verbunden
- [ ] Lianko-Code importiert
- [ ] API-Keys konfiguriert
- [ ] Git-Repository eingerichtet

---

## Phase 1: MVP - Core Features (Wochen 2-5)

### Woche 2: Basis-UI & Navigation

**Ziel:** App-Struktur mit Navigation

**Tasks:**
1. **Theme & Styling erstellen**
   ```dart
   // lib/core/theme/app_theme.dart
   class TerapkoTheme {
     static ThemeData lightTheme = ThemeData(
       primaryColor: Color(0xFF4CAF50),  // Grün
       colorScheme: ColorScheme.light(
         primary: Color(0xFF4CAF50),
         secondary: Color(0xFF2196F3),  // Blau
       ),
       textTheme: TextTheme(
         displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
         bodyLarge: TextStyle(fontSize: 24),  // Groß für 4-Jährige
       ),
     );
   }
   ```

2. **Splash Screen**
   - Terapko-Logo (Platzhalter)
   - Loading-Animation
   - Auto-Navigation zu Onboarding/Home

3. **Navigation Setup (go_router)**
   ```dart
   final router = GoRouter(
     routes: [
       GoRoute(path: '/', builder: (context, state) => SplashScreen()),
       GoRoute(path: '/onboarding', builder: (context, state) => OnboardingScreen()),
       GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
       GoRoute(path: '/exercise/:id', builder: (context, state) => ExerciseScreen(...)),
     ],
   );
   ```

4. **Home Screen (Skeleton)**
   - Terapko-Charakter (Platzhalter-Bild)
   - Level-Anzeige
   - Sterne-Counter
   - "Übung starten"-Button

**Deliverable:** Navigierbare App-Struktur

### Woche 3: Whisper-Integration & Basis-Übungen

**Ziel:** Kind kann erste Wörter sprechen und Feedback bekommen

**Tasks:**
1. **Whisper Service implementieren**
   ```dart
   // lib/services/speech/whisper_service.dart
   class WhisperService {
     Future<void> initialize() async {
       // Download Whisper model (large-v3)
       // Cache model
     }
     
     Future<WhisperResult> recognizeSpeech(String audioPath) async {
       // Transcribe audio
       // Return result with confidence
     }
   }
   ```

2. **Audio Recording**
   ```dart
   // lib/services/speech/audio_recorder.dart
   import 'package:flutter_sound/flutter_sound.dart';
   
   class AudioRecorder {
     final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
     
     Future<void> startRecording() async { ... }
     Future<String> stopRecording() async { ... }  // Returns path
   }
   ```

3. **Exercise Screen erstellen**
   - Wort anzeigen (Text + Emoji)
   - "Anhören"-Button (TTS)
   - "Aufnehmen"-Button (Mikrofon)
   - Feedback-Anzeige (Sterne-Rating)

4. **10 Test-Wörter (Bosnisch)**
   ```dart
   final List<Exercise> testExercises = [
     Exercise(word: 'mama', emoji: '👩', difficulty: 'easy'),
     Exercise(word: 'tata', emoji: '👨', difficulty: 'easy'),
     Exercise(word: 'sonce', emoji: '🌞', difficulty: 'medium'),
     Exercise(word: 'pas', emoji: '🐕', difficulty: 'easy'),
     Exercise(word: 'mačka', emoji: '🐈', difficulty: 'easy'),
     Exercise(word: 'kuća', emoji: '🏠', difficulty: 'medium'),
     Exercise(word: 'auto', emoji: '🚗', difficulty: 'medium'),
     Exercise(word: 'voda', emoji: '💧', difficulty: 'easy'),
     Exercise(word: 'hrana', emoji: '🍽️', difficulty: 'medium'),
     Exercise(word: 'igra', emoji: '🎮', difficulty: 'medium'),
   ];
   ```

5. **Basis-Feedback-System**
   - Score berechnen (Levenshtein-Distanz)
   - Sterne vergeben (1-3 ⭐)
   - Visuelles Feedback (Animation)

**Deliverable:** Kind kann Wörter sprechen und bekommt Feedback

### Woche 4: ElevenLabs TTS & Voice Cloning

**Ziel:** Personalisierte Mama/Papa-Stimme

**Tasks:**
1. **ElevenLabs Service**
   ```dart
   // lib/services/tts/elevenlabs_service.dart
   class ElevenLabsService {
     Future<String> cloneVoice({
       required String name,
       required List<String> audioPaths,
     }) async { ... }
     
     Future<Uint8List> textToSpeech({
       required String text,
       String? voiceId,
     }) async { ... }
   }
   ```

2. **Onboarding: Voice Setup**
   - Screen für Eltern-Aufnahme
   - 10 Sätze zum Vorlesen
   - Qualitäts-Check (Lautstärke, Rauschen)
   - Upload zu ElevenLabs
   - Voice ID speichern in Firestore

3. **TTS-Optimierung für Hörgeräte**
   ```dart
   Future<Uint8List> optimizeForHearingAids({
     required Uint8List audioBytes,
     required AudiogramData audiogram,
   }) async {
     // Reduce speed to 0.3x
     // Lower pitch by 2 semitones
     // Amplify frequencies based on audiogram
   }
   ```

4. **TTS in Übungen integrieren**
   - "Anhören"-Button spielt TTS ab
   - Untertitel synchron mit Sprache
   - Pausier-Option

**Deliverable:** App spricht mit Mama/Papa-Stimme

### Woche 5: Audiogramm-Upload & Anpassung

**Ziel:** App passt sich an Emirs Hörverlust an

**Tasks:**
1. **Gemini Vision Integration** (von Lianko)
   - Image Picker
   - Upload zu Gemini
   - JSON-Parsing
   - Bestätigungs-Screen

2. **Audiogramm-Analyse-UI**
   ```dart
   // Screens/onboarding/audiogram_upload_screen.dart
   - [Foto aufnehmen]
   - [Aus Galerie wählen]
   - [Manuell eingeben]
   
   // Nach Analyse:
   - Erkannte Werte anzeigen
   - Konfidenz-Score
   - [Bestätigen] / [Korrigieren]
   ```

3. **Settings-Anpassung**
   ```dart
   // Basierend auf Audiogramm:
   final recommendations = AudiogramRecommendations.fromAudiogram(audiogram);
   
   await settings.update({
     'speechRate': recommendations.speechRate,  // 0.3
     'pitch': recommendations.pitch,  // 0.9
     'subtitlesEnabled': recommendations.subtitlesAlwaysOn,  // true
     'textScale': recommendations.textScale,  // 1.3
   });
   ```

4. **Testing mit Test-Audiogramm**
   - Emir's Werte: L: 60dB, R: 70dB
   - Überprüfen: Ist TTS langsam genug? Untertitel sichtbar?

**Deliverable:** App passt sich an Hörverlust an

**MVP-Demo (Ende Woche 5):**
- [ ] Kind kann 10 Wörter üben
- [ ] Whisper erkennt Sprache
- [ ] ElevenLabs spricht mit Mama-Stimme
- [ ] Audiogramm-basierte Anpassung
- [ ] Basis-Feedback (Sterne)

---

## Phase 2: Gamification (Wochen 6-9)

### Woche 6: Terapko-Charakter & Animationen

**Ziel:** Lebendiger Charakter

**Tasks:**
1. **Character Design**
   - Skizzen von Terapko (Roboter)
   - Farb-Schema festlegen
   - In Illustrator/Figma designen

2. **Rive-Animationen erstellen**
   - Idle Animation (blinzeln, atmen)
   - Happy (jubeln)
   - Encouraging (daumen hoch)
   - Thinking (kopf kratzen)
   - Export als .riv

3. **Terapko-Widget implementieren**
   ```dart
   class TerapkoCharacter extends StatelessWidget {
     final TerapkoEmotion emotion;
     
     @override
     Widget build(BuildContext context) {
       return RiveAnimation.asset(
         'assets/animations/terapko.riv',
         animations: [_getAnimationForEmotion(emotion)],
       );
     }
   }
   ```

4. **Emotions in App integrieren**
   - Nach Übung: Happy bei Erfolg, Encouraging bei Fehler
   - Idle auf Home Screen
   - Thinking während Analyse

**Deliverable:** Animierter Terapko-Charakter

### Woche 7: Belohnungs-System

**Ziel:** Sterne, Badges, Museum

**Tasks:**
1. **Reward Service**
   ```dart
   class RewardService {
     Future<void> addStars(int amount) async { ... }
     Future<void> unlockBadge(String badgeId) async { ... }
     Future<void> checkAchievements() async { ... }
   }
   ```

2. **Stern-Animation**
   - Funkelnder Stern erscheint
   - Fliegt zu Counter oben
   - Counter erhöht sich (animiert)
   - Sound-Effekt

3. **Badge-System**
   ```dart
   final badges = [
     Badge(
       id: 's_beginner',
       name: 'S-Laut Anfänger',
       icon: '🐍',
       requirement: Requirement(phoneme: 's', count: 10),
     ),
     // ...weitere Badges
   ];
   ```

4. **Wort-Museum Screen**
   - Grid-View mit Wort-Karten
   - Gelernte Wörter: farbig
   - Nicht gelernte: grau + "???"
   - Tap: Detail-View

5. **Badge-Unlock-Animation**
   - Feuerwerk
   - Badge erscheint groß
   - "Neues Badge freigeschaltet!"
   - Sound-Effekt

**Deliverable:** Funktionierendes Belohnungs-System

### Woche 8: Story-Modus & Welten

**Ziel:** Narrative Struktur

**Tasks:**
1. **Story-System**
   ```dart
   class StoryManager {
     final List<World> worlds = [
       World(
         id: 'suncana_livada',
         name: 'Sunčana Livada',
         icon: '🌻',
         crystals: 20,
         exercises: [...],
       ),
       // ...weitere Welten
     ];
     
     World getCurrentWorld();
     bool isWorldUnlocked(String worldId);
     void completeWorld(String worldId);
   }
   ```

2. **Welt-Karte Screen**
   - Vertikale Liste mit Welten
   - Fortschritts-Balken pro Welt
   - Gesperrte Welten (🔒)
   - Aktuelle Welt hervorgehoben

3. **Story-Sequenzen**
   - Intro: "Willkommen in Sunčana Livada!"
   - Nach 5 Kristallen: "Du machst das toll!"
   - Nach 20 Kristallen: "Welt abgeschlossen!"
   - Übergang zur nächsten Welt

4. **Level-System**
   - Level-Berechnung (Kristalle → Level)
   - Level-Up-Animation
   - Neue Freischaltungen anzeigen

**Deliverable:** Story-Modus mit 5 Welten

### Woche 9: Mini-Spiele (Memory, Puzzle)

**Ziel:** Abwechslung durch Spiele

**Tasks:**
1. **Memory Match Game**
   ```dart
   class MemoryGame extends StatefulWidget {
     final List<Exercise> exercises;  // 6 Wörter
     
     @override
     State<MemoryGame> createState() => _MemoryGameState();
   }
   ```
   - Grid mit Karten (2 Reihen x 6 Spalten)
   - Tap: Karte umdrehen + Wort aussprechen
   - Match: Karten bleiben offen
   - Alle gefunden: +50⭐ Bonus

2. **Zvuk Puzzle Game**
   - Drag & Drop Phoneme
   - Phoneme-Chips generieren
   - Ziel-Wort anzeigen
   - Prüf-Button

3. **Spiel-Freischaltung**
   - Memory: Level 2
   - Puzzle: Level 5
   - Unlock-Animation

4. **Spiele-Screen**
   - Liste verfügbarer Spiele
   - Gesperrte Spiele (🔒)
   - "Spielen"-Button

**Deliverable:** 2 spielbare Mini-Spiele

**Alpha-Version (Ende Woche 9):**
- [ ] Terapko-Charakter animiert
- [ ] Sterne & Badges funktionieren
- [ ] 5 Welten mit Story
- [ ] 2 Mini-Spiele
- [ ] MVP-Features aus Phase 1

---

## Phase 3: AI & Adaptive Learning (Wochen 10-13)

### Woche 10-11: SpeechBrain Backend

**Ziel:** Python Flask API mit SpeechBrain

**Tasks:**
1. **Flask-Projekt Setup**
   ```bash
   mkdir backend && cd backend
   python -m venv venv
   source venv/bin/activate
   pip install flask speechbrain torch numpy
   ```

2. **SpeechBrain Models laden**
   ```python
   # backend/models/speech_recognizer.py
   from speechbrain.pretrained import EncoderDecoderASR
   
   class SpeechRecognizer:
       def __init__(self):
           self.model = EncoderDecoderASR.from_hparams(
               source="speechbrain/asr-crdnn-rnnlm-librispeech",
               savedir="pretrained_models/asr"
           )
   ```

3. **API-Endpoints implementieren**
   - POST /api/analyze-speech
   - POST /api/adapt-difficulty
   - POST /api/generate-exercises

4. **Phonem-Analyse**
   ```python
   class PhonemeClassifier:
       def analyze_phonemes(self, audio_array, target_word):
           # Extract phonemes from audio
           # Compare with expected phonemes
           # Return accuracy per phoneme
   ```

5. **Testing**
   - Test mit Beispiel-Audio
   - Überprüfen: Erkennt "sonce" korrekt?
   - API-Response-Zeit messen (<3 Sekunden)

**Deliverable:** Funktionierender SpeechBrain Backend

### Woche 12: Adaptive Schwierigkeit

**Ziel:** App passt sich an Performance an

**Tasks:**
1. **Difficulty Adapter**
   ```python
   class DifficultyAdapter:
       def adapt(self, user_id, exercise_history):
           success_rate = calculate_success_rate(history[-10:])
           
           if success_rate > 0.9:
               return 'increase_difficulty'
           elif success_rate < 0.4:
               return 'decrease_difficulty'
           else:
               return 'maintain'
   ```

2. **Flutter-Integration**
   ```dart
   class AdaptiveLearningService {
     Future<DifficultyRecommendation> getRecommendation() async {
       final history = await _getExerciseHistory();
       
       final response = await dio.post('/api/adapt-difficulty', data: {
         'user_id': userId,
         'exercise_history': history,
       });
       
       return DifficultyRecommendation.fromJson(response.data);
     }
   }
   ```

3. **Übungs-Auswahl-Logik**
   - Leicht: Einfache Wörter (mama, tata)
   - Mittel: Standard-Wörter (sonce, kuća)
   - Schwer: Komplexe Wörter (škola, prijatelj)

4. **Testing**
   - Simuliere: 10 Übungen @ 100% Erfolg → System erhöht Schwierigkeit
   - Simuliere: 10 Übungen @ 30% Erfolg → System reduziert Schwierigkeit

**Deliverable:** Adaptive Schwierigkeits-Anpassung

### Woche 13: Phonem-Analyse & Visualisierung

**Ziel:** Detailliertes Feedback zu Problemlauten

**Tasks:**
1. **Backend: Phonem-Level Feedback**
   ```python
   # Returns:
   {
     "phonemes": [
       {"phoneme": "s", "accuracy": 0.95, "duration_ms": 120},
       {"phoneme": "o", "accuracy": 0.98, "duration_ms": 80},
       {"phoneme": "n", "accuracy": 0.65, "duration_ms": 90},  # Problem!
     ],
     "problem_phonemes": ["n"]
   }
   ```

2. **Flutter: Phonem-Heatmap Widget**
   ```dart
   class PhonemeHeatmap extends StatelessWidget {
     final Map<String, double> phonemeAccuracy;
     
     @override
     Widget build(BuildContext context) {
       return GridView.builder(
         itemBuilder: (context, index) {
           final phoneme = phonemes[index];
           final accuracy = phonemeAccuracy[phoneme] ?? 0;
           final color = _getColorForAccuracy(accuracy);
           
           return Container(
             color: color,
             child: Center(child: Text(phoneme)),
           );
         },
       );
     }
   }
   ```

3. **Problem-Sound-Fokussierung**
   - Nach 3 Fehlern bei "s": Fokus auf S-Laut-Übungen
   - Empfehlung: "Übe mehr S-Wörter!"
   - Liste mit S-Wörtern anzeigen

4. **Eltern-Benachrichtigung**
   - Push: "Emir hat Schwierigkeiten mit SCH-Laut"
   - Empfehlung: "Besprich mit Logopädin"

**Deliverable:** Phonem-Level-Analyse mit Visualisierung

**Beta-Version (Ende Woche 13):**
- [ ] SpeechBrain Backend läuft
- [ ] Adaptive Schwierigkeit funktioniert
- [ ] Phonem-Analyse detailliert
- [ ] Alle Features aus Phase 1 & 2

---

## Phase 4: Eltern-Dashboard (Wochen 14-17)

### Woche 14: Dashboard-Übersicht

**Ziel:** Eltern sehen Fortschritt

**Tasks:**
1. **Passwort-Schutz**
   ```dart
   class ParentAuthScreen extends StatelessWidget {
     void _authenticate(String password) async {
       final storedHash = await _getStoredPasswordHash();
       if (sha256.convert(utf8.encode(password)).toString() == storedHash) {
         context.go('/parent-dashboard');
       }
     }
   }
   ```

2. **Dashboard Home Screen**
   - Übersicht: Woche, Monat, Gesamt
   - Sterne, Badges, Wörter gelernt
   - Streak-Anzeige
   - Letzte Aktivität

3. **Statistik-Widgets**
   ```dart
   class StatsCard extends StatelessWidget {
     final String title;
     final String value;
     final IconData icon;
     
     // Beispiel:
     // StatsCard(title: 'Sterne', value: '285', icon: Icons.star)
   }
   ```

4. **Tages-Verlauf-Chart**
   - Line-Chart mit Übungen pro Tag (letzte 7 Tage)
   - fl_chart Package verwenden

**Deliverable:** Funktionierendes Dashboard

### Woche 15: Detaillierte Analysen

**Ziel:** Tiefe Einblicke für Eltern

**Tasks:**
1. **Phonem-Heatmap (für Eltern)**
   - Alle Phoneme anzeigen (S, SCH, R, L, etc.)
   - Farb-Kodierung: Grün=gut, Gelb=ok, Rot=Problem
   - Tap: Details zu Phonem

2. **Wort-Liste mit Statistiken**
   ```dart
   class WordStatsList extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return ListView.builder(
         itemBuilder: (context, index) {
           final word = words[index];
           return ListTile(
             leading: Text(word.emoji, style: TextStyle(fontSize: 32)),
             title: Text(word.word),
             subtitle: Text('${word.attempts}x geübt, ${word.successRate}% Erfolg'),
             trailing: Text('${word.averageScore}%'),
           );
         },
       );
     }
   }
   ```

3. **Zeitverlauf-Diagramme**
   - Erfolgsrate über Zeit
   - Neue Wörter pro Woche
   - Session-Dauer über Zeit

4. **Problem-Wörter hervorheben**
   - Liste: "Diese Wörter sind schwierig"
   - Empfehlung: "Mehr üben" oder "Mit Logopädin besprechen"

**Deliverable:** Detaillierte Analyse-Screens

### Woche 16: Übungs-Verwaltung

**Ziel:** Eltern können Übungen anpassen

**Tasks:**
1. **Übungs-Zuweisung**
   ```dart
   class AssignExerciseScreen extends StatefulWidget {
     // Eltern wählen:
     // - Phonem/Laut (s, sch, r, etc.)
     // - Wörter (aus Liste oder manuell)
     // - Ziel pro Tag (z.B. 10 Wiederholungen)
     // - Schwierigkeit
   }
   ```

2. **Logopäden-Notizen**
   - Text-Feld für Empfehlungen
   - "Fokus auf S-Laut am Wortanfang"
   - Wird in Firestore gespeichert

3. **Übungs-Aktivierung/Deaktivierung**
   - Eltern können Übungen ein-/ausschalten
   - "Diese Woche nur S-Laut-Übungen"

4. **Vordefinierte Übungs-Pakete**
   ```dart
   final exercisePackages = [
     ExercisePackage(
       name: 'S-Laut Fokus',
       exercises: [...],  // 20 S-Wörter
       duration: Duration(days: 7),
     ),
     ExercisePackage(
       name: 'Tier-Wörter',
       exercises: [...],  // 15 Tier-Namen
     ),
   ];
   ```

**Deliverable:** Übungs-Verwaltung für Eltern

### Woche 17: PDF-Export & Reports

**Ziel:** Teilen mit Therapeuten

**Tasks:**
1. **PDF-Generierung**
   ```dart
   import 'package:pdf/widgets.dart' as pw;
   
   Future<Uint8List> generateReport({
     required UserProfile profile,
     required List<Session> sessions,
   }) async {
     final pdf = pw.Document();
     
     pdf.addPage(
       pw.Page(
         build: (context) => pw.Column(
           children: [
             pw.Header(level: 0, text: 'Fortschritts-Bericht: ${profile.name}'),
             pw.Text('Zeitraum: ${dateRange.format()}'),
             pw.Table(data: sessionData),
             // ...weitere Sections
           ],
         ),
       ),
     );
     
     return pdf.save();
   }
   ```

2. **Report-Inhalt**
   - Übersicht: Sterne, Wörter, Sessions
   - Phonem-Analyse (Tabelle)
   - Schwierige Wörter (Liste)
   - Fortschritts-Diagramme (als Bilder)
   - Empfehlungen

3. **Share-Funktionalität**
   ```dart
   import 'package:share_plus/share_plus.dart';
   
   Future<void> shareReport(Uint8List pdfBytes) async {
     final tempDir = await getTemporaryDirectory();
     final file = File('${tempDir.path}/bericht_${DateTime.now().millisecondsSinceEpoch}.pdf');
     await file.writeAsBytes(pdfBytes);
     
     await Share.shareXFiles([XFile(file.path)], text: 'Emir\'s Fortschritts-Bericht');
   }
   ```

4. **Email-Option** (optional)
   - Direktes Versenden via Email
   - An Logopädin/Audiologen

**Deliverable:** PDF-Export funktioniert

**Release Candidate (Ende Woche 17):**
- [ ] Eltern-Dashboard vollständig
- [ ] Übungs-Verwaltung
- [ ] PDF-Export
- [ ] Alle Features aus Phase 1-3
- [ ] App ist feature-complete

---

## Phase 5: Polish & Launch (Wochen 18-20)

### Woche 18: Testing & Bug-Fixing

**Ziel:** Fehlerfreie App

**Tasks:**
1. **Unit-Tests schreiben**
   ```dart
   // test/services/whisper_service_test.dart
   void main() {
     group('WhisperService', () {
       test('should recognize "mama" correctly', () async {
         final service = WhisperService();
         final result = await service.recognizeSpeech('test_audio_mama.wav');
         expect(result.text.toLowerCase(), contains('mama'));
       });
     });
   }
   ```

2. **Widget-Tests**
   ```dart
   testWidgets('Exercise Screen should show word and emoji', (tester) async {
     await tester.pumpWidget(ExerciseScreen(exercise: testExercise));
     expect(find.text('SONCE'), findsOneWidget);
     expect(find.text('🌞'), findsOneWidget);
   });
   ```

3. **Integration-Tests**
   - Komplette User-Journey: Onboarding → Übung → Belohnung
   - Überprüfen: Keine Crashes

4. **Bug-Fixing**
   - Crashlytics-Reports durchgehen
   - Kritische Bugs fixen
   - Performance-Issues beheben

**Deliverable:** Stabile App

### Woche 19: Performance-Optimierung & UX-Polish

**Ziel:** Optimale User Experience

**Tasks:**
1. **Performance-Optimierung**
   - Whisper-Model-Laden beschleunigen (Lazy Loading)
   - Bilder komprimieren
   - Cache optimieren
   - 60 FPS sicherstellen

2. **UX-Verbesserungen**
   - Loading-States überall
   - Error-Handling (mit freundlichen Meldungen)
   - Haptic Feedback (Vibration bei Erfolg)
   - Sound-Effekte (optional, da hörbeeinträchtigt)

3. **Accessibility**
   - Screen-Reader-Support (VoiceOver/TalkBack)
   - Kontrast-Check (WCAG AA)
   - Touch-Targets mind. 48x48 px

4. **Animations polishen**
   - Timing anpassen (nicht zu schnell für 4-Jährige)
   - Easing-Funktionen
   - Micro-Interactions

**Deliverable:** Polierte App

### Woche 20: App-Store-Vorbereitung & Launch

**Ziel:** Veröffentlichung

**Tasks:**
1. **App-Store-Assets erstellen**
   - App-Icon (1024x1024 px)
   - Screenshots (iOS & Android)
   - Feature-Graphic (Android)
   - Promo-Video (optional)

2. **Store-Listings schreiben**
   
   **App-Name:** Terapko AI - Sprach-Therapie für Kinder
   
   **Beschreibung (Bosnisch):**
   ```
   Terapko AI je personalizovana aplikacija za logopediju i audiologiju
   za djecu sa oštećenjem sluha. Pomoću AI glasovnog asistenta,
   vaše dijete uči da govori kroz igru i avanture!
   
   ⭐ Personalizirani glas (mama/tata)
   🎮 Zabavne igrice i priče
   📊 Praćenje napretka
   🦻 Optimizirano za slušne aparate
   
   Razvijeno sa ljubavlju za Emira i sve druge hrabre djecu! ❤️
   ```

3. **Privacy Policy & Terms**
   - DSGVO-konforme Privacy Policy
   - Terms of Service
   - Hosting: GitHub Pages oder eigene Website

4. **Build & Submission**
   
   **iOS:**
   ```bash
   flutter build ios --release
   # Öffne Xcode
   open ios/Runner.xcworkspace
   # Archive → Upload to App Store Connect
   # Warte auf Review (~1-3 Tage)
   ```
   
   **Android:**
   ```bash
   flutter build appbundle --release
   # Upload zu Google Play Console
   # Internal Testing → Beta → Production
   # Review (~paar Stunden)
   ```

5. **Soft-Launch**
   - Zuerst: Familie & Freunde (TestFlight/Internal Testing)
   - Feedback sammeln
   - Dann: Public Release

**Deliverable:** 🚀 App ist live!

---

## Post-Launch (Woche 21+)

### Kontinuierliche Verbesserung

**Tasks:**
1. **Monitoring**
   - Firebase Analytics: DAU, Retention, Session-Length
   - Crashlytics: Fehler beheben
   - User-Feedback auswerten

2. **Iterationen**
   - A/B-Tests (Belohnungs-Frequenz, UI-Varianten)
   - Neue Features basierend auf Feedback
   - Content-Updates (neue Wörter, Welten)

3. **Marketing** (optional)
   - Social Media (Instagram, Facebook)
   - Kontakt zu Logopäden-Verbänden
   - Präsentation bei Audiologen

---

## Team & Ressourcen

### Benötigte Skills

| Skill | Wichtigkeit | Wenn nicht vorhanden |
|-------|-------------|----------------------|
| Flutter | ⭐⭐⭐⭐⭐ | Udemy-Kurse, Flutter Docs |
| Python/Flask | ⭐⭐⭐⭐ | Flask Tutorial, SpeechBrain Docs |
| UI/UX Design | ⭐⭐⭐⭐ | Figma-Templates, Fiverr-Designer |
| Animation (Rive) | ⭐⭐⭐ | Rive Learn, YouTube-Tutorials |
| Firebase | ⭐⭐⭐⭐ | FlutterFire Docs |

### Kosten-Schätzung

| Service | Kosten/Monat | Zweck |
|---------|--------------|-------|
| ElevenLabs Creator | €22 | Voice Cloning + 100K Zeichen |
| Firebase Spark (Gratis) | €0 | Firestore, Storage, Auth |
| Google Cloud Run | €0-10 | SpeechBrain Backend |
| Gemini API | ~€0 | <100 Bilder/Monat |
| **Gesamt** | **~€30/Monat** | |

**Entwicklungs-Kosten** (falls extern):
- Freelancer: €50-100/Stunde
- Gesamt: ~€10.000-20.000 (bei 20 Wochen à 10-20h/Woche)

---

## Risiko-Management

| Risiko | Mitigation |
|--------|------------|
| Whisper erkennt Sprache schlecht | Fine-Tuning, mehr Test-Daten sammeln |
| ElevenLabs zu teuer | Fallback auf Open-Source TTS (Coqui TTS) |
| SpeechBrain zu komplex | Start mit simpler Logik, später erweitern |
| Kind verliert Interesse | A/B-Tests, User-Feedback frühzeitig |
| Zeitplan verzögert sich | Buffer-Wochen einplanen, MVP priorisieren |

---

## Checklists

### Pre-Launch Checklist

- [ ] Alle Features funktionieren (End-to-End-Tests)
- [ ] Keine kritischen Bugs (Crashlytics <1% Crash-Rate)
- [ ] Performance optimiert (Cold Start <3s, Whisper <3s)
- [ ] UI poliert (alle Screens responsive)
- [ ] Datenschutz konfiguriert (Privacy Policy, DSGVO)
- [ ] Store-Assets fertig (Icon, Screenshots, Beschreibung)
- [ ] TestFlight/Internal Testing durchgeführt
- [ ] Monitoring eingerichtet (Analytics, Crashlytics)

### Post-Launch Checklist (Woche 1)

- [ ] Monitoring täglich überprüfen
- [ ] User-Reviews lesen & beantworten
- [ ] Kritische Bugs sofort fixen
- [ ] Performance-Metriken analysieren
- [ ] Erste Iterationen basierend auf Feedback

---

**Good Luck! Du schaffst das! 💪**

**Bei Fragen:** Siehe andere Dokumentations-Dateien oder Flutter/SpeechBrain Communities.
