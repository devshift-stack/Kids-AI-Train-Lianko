# 🏗️ Technische Architektur - Terapko AI Therapie-App

**Version:** 1.0  
**Datum:** 17. Dezember 2025  
**Autor:** Dev Team

---

## 📋 Inhaltsverzeichnis

1. [System-Übersicht](#system-übersicht)
2. [Frontend-Architektur (Flutter)](#frontend-architektur-flutter)
3. [Backend-Architektur](#backend-architektur)
4. [AI/ML-Komponenten](#aiml-komponenten)
5. [Datenbank-Schema](#datenbank-schema)
6. [API-Spezifikationen](#api-spezifikationen)
7. [Deployment & DevOps](#deployment--devops)

---

## 1. System-Übersicht

### High-Level Architektur

```
┌───────────────────────────────────────────────────────────────┐
│                        CLIENT LAYER                           │
│                                                               │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │              FLUTTER APP (iOS & Android)                │ │
│  │                                                         │ │
│  │  UI Layer:                                              │ │
│  │  - Screens (Home, Übungen, Spiele, Dashboard)          │ │
│  │  - Widgets (Buttons, Animationen, Charaktere)          │ │
│  │  - Navigation (Router, Deep Links)                     │ │
│  │                                                         │ │
│  │  Business Logic Layer (Riverpod):                      │ │
│  │  - Services (Speech, TTS, Learning, Rewards)           │ │
│  │  - State Management (Providers, Notifiers)             │ │
│  │  - Models (AudiogramData, UserProfile, Exercise)       │ │
│  │                                                         │ │
│  │  Data Layer:                                            │ │
│  │  - Local Storage (Hive, SharedPreferences)             │ │
│  │  - Cache (Audio-Files, Images)                         │ │
│  │  - On-Device ML (Whisper Model)                        │ │
│  └─────────────────────────────────────────────────────────┘ │
└────────────────────────┬──────────────────────────────────────┘
                         │
                         ↕ HTTP/WebSocket
                         │
┌────────────────────────┴──────────────────────────────────────┐
│                    BACKEND LAYER                              │
│                                                               │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │          PYTHON FLASK API (SpeechBrain Backend)         │ │
│  │                                                         │ │
│  │  Endpoints:                                             │ │
│  │  - /api/analyze-speech (Phonem-Analyse)                │ │
│  │  - /api/adapt-difficulty (Adaptive Logik)              │ │
│  │  - /api/generate-exercises (Übungs-Generierung)        │ │
│  │                                                         │ │
│  │  ML Models (SpeechBrain):                               │ │
│  │  - Speech Recognition                                   │ │
│  │  - Phoneme Classifier                                   │ │
│  │  - Adaptive Learning Algorithm                          │ │
│  └─────────────────────────────────────────────────────────┘ │
│                                                               │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │              FIREBASE SERVICES                          │ │
│  │                                                         │ │
│  │  - Firestore: Datenbank (User, Progress, Exercises)    │ │
│  │  - Storage: Cloud-Speicher (Audiogramme, Audio)        │ │
│  │  - Auth: Authentifizierung (Email/Password)            │ │
│  │  - Analytics: Nutzungs-Statistiken                     │ │
│  │  - Crashlytics: Fehler-Tracking                        │ │
│  └─────────────────────────────────────────────────────────┘ │
└────────────────────────┬──────────────────────────────────────┘
                         │
                         ↕ REST API
                         │
┌────────────────────────┴──────────────────────────────────────┐
│                   EXTERNAL SERVICES                           │
│                                                               │
│  - OpenAI Whisper: Speech-to-Text (On-Device)                │
│  - ElevenLabs API: Voice Cloning & TTS                        │
│  - Google Gemini: Audiogramm-Analyse (Vision AI)             │
└───────────────────────────────────────────────────────────────┘
```

---

## 2. Frontend-Architektur (Flutter)

### 2.1 Projekt-Struktur

```
lib/
├── main.dart                          # App Entry Point
├── core/
│   ├── theme/
│   │   ├── app_theme.dart            # Farben, Fonts, Styles
│   │   └── terapko_colors.dart       # Brand Colors
│   ├── constants/
│   │   ├── app_constants.dart        # Config-Werte
│   │   └── audio_constants.dart      # Audio-Einstellungen
│   └── utils/
│       ├── audio_helper.dart         # Audio-Utilities
│       └── string_similarity.dart    # Levenshtein-Distanz
│
├── models/
│   ├── user_profile.dart             # Kind-Profil
│   ├── exercise.dart                 # Übungs-Modell
│   ├── speech_result.dart            # Sprach-Analyse-Ergebnis
│   ├── audiogram/
│   │   └── audiogram_model.dart      # Audiogramm-Daten
│   └── rewards/
│       ├── badge.dart                # Abzeichen
│       └── achievement.dart          # Erfolge
│
├── services/
│   ├── speech/
│   │   ├── whisper_service.dart      # OpenAI Whisper Integration
│   │   ├── speech_analyzer.dart      # Phonem-Analyse
│   │   └── pronunciation_scorer.dart # Aussprache-Bewertung
│   ├── tts/
│   │   ├── elevenlabs_service.dart   # ElevenLabs TTS
│   │   └── tts_optimizer.dart        # Hörgeräte-Optimierung
│   ├── learning/
│   │   ├── adaptive_learning_service.dart  # SpeechBrain Backend
│   │   ├── difficulty_manager.dart   # Schwierigkeits-Anpassung
│   │   └── exercise_generator.dart   # Übungs-Generierung
│   ├── audiogram/
│   │   ├── audiogram_service.dart    # Audiogramm-Verwaltung
│   │   └── gemini_analyzer.dart      # Gemini Vision AI
│   ├── rewards/
│   │   ├── reward_service.dart       # Belohnungs-Logik
│   │   └── gamification_engine.dart  # Gamification-System
│   ├── firebase/
│   │   ├── firestore_service.dart    # Firestore CRUD
│   │   └── storage_service.dart      # Cloud Storage
│   └── analytics/
│       └── analytics_service.dart    # Event-Tracking
│
├── screens/
│   ├── splash/
│   │   └── splash_screen.dart        # Splash Screen
│   ├── onboarding/
│   │   ├── welcome_screen.dart       # Willkommen
│   │   ├── voice_setup_screen.dart   # Stimmen-Setup
│   │   └── audiogram_upload_screen.dart  # Audiogramm hochladen
│   ├── home/
│   │   └── home_screen.dart          # Haupt-Screen
│   ├── exercises/
│   │   ├── exercise_screen.dart      # Übungs-Durchführung
│   │   ├── listen_repeat_screen.dart # Hören & Nachsprechen
│   │   └── phoneme_training_screen.dart  # Phonem-Training
│   ├── games/
│   │   ├── memory_game_screen.dart   # Memory-Spiel
│   │   ├── puzzle_game_screen.dart   # Puzzle-Spiel
│   │   └── story_mode_screen.dart    # Story-Modus
│   ├── progress/
│   │   ├── progress_screen.dart      # Kind-Fortschritt
│   │   └── museum_screen.dart        # Wort-Museum
│   └── parent_dashboard/
│       ├── dashboard_home.dart       # Eltern-Übersicht
│       ├── analytics_screen.dart     # Detaillierte Analysen
│       └── settings_screen.dart      # Einstellungen
│
├── widgets/
│   ├── common/
│   │   ├── terapko_button.dart       # Custom Button
│   │   ├── animated_character.dart   # Terapko-Charakter
│   │   └── star_animation.dart       # Stern-Animation
│   ├── speech/
│   │   ├── waveform_visualizer.dart  # Audio-Wellenform
│   │   ├── pronunciation_feedback.dart # Visuelles Feedback
│   │   └── subtitle_display.dart     # Untertitel
│   └── progress/
│       ├── progress_bar.dart         # Fortschritts-Balken
│       └── phoneme_heatmap.dart      # Phonem-Heatmap
│
└── providers/
    ├── user_provider.dart            # User State
    ├── exercise_provider.dart        # Exercise State
    ├── speech_provider.dart          # Speech State
    └── reward_provider.dart          # Reward State
```

### 2.2 State Management (Riverpod)

**Warum Riverpod?**
- ✅ Type-safe
- ✅ Testbar
- ✅ Kein BuildContext nötig
- ✅ Auto-Disposal (kein Memory-Leak)

**Wichtige Providers:**

```dart
// user_provider.dart
@riverpod
class UserProfile extends _$UserProfile {
  @override
  Future<UserProfileData> build() async {
    final firestore = ref.read(firestoreServiceProvider);
    return await firestore.getUserProfile();
  }

  Future<void> updateAge(int age) async {
    state = await AsyncValue.guard(() async {
      final firestore = ref.read(firestoreServiceProvider);
      final updated = await firestore.updateAge(age);
      return updated;
    });
  }
}

// speech_provider.dart
@riverpod
class SpeechSession extends _$SpeechSession {
  @override
  SpeechSessionState build() {
    return SpeechSessionState.idle();
  }

  Future<void> startListening(String targetWord) async {
    state = state.copyWith(status: SessionStatus.listening);
    
    final whisper = ref.read(whisperServiceProvider);
    final result = await whisper.recognizeSpeech();
    
    final analyzer = ref.read(speechAnalyzerProvider);
    final analysis = analyzer.analyze(result, targetWord);
    
    state = state.copyWith(
      status: SessionStatus.completed,
      result: analysis,
    );
  }
}

// reward_provider.dart
@riverpod
class RewardSystem extends _$RewardSystem {
  @override
  RewardState build() {
    return RewardState(stars: 0, badges: []);
  }

  void addStar() {
    state = state.copyWith(stars: state.stars + 1);
    
    if (state.stars % 5 == 0) {
      _unlockBadge();
    }
  }

  void _unlockBadge() {
    final newBadge = Badge(
      id: uuid.v4(),
      name: 'Super Speaker',
      unlockedAt: DateTime.now(),
    );
    state = state.copyWith(
      badges: [...state.badges, newBadge],
    );
  }
}
```

### 2.3 Navigation

**Router-Setup (go_router):**

```dart
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/exercise/:exerciseId',
      builder: (context, state) {
        final id = state.pathParameters['exerciseId']!;
        return ExerciseScreen(exerciseId: id);
      },
    ),
    GoRoute(
      path: '/parent-dashboard',
      builder: (context, state) => const ParentDashboardScreen(),
      redirect: (context, state) {
        // Passwort-Schutz
        final isAuthenticated = ref.read(parentAuthProvider);
        return isAuthenticated ? null : '/parent-login';
      },
    ),
  ],
);
```

---

## 3. Backend-Architektur

### 3.1 SpeechBrain Backend (Python Flask)

**Zweck:** Adaptive Lern-Algorithmen und Phonem-Analyse

**Tech-Stack:**
- Python 3.10+
- Flask 3.0 (REST API)
- SpeechBrain 1.0+
- PyTorch 2.1
- NumPy, SciPy (Audio-Processing)

**Projekt-Struktur:**

```
backend/
├── app.py                      # Flask App Entry
├── requirements.txt            # Dependencies
├── config.py                   # Konfiguration
│
├── models/
│   ├── speech_recognizer.py   # SpeechBrain ASR
│   ├── phoneme_classifier.py  # Phonem-Erkennung
│   └── adaptive_learner.py    # Adaptive Logik
│
├── services/
│   ├── speech_analysis.py     # Sprach-Analyse
│   ├── difficulty_adapter.py  # Schwierigkeits-Anpassung
│   └── exercise_generator.py  # Übungs-Generierung
│
├── routes/
│   ├── speech.py              # /api/speech/*
│   ├── learning.py            # /api/learning/*
│   └── exercises.py           # /api/exercises/*
│
└── utils/
    ├── audio_processor.py     # Audio-Preprocessing
    └── phoneme_utils.py       # Phonem-Utilities
```

**Haupt-Endpoints:**

```python
# routes/speech.py
@app.route('/api/analyze-speech', methods=['POST'])
def analyze_speech():
    """
    Analysiert Sprach-Aufnahme und gibt Phonem-Level Feedback
    
    Request:
    {
      "audio_base64": "...",  # Base64-encoded Audio
      "target_word": "sonce",
      "language": "bs"
    }
    
    Response:
    {
      "recognized_text": "sonce",
      "confidence": 0.92,
      "phonemes": [
        {"phoneme": "s", "accuracy": 0.95, "duration_ms": 120},
        {"phoneme": "o", "accuracy": 0.98, "duration_ms": 80},
        {"phoneme": "n", "accuracy": 0.85, "duration_ms": 90},
        ...
      ],
      "overall_score": 0.89,
      "problem_phonemes": ["n"],
      "feedback": "Sehr gut! Das 'n' könnte etwas klarer sein."
    }
    """
    data = request.json
    
    # Decode Audio
    audio_bytes = base64.b64decode(data['audio_base64'])
    audio_array = audio_processor.bytes_to_numpy(audio_bytes)
    
    # SpeechBrain Recognition
    recognizer = SpeechRecognizer()
    transcription = recognizer.transcribe(audio_array, language='bs')
    
    # Phoneme Analysis
    classifier = PhonemeClassifier()
    phoneme_results = classifier.analyze_phonemes(
        audio_array, 
        target=data['target_word']
    )
    
    # Generate Feedback
    feedback = generate_feedback(phoneme_results, language='bs')
    
    return jsonify({
        'recognized_text': transcription,
        'phonemes': phoneme_results,
        'feedback': feedback,
        ...
    })

@app.route('/api/adapt-difficulty', methods=['POST'])
def adapt_difficulty():
    """
    Passt Schwierigkeit basierend auf Performance an
    
    Request:
    {
      "user_id": "user_123",
      "exercise_history": [
        {"exercise_id": "ex_1", "success": true, "score": 0.92},
        {"exercise_id": "ex_2", "success": false, "score": 0.45},
        ...
      ]
    }
    
    Response:
    {
      "current_difficulty": "medium",
      "recommended_difficulty": "easy",
      "reasoning": "Erfolgsrate zu niedrig (40%), reduziere Schwierigkeit",
      "suggested_exercises": ["ex_10", "ex_11", "ex_12"]
    }
    """
    data = request.json
    
    adapter = DifficultyAdapter()
    recommendation = adapter.adapt(
        user_id=data['user_id'],
        history=data['exercise_history']
    )
    
    return jsonify(recommendation)

@app.route('/api/generate-exercises', methods=['POST'])
def generate_exercises():
    """
    Generiert personalisierte Übungen basierend auf Schwächen
    
    Request:
    {
      "user_id": "user_123",
      "problem_phonemes": ["s", "sch"],
      "difficulty": "medium",
      "language": "bs",
      "count": 10
    }
    
    Response:
    {
      "exercises": [
        {
          "id": "generated_1",
          "word": "sonce",
          "phonemes": ["s", "o", "n", "c", "e"],
          "difficulty": "medium",
          "visual_hint": "🌞",
          "audio_url": null  # Generated on-device
        },
        ...
      ]
    }
    """
    data = request.json
    
    generator = ExerciseGenerator()
    exercises = generator.generate(
        problem_phonemes=data['problem_phonemes'],
        difficulty=data['difficulty'],
        language=data['language'],
        count=data['count']
    )
    
    return jsonify({'exercises': exercises})
```

**SpeechBrain Models:**

```python
# models/speech_recognizer.py
import speechbrain as sb
from speechbrain.pretrained import EncoderDecoderASR

class SpeechRecognizer:
    def __init__(self):
        # Pre-trained ASR model
        self.model = EncoderDecoderASR.from_hparams(
            source="speechbrain/asr-crdnn-rnnlm-librispeech",
            savedir="pretrained_models/asr"
        )
    
    def transcribe(self, audio_array, language='bs'):
        """Transkribiert Audio zu Text"""
        # Preprocess audio
        audio_tensor = torch.tensor(audio_array).float()
        
        # Transcribe
        transcription = self.model.transcribe_batch(audio_tensor)
        
        return transcription[0]

# models/phoneme_classifier.py
class PhonemeClassifier:
    def __init__(self):
        self.model = self._load_phoneme_model()
    
    def analyze_phonemes(self, audio_array, target):
        """
        Analysiert Phoneme und gibt Accuracy pro Phonem zurück
        """
        # Extract phonemes from audio
        predicted_phonemes = self._extract_phonemes(audio_array)
        
        # Expected phonemes from target word
        expected_phonemes = self._word_to_phonemes(target)
        
        # Compare and score
        results = []
        for i, expected in enumerate(expected_phonemes):
            if i < len(predicted_phonemes):
                predicted = predicted_phonemes[i]
                accuracy = self._compare_phonemes(expected, predicted)
            else:
                accuracy = 0.0
            
            results.append({
                'phoneme': expected,
                'accuracy': accuracy,
                'duration_ms': self._get_duration(audio_array, i)
            })
        
        return results
```

### 3.2 Firebase Backend

**Firestore Collections:**

```
/users/{userId}
  - name: String
  - age: Number
  - dateOfBirth: Timestamp
  - language: String (default: 'bs')
  - createdAt: Timestamp
  - audiogram: Map (siehe Audiogramm-Schema)
  - settings: Map
    - speechRate: Number (0.3)
    - pitch: Number (0.9)
    - subtitlesEnabled: Boolean (true)
    - voiceId: String (ElevenLabs Voice ID)

/users/{userId}/exercises (subcollection)
  /{exerciseId}
    - word: String
    - phonemes: Array<String>
    - difficulty: String (easy|medium|hard)
    - category: String (s-laut, sch-laut, etc.)
    - completedAt: Timestamp | null
    - attempts: Number
    - successRate: Number
    - lastScore: Number

/users/{userId}/sessions (subcollection)
  /{sessionId}
    - startTime: Timestamp
    - endTime: Timestamp
    - exercisesCompleted: Number
    - starsEarned: Number
    - averageScore: Number
    - problemPhonemes: Array<String>

/users/{userId}/rewards (subcollection)
  /{rewardId}
    - type: String (star|badge|achievement)
    - name: String
    - description: String
    - earnedAt: Timestamp
    - metadata: Map

/users/{userId}/audiograms (subcollection)
  /{audiogramId}
    - leftEar: Map<String, Number> (frequency -> dB)
    - rightEar: Map<String, Number>
    - measuredAt: Timestamp
    - geminiConfidence: Number
    - confirmedByParent: Boolean
    - notes: String

/users/{userId}/progress (subcollection)
  /{date_YYYY-MM-DD}
    - date: Timestamp
    - exercisesCompleted: Number
    - starsEarned: Number
    - wordsLearned: Number
    - timeSpent: Number (Sekunden)
    - averageScore: Number
```

**Security Rules:**

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users können nur ihre eigenen Daten lesen/schreiben
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
      
      // Subcollections
      match /{document=**} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
    
    // Eltern-Dashboard (read-only für Kinder)
    match /users/{userId}/progress/{progressId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

---

## 4. AI/ML-Komponenten

### 4.1 OpenAI Whisper Integration

**On-Device Setup (Flutter):**

```yaml
# pubspec.yaml
dependencies:
  whisper_flutter: ^0.2.0  # Community package
  path_provider: ^2.1.0
  flutter_sound: ^9.2.0
```

```dart
// services/speech/whisper_service.dart
import 'package:whisper_flutter/whisper_flutter.dart';

class WhisperService {
  late Whisper _whisper;
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    // Download model (wird gecached)
    final modelPath = await _downloadWhisperModel('large-v3');
    
    _whisper = Whisper(model: modelPath);
    await _whisper.initialize();
    
    _isInitialized = true;
  }

  Future<WhisperResult> recognizeSpeech(String audioPath) async {
    if (!_isInitialized) await initialize();

    final result = await _whisper.transcribe(
      audioPath,
      language: 'bs',  // Bosnisch
      task: 'transcribe',
      temperature: 0.0,  // Deterministisch
    );

    return WhisperResult(
      text: result.text,
      confidence: result.confidence,
      segments: result.segments,
    );
  }

  Future<String> _downloadWhisperModel(String modelName) async {
    final appDir = await getApplicationDocumentsDirectory();
    final modelPath = '${appDir.path}/models/whisper-$modelName.bin';

    // Check if already downloaded
    if (await File(modelPath).exists()) {
      return modelPath;
    }

    // Download from Hugging Face
    final url = 'https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-$modelName.bin';
    
    await dio.download(url, modelPath, onReceiveProgress: (received, total) {
      print('Download: ${(received / total * 100).toStringAsFixed(0)}%');
    });

    return modelPath;
  }
}
```

**Fine-Tuning Whisper (optional, später):**

```python
# whisper_finetune.py
from transformers import WhisperForConditionalGeneration, WhisperProcessor
from datasets import load_dataset

# Load pre-trained model
model = WhisperForConditionalGeneration.from_pretrained("openai/whisper-large-v3")
processor = WhisperProcessor.from_pretrained("openai/whisper-large-v3")

# Load custom dataset (Aufnahmen von Emir + anderen hörbeeinträchtigten Kindern)
dataset = load_dataset("local_dataset", data_dir="./bosnian_hearing_impaired")

# Fine-tune
from transformers import Trainer, TrainingArguments

training_args = TrainingArguments(
    output_dir="./whisper-bosnian-hearing-impaired",
    per_device_train_batch_size=8,
    gradient_accumulation_steps=2,
    learning_rate=1e-5,
    num_train_epochs=10,
    save_steps=500,
    eval_steps=500,
)

trainer = Trainer(
    model=model,
    args=training_args,
    train_dataset=dataset["train"],
    eval_dataset=dataset["test"],
)

trainer.train()
```

### 4.2 ElevenLabs Voice Cloning

**Setup:**

```dart
// services/tts/elevenlabs_service.dart
import 'package:dio/dio.dart';

class ElevenLabsService {
  final Dio _dio;
  final String _apiKey;
  String? _voiceId;

  ElevenLabsService(this._apiKey) 
    : _dio = Dio(BaseOptions(
        baseUrl: 'https://api.elevenlabs.io/v1',
        headers: {'xi-api-key': _apiKey},
      ));

  /// Step 1: Clone voice from audio samples
  Future<String> cloneVoice({
    required String name,
    required List<String> audioFilePaths,
  }) async {
    final formData = FormData();
    
    // Add name
    formData.fields.add(MapEntry('name', name));
    
    // Add audio files (min. 1 minute total)
    for (final path in audioFilePaths) {
      formData.files.add(MapEntry(
        'files',
        await MultipartFile.fromFile(path),
      ));
    }

    final response = await _dio.post('/voices/add', data: formData);
    
    _voiceId = response.data['voice_id'];
    return _voiceId!;
  }

  /// Step 2: Generate speech with cloned voice
  Future<Uint8List> textToSpeech({
    required String text,
    String? voiceId,
    double stability = 0.5,
    double similarityBoost = 0.75,
  }) async {
    final response = await _dio.post(
      '/text-to-speech/${voiceId ?? _voiceId}',
      data: {
        'text': text,
        'model_id': 'eleven_multilingual_v2',
        'voice_settings': {
          'stability': stability,
          'similarity_boost': similarityBoost,
          'style': 0.5,
          'use_speaker_boost': true,
        },
      },
      options: Options(responseType: ResponseType.bytes),
    );

    return response.data as Uint8List;
  }

  /// Step 3: Optimize for hearing aids
  Future<Uint8List> optimizeForHearingAids({
    required Uint8List audioBytes,
    required AudiogramData audiogram,
  }) async {
    // 1. Reduce speech rate
    final slowed = await _adjustSpeed(audioBytes, rate: 0.3);
    
    // 2. Adjust pitch (lower for high-frequency loss)
    final pitched = await _adjustPitch(slowed, semitones: -2);
    
    // 3. Amplify frequencies based on audiogram
    final equalized = await _equalizeForAudiogram(pitched, audiogram);
    
    return equalized;
  }
}
```

**Voice Cloning Workflow (Onboarding):**

```
1. Eltern-Anleitung:
   "Bitte nehmen Sie 5-10 Minuten Audio auf, in denen Sie:
   - Verschiedene Emotionen zeigen (fröhlich, ruhig, ermutigend)
   - Verschiedene Sätze sprechen (Anweisungen, Lob, Geschichten)
   - Natürlich klingen (nicht zu schnell/langsam)"

2. App-Recording:
   - Record 10x 30-Sekunden-Clips
   - Automatische Qualitäts-Checks (Lautstärke, Hintergrund-Rauschen)
   - Retry-Option bei schlechter Qualität

3. Upload & Processing:
   - Upload zu ElevenLabs
   - Voice Clone generieren (5-10 Min)
   - Test-Ausgabe: "Hallo Emir! Das bin ich - Mama!"

4. Finalisierung:
   - Voice ID wird in Firestore gespeichert
   - Ab jetzt nutzt App diese Stimme für alle TTS
```

### 4.3 Google Gemini Audiogramm-Analyse

**Wiederverwendung von Lianko-Code:**

```dart
// services/audiogram/gemini_analyzer.dart
// Basiert auf: lib/services/ai_audiogram_reader_service.dart

import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiAudiogramAnalyzer {
  final GenerativeModel _model;

  GeminiAudiogramAnalyzer(String apiKey)
    : _model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
        generationConfig: GenerationConfig(
          temperature: 0.1,  // Low for precise numbers
          topK: 1,
          topP: 0.8,
        ),
      );

  Future<AudiogramReadResult> analyzeImage(Uint8List imageBytes) async {
    final prompt = '''
Analysiere dieses Audiogramm-Bild sorgfältig.

Extrahiere die Hörschwellenwerte (dB HL) für BEIDE Ohren:
- 250, 500, 1000, 2000, 4000, 8000 Hz

Format:
{
  "leftEar": {"250": X, "500": Y, ...},
  "rightEar": {"250": X, "500": Y, ...},
  "confidence": 0.0-1.0,
  "notes": "Beschreibung"
}

Wichtig:
- Linkes Ohr: meist O (blau/rot)
- Rechtes Ohr: meist X (blau/rot)
- Y-Achse: 0=gut (oben), 120=taub (unten)
''';

    final response = await _model.generateContent([
      Content.multi([
        TextPart(prompt),
        DataPart('image/jpeg', imageBytes),
      ])
    ]);

    return _parseResponse(response.text!);
  }

  AudiogramReadResult _parseResponse(String text) {
    // JSON extraction & parsing
    // ... (siehe Lianko-Code)
  }
}
```

---

## 5. Datenbank-Schema

### Firestore Collections (Erweitert)

```
/users/{userId}
  {
    // Basic Info
    id: String,
    name: String,
    age: Number (4),
    gender: String ('male' | 'female' | 'other'),
    language: String ('bs'),
    createdAt: Timestamp,
    
    // Audiogram Data
    audiogram: {
      leftEar: {
        "250": 60,
        "500": 60,
        "1000": 60,
        "2000": 60,
        "4000": 65,
        "8000": 70
      },
      rightEar: {
        "250": 70,
        "500": 70,
        "1000": 70,
        "2000": 70,
        "4000": 75,
        "8000": 80
      },
      measuredAt: Timestamp,
      geminiConfidence: 0.85,
      confirmedByParent: true,
      hearingLossLevel: 'moderate'  // WHO classification
    },
    
    // App Settings
    settings: {
      // TTS
      speechRate: 0.3,
      pitch: 0.9,
      voiceId: 'elevenlabs_voice_id_123',
      
      // UI
      subtitlesEnabled: true,
      textScale: 1.3,
      animationSpeed: 0.7,
      
      // Learning
      difficultyLevel: 'easy',
      maxExercisesPerDay: 20,
      reminderEnabled: true,
      reminderTime: '09:00',
      
      // Parent Controls
      parentEmail: 'parent@email.com',
      weeklyReportEnabled: true,
      notifyOnMilestones: true
    },
    
    // Progress Summary
    progress: {
      totalExercises: 150,
      totalStars: 420,
      totalBadges: 12,
      wordsLearned: 45,
      currentLevel: 3,
      currentStreak: 7,  // Tage in Folge
      longestStreak: 14,
      lastActiveDate: Timestamp
    }
  }

/users/{userId}/exercises/{exerciseId}
  {
    id: String,
    word: String ('sonce'),
    translation: String ('Sonne'),
    phonemes: ['s', 'o', 'n', 'c', 'e'],
    difficulty: 'medium',
    category: 's-laut',
    emoji: '🌞',
    
    // Progress
    attempts: 5,
    successes: 3,
    successRate: 0.6,
    lastAttemptAt: Timestamp,
    lastScore: 0.85,
    averageScore: 0.72,
    
    // Problem Analysis
    problemPhonemes: ['n'],  // Schwierige Phoneme
    commonErrors: ['sance', 'sonce'],
    
    // Metadata
    createdAt: Timestamp,
    completedAt: Timestamp | null,
    isStarred: false  // Favorit
  }

/users/{userId}/sessions/{sessionId}
  {
    id: String,
    startTime: Timestamp,
    endTime: Timestamp,
    durationSeconds: 600,
    
    // Performance
    exercisesAttempted: 10,
    exercisesCompleted: 8,
    starsEarned: 24,
    averageScore: 0.78,
    
    // Analysis
    phonemeAccuracy: {
      's': 0.95,
      'sch': 0.65,
      'r': 0.80,
      ...
    },
    problemPhonemes: ['sch'],
    newWordsLearned: ['auto', 'kuća'],
    
    // Context
    deviceType: 'android',
    appVersion: '1.0.0',
    audioQuality: 'good'
  }

/users/{userId}/rewards/{rewardId}
  {
    id: String,
    type: 'badge',  // 'star' | 'badge' | 'achievement' | 'item'
    name: 'S-Laut Meister',
    description: '100 S-Wörter perfekt gesprochen',
    emoji: '🏆',
    rarity: 'rare',  // common, uncommon, rare, epic, legendary
    earnedAt: Timestamp,
    
    // Metadata
    requirements: {
      phoneme: 's',
      correctCount: 100,
      minAccuracy: 0.9
    },
    progress: 100,  // 0-100%
    isNew: true  // Für Badge-Benachrichtigung
  }

/users/{userId}/daily_progress/{date_YYYY-MM-DD}
  {
    date: Timestamp,
    
    // Stats
    exercisesCompleted: 12,
    starsEarned: 36,
    timeSpent: 720,  // Sekunden
    sessionsCount: 3,
    
    // Performance
    averageScore: 0.82,
    bestScore: 0.95,
    wordsLearned: 4,
    
    // Phoneme Analysis
    phonemeAccuracy: {...},
    problemPhonemes: ['sch'],
    
    // Milestones
    milestonesReached: ['first_10_exercises', 'perfect_score'],
    
    // Context
    wasReminderSent: true,
    parentViewedProgress: false
  }
```

---

## 6. API-Spezifikationen

### 6.1 SpeechBrain Backend API

**Base URL:** `https://api.terapko.app` (oder localhost für Dev)

#### POST /api/analyze-speech

**Request:**
```json
{
  "audio_base64": "UklGRiQAAABXQVZFZm10...",
  "target_word": "sonce",
  "language": "bs",
  "user_id": "user_123"
}
```

**Response (Success):**
```json
{
  "status": "success",
  "data": {
    "recognized_text": "sonce",
    "confidence": 0.92,
    "phonemes": [
      {
        "phoneme": "s",
        "accuracy": 0.95,
        "duration_ms": 120,
        "start_ms": 0,
        "end_ms": 120
      },
      {
        "phoneme": "o",
        "accuracy": 0.98,
        "duration_ms": 80,
        "start_ms": 120,
        "end_ms": 200
      }
    ],
    "overall_score": 0.89,
    "problem_phonemes": ["n"],
    "feedback": {
      "text": "Sehr gut! Das 'n' könnte etwas klarer sein.",
      "emotion": "encouraging"
    }
  }
}
```

**Response (Error):**
```json
{
  "status": "error",
  "error": {
    "code": "AUDIO_TOO_SHORT",
    "message": "Audio muss mindestens 0.5 Sekunden lang sein"
  }
}
```

#### POST /api/adapt-difficulty

**Request:**
```json
{
  "user_id": "user_123",
  "exercise_history": [
    {"exercise_id": "ex_1", "success": true, "score": 0.92},
    {"exercise_id": "ex_2", "success": false, "score": 0.45}
  ],
  "current_difficulty": "medium"
}
```

**Response:**
```json
{
  "status": "success",
  "data": {
    "recommended_difficulty": "easy",
    "reasoning": "Erfolgsrate zu niedrig (40%), reduziere Schwierigkeit",
    "confidence": 0.85,
    "suggested_exercises": ["ex_10", "ex_11", "ex_12"]
  }
}
```

#### POST /api/generate-exercises

**Request:**
```json
{
  "user_id": "user_123",
  "problem_phonemes": ["s", "sch"],
  "difficulty": "medium",
  "language": "bs",
  "count": 10,
  "exclude_completed": true
}
```

**Response:**
```json
{
  "status": "success",
  "data": {
    "exercises": [
      {
        "id": "generated_1",
        "word": "sonce",
        "translation": "Sonne",
        "phonemes": ["s", "o", "n", "c", "e"],
        "difficulty": "medium",
        "category": "s-laut",
        "emoji": "🌞",
        "audio_url": null
      }
    ],
    "total_count": 10
  }
}
```

### 6.2 ElevenLabs API Integration

**Dokumentation:** https://elevenlabs.io/docs/api-reference

**Wichtige Endpoints:**

```dart
// Voice Cloning
POST https://api.elevenlabs.io/v1/voices/add
Headers: 
  xi-api-key: YOUR_API_KEY
Body (multipart/form-data):
  name: "Mama Stimme"
  files: [audio1.mp3, audio2.mp3, ...]

Response:
{
  "voice_id": "abc123...",
  "name": "Mama Stimme"
}

// Text-to-Speech
POST https://api.elevenlabs.io/v1/text-to-speech/{voice_id}
Headers:
  xi-api-key: YOUR_API_KEY
Body:
{
  "text": "Dobro jutro Emir!",
  "model_id": "eleven_multilingual_v2",
  "voice_settings": {
    "stability": 0.5,
    "similarity_boost": 0.75
  }
}

Response: Binary audio (MP3)
```

---

## 7. Deployment & DevOps

### 7.1 Flutter App Deployment

**Android:**
```bash
# Build APK
flutter build apk --release

# Build App Bundle (für Google Play)
flutter build appbundle --release

# Test auf Gerät
flutter install --release
```

**iOS:**
```bash
# Build für iOS
flutter build ios --release

# Xcode öffnen für Submission
open ios/Runner.xcworkspace

# TestFlight Upload via Xcode
```

### 7.2 Backend Deployment

**Option 1: Cloud Run (Google Cloud) - Empfohlen**

```dockerfile
# Dockerfile
FROM python:3.10-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Download SpeechBrain models
RUN python -c "import speechbrain as sb; sb.utils.data_pipeline.download_model('...')"

# Copy app
COPY . .

# Run
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "app:app"]
```

```bash
# Deploy zu Cloud Run
gcloud run deploy terapko-backend \
  --image gcr.io/terapko-app/backend:latest \
  --platform managed \
  --region europe-west1 \
  --allow-unauthenticated \
  --memory 2Gi \
  --cpu 2
```

**Option 2: Localhost (für Tests)**

```bash
# Python Environment
python -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Run Flask
python app.py
```

### 7.3 Firebase Setup

```bash
# Firebase CLI installieren
npm install -g firebase-tools

# Login
firebase login

# Initialize
firebase init

# Deploy Firestore Rules
firebase deploy --only firestore:rules

# Deploy Storage Rules
firebase deploy --only storage

# Deploy Functions (falls benötigt)
firebase deploy --only functions
```

### 7.4 CI/CD Pipeline (GitHub Actions)

```.yaml
# .github/workflows/flutter.yml
name: Flutter CI/CD

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
      
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test

  build_android:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      
      - run: flutter pub get
      - run: flutter build apk --release
      
      - uses: actions/upload-artifact@v3
        with:
          name: release-apk
          path: build/app/outputs/flutter-apk/app-release.apk

  build_ios:
    needs: test
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      
      - run: flutter pub get
      - run: flutter build ios --release --no-codesign
```

---

## 8. Performance & Optimierung

### 8.1 Flutter App Performance

**Ziele:**
- Cold Start: <2 Sekunden
- Whisper Recognition: <3 Sekunden
- TTS Latenz: <500ms
- 60 FPS UI (keine Ruckler)

**Optimierungen:**

```dart
// 1. Lazy Loading von Models
class ModelLoader {
  static Whisper? _whisper;
  
  static Future<Whisper> getWhisper() async {
    if (_whisper == null) {
      _whisper = await Whisper.load('large-v3');
    }
    return _whisper!;
  }
}

// 2. Audio Caching
class AudioCache {
  final Map<String, Uint8List> _cache = {};
  
  Future<Uint8List> getAudio(String key, Future<Uint8List> Function() loader) async {
    if (_cache.containsKey(key)) {
      return _cache[key]!;
    }
    final audio = await loader();
    _cache[key] = audio;
    return audio;
  }
}

// 3. Image Optimization
CachedNetworkImage(
  imageUrl: imageUrl,
  memCacheWidth: 200,  // Limit cache size
  memCacheHeight: 200,
)

// 4. Isolate für Heavy Computing
Future<WhisperResult> recognizeSpeech(String audioPath) async {
  return await compute(_recognizeInIsolate, audioPath);
}

WhisperResult _recognizeInIsolate(String audioPath) {
  // Läuft in separatem Thread
  return Whisper.transcribe(audioPath);
}
```

### 8.2 Backend Performance

**SpeechBrain Optimierungen:**

```python
# GPU Support (wenn verfügbar)
import torch

device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
model.to(device)

# Batch Processing
@app.route('/api/batch-analyze', methods=['POST'])
def batch_analyze():
    """Analysiere mehrere Audios auf einmal"""
    audio_files = request.json['audio_files']
    
    # Process in batch
    results = model.transcribe_batch(audio_files)
    
    return jsonify(results)

# Caching häufiger Anfragen
from functools import lru_cache

@lru_cache(maxsize=1000)
def get_exercises_for_phoneme(phoneme, difficulty):
    """Gecachte Übungs-Suche"""
    return exercise_db.find(phoneme=phoneme, difficulty=difficulty)
```

---

## 9. Monitoring & Logging

### 9.1 Firebase Analytics Events

```dart
// Track wichtige Events
class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // Übung gestartet
  Future<void> logExerciseStarted(String exerciseId, String word) async {
    await _analytics.logEvent(
      name: 'exercise_started',
      parameters: {
        'exercise_id': exerciseId,
        'word': word,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  // Übung abgeschlossen
  Future<void> logExerciseCompleted({
    required String exerciseId,
    required double score,
    required int attempts,
  }) async {
    await _analytics.logEvent(
      name: 'exercise_completed',
      parameters: {
        'exercise_id': exerciseId,
        'score': score,
        'attempts': attempts,
      },
    );
  }

  // Fehler aufgetreten
  Future<void> logError(String error, String context) async {
    await _analytics.logEvent(
      name: 'app_error',
      parameters: {
        'error': error,
        'context': context,
      },
    );
    
    // Auch an Crashlytics
    await FirebaseCrashlytics.instance.recordError(
      error,
      StackTrace.current,
      reason: context,
    );
  }
}
```

### 9.2 Backend Logging

```python
# app.py
import logging
from logging.handlers import RotatingFileHandler

# Setup Logging
handler = RotatingFileHandler('logs/app.log', maxBytes=10000000, backupCount=5)
handler.setLevel(logging.INFO)
formatter = logging.Formatter('[%(asctime)s] %(levelname)s in %(module)s: %(message)s')
handler.setFormatter(formatter)

app.logger.addHandler(handler)
app.logger.setLevel(logging.INFO)

# Log Anfragen
@app.before_request
def log_request():
    app.logger.info(f'{request.method} {request.path} - {request.remote_addr}')

@app.after_request
def log_response(response):
    app.logger.info(f'Response: {response.status_code}')
    return response
```

---

## 10. Security & Privacy

### 10.1 Datenschutz (DSGVO)

**Prinzipien:**
1. **Datenminimierung:** Nur nötige Daten sammeln
2. **Verschlüsselung:** Alle sensiblen Daten verschlüsseln
3. **Löschung:** Eltern können alle Daten löschen
4. **Transparenz:** Klare Privacy Policy

**Implementierung:**

```dart
// Verschlüsselte Speicherung von Audioaufnahmen
import 'package:encrypt/encrypt.dart';

class SecureStorage {
  final key = Key.fromSecureRandom(32);
  final iv = IV.fromSecureRandom(16);
  final encrypter = Encrypter(AES(key));

  Future<void> saveAudioSecure(String audioId, Uint8List audioBytes) async {
    // Encrypt
    final encrypted = encrypter.encryptBytes(audioBytes, iv: iv);
    
    // Save to Firebase Storage
    await FirebaseStorage.instance
      .ref('audio_encrypted/$audioId')
      .putData(encrypted.bytes);
  }

  Future<Uint8List> loadAudioSecure(String audioId) async {
    // Load from Firebase
    final bytes = await FirebaseStorage.instance
      .ref('audio_encrypted/$audioId')
      .getData();
    
    // Decrypt
    final encrypted = Encrypted(bytes!);
    return encrypter.decryptBytes(encrypted, iv: iv);
  }
}
```

### 10.2 Eltern-Authentifizierung

```dart
// Passwort-geschützter Zugang zum Dashboard
class ParentAuthService {
  Future<bool> authenticate(String password) async {
    final storedHash = await _getStoredPasswordHash();
    final inputHash = _hashPassword(password);
    return storedHash == inputHash;
  }

  String _hashPassword(String password) {
    // Verwende bcrypt oder ähnliches
    return sha256.convert(utf8.encode(password)).toString();
  }
}
```

---

**Ende der technischen Architektur-Dokumentation**

---

**Nächste Dokumente:**
- [GAMIFICATION_KONZEPT.md](./GAMIFICATION_KONZEPT.md) - Game-Design Details
- [IMPLEMENTIERUNGS_ROADMAP.md](./IMPLEMENTIERUNGS_ROADMAP.md) - Schritt-für-Schritt Plan
- [BOSNISCHE_INHALTE.md](./BOSNISCHE_INHALTE.md) - Content-Bibliothek
