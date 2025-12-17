# 🎯 Therapie-App Master Plan - AI Logopädie & Audiologie für Kinder

**Projektname:** Terapko AI (Bosnische Therapie-App)  
**Version:** 1.0  
**Datum:** 17. Dezember 2025  
**Zielgruppe:** Kinder mit Hörbehinderung (4-8 Jahre), speziell Bosnisch-sprachig

---

## 📋 Inhaltsverzeichnis

1. [Projekt-Übersicht](#projekt-übersicht)
2. [Zielgruppe & Persona](#zielgruppe--persona)
3. [Kern-Features](#kern-features)
4. [Technologie-Stack](#technologie-stack)
5. [Unterschiede zu Lianko](#unterschiede-zu-lianko)
6. [Erfolgs-Metriken](#erfolgs-metriken)

---

## 1. Projekt-Übersicht

### Vision
Eine personalisierte AI-gestützte Therapie-App, die als **virtueller Logopäde und Audiologe** fungiert und schwerhörigen Kindern hilft, spielerisch Sprechen und Hören zu trainieren.

### Mission
Das Training so **interessant, motivierend und effektiv** gestalten, dass das Kind **jeden Tag freiwillig damit arbeiten will** - ohne dass es sich wie "Therapie" anfühlt.

### Kern-Problem
- **Medizinisches Problem:** 60% Hörverlust links, 70% rechts → Kind spricht mit 4 Jahren nur wenige Worte
- **Therapie-Problem:** Logopädie-Termine sind selten (1-2x/Woche), reichen nicht aus
- **Motivations-Problem:** Klassische Übungen sind langweilig, Kind verliert Interesse
- **Sprach-Problem:** Mangel an qualitativ hochwertigen bosnischen Therapie-Inhalten

### Unsere Lösung
Eine **all-in-one Therapie-App** die:
1. **Hört zu:** OpenAI Whisper analysiert Aussprache in Echtzeit
2. **Spricht personalisiert:** ElevenLabs mit geklonter Familienstimme für emotionale Bindung
3. **Lernt adaptiv:** SpeechBrain passt Schwierigkeit dynamisch an
4. **Motiviert spielerisch:** Gamification mit Belohnungen, Abenteuern und Charakteren
5. **Unterstützt Eltern:** Dashboard mit Fortschritts-Tracking und Übungs-Empfehlungen

---

## 2. Zielgruppe & Persona

### Haupt-Persona: Emir (4 Jahre)

**Medizinischer Hintergrund:**
- 60% Hörverlust linkes Ohr, 70% rechts (asymmetrisch)
- Trägt bilaterale Hörgeräte seit 2 Jahren
- Sprach-Entwicklung: ~10-15 Wörter aktiv, Verstehen besser als Sprechen
- Logopädie: 1x wöchentlich (nicht ausreichend)
- Audiologie: Alle 3-6 Monate Kontrolle

**Psychologisches Profil:**
- **Alter:** 4 Jahre → Vorschulalter, kurze Aufmerksamkeitsspanne (5-10 Min)
- **Interessen:** Tiere, Fahrzeuge, Superhelden, bunte Animationen
- **Motivation:** Visuelle Belohnungen, Lob, Sammeln von Sternen/Abzeichen
- **Frustrationen:** Wird schnell frustriert wenn etwas zu schwer ist
- **Bedürfnisse:** Klare visuelle Hinweise, langsame Sprache, viel Ermutigung

**Familien-Kontext:**
- Bosnische Familie, Bosnisch ist Hauptsprache zu Hause
- Eltern arbeiten → begrenztes tägliches Übungszeit
- Wünschen sich: Tägliches Training ohne ständige Anwesenheit eines Erwachsenen
- Technologie-affinität: Smartphone/Tablet vorhanden

**Therapie-Ziele (nächste 6-12 Monate):**
1. Vokabular von 15 → 100 Wörter
2. Verbesserte Artikulation bei Problemlauten (s, sch, r, l)
3. Einfache 2-Wort-Sätze ("Mama, Auto", "Ich will...")
4. Bessere auditive Wahrnehmung (Unterscheidung ähnlicher Laute)
5. Selbstvertrauen beim Sprechen stärken

---

## 3. Kern-Features

### 🎤 Feature 1: AI Sprach-Analyse (OpenAI Whisper)

**Was es tut:**
- Hört dem Kind zu während es spricht
- Analysiert Aussprache, Artikulation, Lautstärke, Sprechgeschwindigkeit
- Erkennt spezifische Schwierigkeiten (z.B. "S" wird wie "Sch" ausgesprochen)
- Gibt Echtzeit-Feedback

**Technische Details:**
- **Modell:** OpenAI Whisper Large-v3 (beste Genauigkeit)
- **Fine-Tuning:** Auf bosnische Kinderstimmen und Hörbehinderung trainiert
- **On-Device:** Läuft lokal für Datenschutz (keine Cloud-Upload der Stimme)
- **Metriken:** 
  - Pronunciation Accuracy Score (0-100%)
  - Phonem-Level Analyse
  - Sprechgeschwindigkeit (Worte/Minute)
  - Lautstärke-Konsistenz

**Beispiel-Interaktion:**
```
App: "Sag: SONNE" 🌞
Kind: "Schonne" (falsch)
Whisper erkennt: confidence=0.85, "Schonne" statt "Sonne"
Feedback: "Fast richtig! Das 'S' ist wie eine Schlange: Ssssss" 🐍
```

**Besonderheiten für Hörbehinderung:**
- Erweiterte Toleranz für asymmetrischen Hörverlust
- Berücksichtigt typische Aussprachefehler bei Hochton-Schwerhörigkeit
- Adaptive Bewertung (nicht zu streng, aber ehrlich)

---

### 🗣️ Feature 2: Personalisierte Stimme (ElevenLabs)

**Was es tut:**
- Klont die Stimme einer vertrauten Person (Mama, Papa, Oma)
- Spricht Übungen, Geschichten und Feedback mit dieser Stimme
- Emotionale Ausdrucksstärke (fröhlich bei Erfolg, ermutigend bei Schwierigkeiten)

**Technische Details:**
- **Service:** ElevenLabs Voice Cloning
- **Training:** 5-10 Minuten Audio-Aufnahmen reichen
- **Modell:** Multilingual v2 (unterstützt Bosnisch)
- **Latenz:** <500ms (Flash v2.5 für Echtzeit)
- **Anpassungen:** 
  - Sprechgeschwindigkeit: 0.3x (sehr langsam für 4-Jährige)
  - Pitch: -10% (tiefere Stimmen sind bei Hochton-Verlust besser hörbar)
  - Pausen: 2x länger zwischen Wörtern

**Beispiel-Setup:**
```
1. Eltern nehmen 10 Minuten Audio auf:
   - "Hallo mein Schatz! Wie geht es dir?"
   - "Das hast du super gemacht!"
   - "Versuch es noch einmal, ich glaube an dich!"
   - ... (verschiedene Emotionen)

2. ElevenLabs klont Stimme

3. App nutzt geklonte Stimme für:
   - Tägliche Begrüßung: "Dobro jutro Emir! Bereit für ein Abenteuer?" 🌅
   - Übungs-Anweisungen: "Hör gut zu: MAMA" 
   - Lob: "Odlično! Das war perfekt!" ⭐
   - Geschichten: "Es war einmal ein mutiger Löwe..." 🦁
```

**Psychologischer Vorteil:**
- **Vertraute Stimme** = höhere Motivation und emotionale Bindung
- Kind assoziiert Übungen mit positiven Gefühlen (Mama/Papa)
- Reduziert Angst vor "Fremden" (wie bei Therapeuten)

---

### 🧠 Feature 3: Adaptive Lern-Engine (SpeechBrain)

**Was es tut:**
- Analysiert Performance über Zeit
- Passt Schwierigkeit automatisch an (leichter wenn zu schwer, schwerer wenn zu leicht)
- Identifiziert Problembereiche (z.B. "S-Laut" ist schwierig)
- Generiert personalisierte Übungs-Pläne

**Technische Details:**
- **Framework:** SpeechBrain (PyTorch-basiert)
- **Modelle:**
  - Speech Recognition für Analyse
  - Speaker Verification für Fortschritts-Tracking
  - Audio Classification für Laut-Kategorisierung
- **Backend:** Python Flask API (läuft lokal oder Cloud)
- **Datenbank:** Firestore für Langzeit-Tracking

**Adaptive Logik:**
```python
# Vereinfachtes Konzept
def adapt_difficulty(child_profile, exercise_history):
    # Analysiere letzte 10 Übungen
    recent_success_rate = calculate_success_rate(exercise_history[-10:])
    
    if recent_success_rate > 0.9:
        # Zu leicht → erhöhe Schwierigkeit
        return increase_difficulty()
    elif recent_success_rate < 0.4:
        # Zu schwer → reduziere Schwierigkeit
        return decrease_difficulty()
    else:
        # Optimal → behalte Level
        return maintain_level()

def suggest_exercises(problem_sounds):
    # Fokussiere auf schwierige Laute
    exercises = []
    for sound in problem_sounds:
        exercises.extend(generate_exercises_for_sound(sound))
    return prioritize_by_frequency_and_difficulty(exercises)
```

**Beispiel-Anpassung:**

**Woche 1:**
```
Kind schafft "S-Laut" zu 90% → System erhöht Schwierigkeit
Nächste Stufe: "S-Laut" in schwierigeren Wörtern (STRASSE statt SONNE)
```

**Woche 2:**
```
Kind schafft "SCH-Laut" nur zu 30% → System reduziert Schwierigkeit
Zurück zu: Einzelne "SCH"-Silben statt ganzer Wörter
Zusätzlich: Visuelle Hilfen (Lippen-Videos)
```

---

### 🎮 Feature 4: Gamification & Motivation

**Kern-Prinzip:** Therapie fühlt sich wie ein **Spiel** an, nicht wie Arbeit.

#### A) Charakter & Story
- **Haupt-Charakter:** "Terapko" - ein freundlicher sprechender Roboter/Tier
- **Story:** Terapko ist auf einer Mission und braucht Emirs Hilfe
- **Mission:** Sammle "Zvuk-Kristalle" (Klang-Kristalle) durch richtiges Sprechen

#### B) Belohnungs-System
| Aktion | Belohnung | Visualisierung |
|--------|-----------|----------------|
| Wort richtig gesprochen | +1 Stern ⭐ | Funkelnde Animation |
| 5 Sterne gesammelt | +1 Abzeichen 🏅 | Feuerwerk-Effekt |
| 10 Übungen pro Tag | Neues Outfit für Terapko | Auswahl-Screen |
| 1 Woche täglich geübt | Neues Mini-Spiel freigeschaltet | Schatztruhe öffnet sich |

#### C) Fortschritts-Visualisierung
- **Level-System:** Level 1 → Level 20 (jeweils neue Welten)
- **Karte:** Visueller Pfad mit Meilensteinen
- **Sammlung:** "Mein Zvuk-Museum" - alle gelernten Wörter als Sammelkarten

#### D) Tägliche Rituale
```
Morgen-Routine:
1. "Dobro jutro Emir!" (mit Mama-Stimme)
2. "Schau, heute wartet ein neues Abenteuer!" 🗺️
3. Mini-Aufwärmübung (2 Min)
4. Hauptübung (5-10 Min)
5. Abschluss: "Du hast heute X Sterne gesammelt!" ⭐⭐⭐

Abend-Routine:
1. "Lass uns den Tag Revue passieren"
2. Zeige Fortschritt auf Karte
3. "Morgen geht's weiter!"
```

#### E) Soziale Features (optional)
- Eltern bekommen Benachrichtigungen: "Emir hat heute 3 neue Wörter gelernt! 🎉"
- Familienleaderboard (nicht kompetitiv, sondern kooperativ)
- "Zeig Mama was du gelernt hast"-Button → Replay der besten Übungen

---

### 📊 Feature 5: Eltern-Dashboard

**Zweck:** Eltern sehen Fortschritt, erhalten Empfehlungen und können Übungen anpassen.

#### A) Übersicht-Screen
```
┌────────────────────────────────────────────────────────┐
│ 📊 Emir's Fortschritt - Diese Woche                    │
│                                                        │
│ 🗣️ Gesprochene Wörter: 45 (+12 seit letzter Woche)   │
│ ⭐ Sterne gesammelt: 128                               │
│ 📅 Tägliche Nutzung: 6/7 Tage                         │
│ 🎯 Erfolgsrate: 78% (↑5%)                             │
│                                                        │
│ ─────────────────────────────────────                  │
│                                                        │
│ 🎓 Aktuelles Lern-Ziel: S-Laut Meisterung             │
│ Fortschritt: ████████░░ 82%                           │
│                                                        │
│ ⚠️ Hinweis vom System:                                │
│ "Emir hat Schwierigkeiten mit SCH-Laut.               │
│  Empfehlung: Zusätzliche Lippen-Übungen"              │
│                                                        │
└────────────────────────────────────────────────────────┘
```

#### B) Detaillierte Analysen
- **Phonem-Heatmap:** Welche Laute sind schwierig? (Grün=gut, Rot=schwierig)
- **Zeitverlauf-Diagramme:** Verbesserung über Wochen/Monate
- **Wort-Bibliothek:** Liste aller gelernten Wörter mit Erfolgsraten
- **Aufnahmen:** Höre dir Emirs Aussprache-Entwicklung an (Datenschutz-konform)

#### C) Anpassungen
- **Übungs-Zuweisung:** Füge Wörter hinzu, die der Logopäde empfohlen hat
- **Schwierigkeit:** Manuell anpassen (leichter/schwerer)
- **Stimmen-Wahl:** Wechsle zwischen Mama/Papa-Stimme
- **Zeitlimits:** Setze tägliche Übungszeit (z.B. max. 20 Min)

#### D) Integration mit Profis
- **PDF-Export:** Teile Fortschritts-Bericht mit Logopäden/Audiologen
- **Audiogramm-Upload:** AI analysiert und passt App an (Gemini Vision)
- **Notizen-Feld:** Füge Empfehlungen vom Therapeuten hinzu

---

### 🦻 Feature 6: Audiogramm-Integration

**Basierend auf Lianko's AI Audiogramm Reader**

**Workflow:**
```
1. Eltern fotografieren Audiogramm vom HNO-Arzt
   ↓
2. Gemini Vision AI extrahiert dB-Werte
   (250Hz: 60dB links, 70dB rechts usw.)
   ↓
3. System berechnet optimale Einstellungen:
   - Sprechgeschwindigkeit: 0.3x
   - Pitch: -10%
   - Untertitel: Immer AN
   - Textgröße: 1.3x
   ↓
4. App passt sich automatisch an
```

**Vorteile:**
- **Präzise Anpassung:** Basiert auf medizinischen Daten, nicht Schätzungen
- **Zeit-sparen:** Keine manuelle Eingabe nötig
- **Professionell:** Audiogramme sind WHO-Standard
- **Verlaufs-Tracking:** Vergleiche Audiogramme über Zeit (bei neuen Messungen)

---

## 4. Technologie-Stack

### Core Technologies

| Komponente | Technologie | Zweck | Kosten |
|------------|-------------|-------|--------|
| **App Framework** | Flutter 3.10+ | iOS & Android aus einem Codebase | Kostenlos |
| **Speech-to-Text** | OpenAI Whisper Large-v3 | Sprach-Erkennung & Analyse | Kostenlos (open-source) |
| **Text-to-Speech** | ElevenLabs Voice Cloning | Personalisierte Stimme | €5-22/Monat |
| **AI Logic** | SpeechBrain + PyTorch | Adaptive Lern-Algorithmen | Kostenlos (open-source) |
| **Vision AI** | Google Gemini 1.5 Flash | Audiogramm-Analyse | €0.01/Bild (~gratis) |
| **Backend** | Firebase (Firestore, Auth) | Datenbank, Auth, Hosting | Gratis-Tier ausreichend |
| **State Management** | Flutter Riverpod | Reactive UI-Updates | Kostenlos |
| **Audio Processing** | flutter_sound, audio_session | Mikrofon-Zugriff | Kostenlos |

### Architektur-Diagramm

```
┌─────────────────────────────────────────────────────────┐
│                   FLUTTER APP (UI)                      │
│  ┌──────────────────────────────────────────────────┐   │
│  │  Screens: Home, Übungen, Spiele, Fortschritt    │   │
│  └──────────────────────────────────────────────────┘   │
│                         ↕                               │
│  ┌──────────────────────────────────────────────────┐   │
│  │    Services (Business Logic)                     │   │
│  │  - SpeechTrainingService (Whisper)               │   │
│  │  - TTSService (ElevenLabs)                       │   │
│  │  - AdaptiveLearningService (SpeechBrain API)     │   │
│  │  - AudiogramService (Gemini)                     │   │
│  │  - RewardService (Gamification)                  │   │
│  └──────────────────────────────────────────────────┘   │
└───────────────────────┬─────────────────────────────────┘
                        ↕
┌───────────────────────┴─────────────────────────────────┐
│               BACKEND (Python Flask API)                │
│  ┌──────────────────────────────────────────────────┐   │
│  │  SpeechBrain Models:                             │   │
│  │  - Speech Recognition                            │   │
│  │  - Phoneme Analysis                              │   │
│  │  - Adaptive Algorithm                            │   │
│  └──────────────────────────────────────────────────┘   │
└───────────────────────┬─────────────────────────────────┘
                        ↕
┌───────────────────────┴─────────────────────────────────┐
│              FIREBASE (Cloud Services)                  │
│  - Firestore: User-Profile, Fortschritt, Übungen       │
│  - Storage: Audio-Aufnahmen (verschlüsselt)             │
│  - Auth: Eltern-Login                                   │
│  - Analytics: Nutzungs-Statistiken (DSGVO-konform)      │
└─────────────────────────────────────────────────────────┘
```

### Warum dieser Stack?

**1. OpenAI Whisper statt Google Speech-to-Text:**
- ✅ Bessere Genauigkeit bei Kinderstimmen
- ✅ Fine-Tuning möglich für Hörbehinderung
- ✅ Kostenlos & open-source
- ✅ Läuft on-device (Datenschutz)
- ❌ Höherer Rechenaufwand (aber Flutter kann das)

**2. ElevenLabs statt Google TTS:**
- ✅ Voice Cloning = emotionale Bindung
- ✅ Beste Natürlichkeit (klingt menschlich)
- ✅ Bosnisch-Unterstützung
- ❌ Kostenpflichtig (~€10/Monat für Hobby-Projekt)

**3. SpeechBrain statt Custom ML:**
- ✅ Production-ready Models für Speech
- ✅ Active Community & Updates
- ✅ Integration mit Whisper
- ❌ Lernkurve für Setup

**4. Flutter statt React Native:**
- ✅ Bessere Performance (native compilation)
- ✅ Einfacheres Audio-Handling
- ✅ Lianko-App ist bereits in Flutter → Code-Wiederverwendung

---

## 5. Unterschiede zu Lianko

| Feature | Lianko (Allgemein) | Terapko (Therapie-fokussiert) |
|---------|-------------------|-------------------------------|
| **Zielgruppe** | Alle schwerhörigen Kinder (3-12) | Spezifisch 4-Jährige mit 60-70% Verlust |
| **Sprachen** | 6 Sprachen (BS, DE, EN...) | Nur Bosnisch (Fokus > Breite) |
| **Speech Recognition** | flutter_tts (basic) | OpenAI Whisper (advanced) |
| **TTS** | System-Stimmen | ElevenLabs Voice Cloning |
| **Adaptive Learning** | Alters-basiert | AI-basiert (SpeechBrain) |
| **Gamification** | Basis (Sterne) | Umfangreich (Story, Charaktere, Museum) |
| **Therapie-Integration** | Keine | PDF-Export, Logopäden-Notizen |
| **Phonem-Analyse** | Keine | Detailliert (welche Laute sind schwierig) |
| **Eltern-Dashboard** | Basic Stats | Umfangreich (Heatmaps, Empfehlungen) |
| **Audiogramm-AI** | Ja (Gemini) | Ja + optimierte Anpassungen |

**Code-Wiederverwendung von Lianko:**
- ✅ `speech_training_service.dart` → Basis für neuen Service
- ✅ `audiogram_model.dart` → Vollständig wiederverwenden
- ✅ `ai_audiogram_reader_service.dart` → Anpassen
- ✅ `age_adaptive_service.dart` → Erweitern mit SpeechBrain-Logik
- ✅ UI-Komponenten: Untertitel, Buttons, Animationen

---

## 6. Erfolgs-Metriken

### Primäre Metriken (Kind-fokussiert)
| Metrik | Baseline | Ziel nach 3 Monaten | Messmethode |
|--------|----------|---------------------|-------------|
| **Aktiver Wortschatz** | 10-15 Wörter | 50+ Wörter | Parent-Report + App-Tracking |
| **Aussprache-Genauigkeit** | Unbekannt | >70% | Whisper Confidence Score |
| **Tägliche Nutzung** | 0 Min | 10 Min/Tag | App Analytics |
| **Selbstständigkeit** | 0% (braucht Hilfe) | 80% (arbeitet alleine) | Parent Feedback |

### Sekundäre Metriken (Engagement)
| Metrik | Ziel |
|--------|------|
| Tägliche Rückkehrrate (Day 7) | >60% |
| Durchschnittliche Session-Länge | 8-12 Min |
| Übungs-Completion-Rate | >75% |
| Eltern-Dashboard-Nutzung | >3x/Woche |

### Qualitative Metriken
- **Kind-Zufriedenheit:** "Will er freiwillig üben?" (Eltern-Befragung)
- **Therapeuten-Feedback:** "Sehen Logopäden Verbesserungen?"
- **Eltern-Entlastung:** "Fühlen sich Eltern unterstützt?"

---

## 7. Risiken & Mitigation

| Risiko | Wahrscheinlichkeit | Impact | Mitigation |
|--------|-------------------|--------|------------|
| **Whisper erkennt schwerhörige Aussprache nicht gut** | HOCH | HOCH | Fine-Tuning auf Hörbehinderungs-Datensatz |
| **Kind verliert Interesse nach 2 Wochen** | MITTEL | HOCH | A/B-Testing von Gamification-Elementen |
| **ElevenLabs zu teuer für Skalierung** | NIEDRIG | MITTEL | Start mit Free-Tier, später zu Open-Source-TTS |
| **Datenschutz-Bedenken (Stimm-Aufnahmen)** | MITTEL | HOCH | On-Device Whisper, verschlüsselte Firebase-Storage |
| **Technische Überforderung (Setup zu komplex)** | MITTEL | MITTEL | Einfacher Onboarding-Wizard, Video-Tutorials |

---

## 8. Nächste Schritte (Roadmap-Überblick)

### Phase 1: MVP (Wochen 1-4)
- [ ] Flutter-Projekt Setup (basierend auf Lianko)
- [ ] Whisper-Integration (on-device)
- [ ] ElevenLabs Voice Cloning Setup
- [ ] Basis-Übungen (10 bosnische Wörter)
- [ ] Einfaches Belohnungs-System

### Phase 2: Gamification (Wochen 5-8)
- [ ] Terapko-Charakter Design & Animation
- [ ] Story-Modus & Level-System
- [ ] Mini-Spiele (Memory, Puzzle)
- [ ] Sammlung/Museum-Feature

### Phase 3: AI & Adaptive Learning (Wochen 9-12)
- [ ] SpeechBrain Backend-Setup
- [ ] Adaptive Schwierigkeits-Algorithmus
- [ ] Phonem-Analyse & Visualisierung
- [ ] Automatische Übungs-Generierung

### Phase 4: Eltern-Dashboard (Wochen 13-16)
- [ ] Fortschritts-Dashboard
- [ ] PDF-Export für Therapeuten
- [ ] Übungs-Anpassung durch Eltern
- [ ] Benachrichtigungs-System

### Phase 5: Polish & Launch (Wochen 17-20)
- [ ] Usability-Testing mit Zielgruppe
- [ ] Performance-Optimierung
- [ ] App-Store Submission
- [ ] Marketing-Material

**Detaillierte Roadmap siehe:** `IMPLEMENTIERUNGS_ROADMAP.md`

---

## 9. Kontakt & Ressourcen

**Projekt-Owner:** Emir's Familie  
**Entwickler:** [Name einfügen]  
**Technischer Berater:** AI/ML Expert (bei Bedarf)

**Wichtige Links:**
- GitHub Repo: [Link einfügen]
- Lianko Codebase: `/workspace/`
- Firebase Console: [Link einfügen]
- ElevenLabs Account: [Link einfügen]

**Dokumentation:**
- [TECHNISCHE_ARCHITEKTUR.md](./TECHNISCHE_ARCHITEKTUR.md) - Detaillierte Tech-Specs
- [GAMIFICATION_KONZEPT.md](./GAMIFICATION_KONZEPT.md) - Game-Design Dokumentation
- [BOSNISCHE_INHALTE.md](./BOSNISCHE_INHALTE.md) - Content-Bibliothek
- [DATENSCHUTZ_SICHERHEIT.md](./DATENSCHUTZ_SICHERHEIT.md) - DSGVO & Sicherheit
- [IMPLEMENTIERUNGS_ROADMAP.md](./IMPLEMENTIERUNGS_ROADMAP.md) - Entwicklungs-Zeitplan

---

**Letztes Update:** 17. Dezember 2025  
**Version:** 1.0  
**Status:** 📝 Planungsphase

---

*"Jedes Kind hat das Recht, seine Stimme zu finden. Terapko AI hilft ihnen dabei - spielerisch, wissenschaftlich fundiert und mit Herz."* ❤️
