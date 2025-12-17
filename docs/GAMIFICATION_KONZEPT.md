# 🎮 Gamification & Motivation-Konzept - Terapko AI

**Version:** 1.0  
**Datum:** 17. Dezember 2025  
**Ziel:** Tägliche Motivation für 4-jährige Kinder mit Hörbehinderung

---

## 📋 Inhaltsverzeichnis

1. [Design-Prinzipien](#design-prinzipien)
2. [Haupt-Charakter: Terapko](#haupt-charakter-terapko)
3. [Story & Narrative](#story--narrative)
4. [Belohnungs-System](#belohnungs-system)
5. [Progression-System](#progression-system)
6. [Mini-Spiele](#mini-spiele)
7. [Soziale Features](#soziale-features)
8. [Tägliche Rituale](#tägliche-rituale)

---

## 1. Design-Prinzipien

### Kern-Prinzipien für 4-Jährige

| Prinzip | Beschreibung | Umsetzung |
|---------|--------------|-----------|
| **Sofortige Belohnung** | Kind sieht sofort Erfolg | Stern-Animation nach jedem richtigen Wort |
| **Visuell > Text** | Wenig Text, viele Bilder/Emojis | Große Icons, animierte Charaktere |
| **Fehler-Toleranz** | Fehler sind ok, keine Bestrafung | "Fast richtig!" statt "Falsch!" |
| **Einfache Navigation** | Max. 2-3 Klicks zum Ziel | Große Buttons, klare Wege |
| **Kurze Sessions** | 5-10 Minuten pro Session | Auto-Pause nach 10 Min |
| **Eltern-Stimme** | Vertraute Stimme = Motivation | ElevenLabs Voice Cloning |

### Psychologische Frameworks

**1. Flow-Theorie (Csikszentmihalyi):**
- Schwierigkeit muss Challenge-Skill-Balance haben
- Zu leicht → langweilig
- Zu schwer → frustrierend
- **Lösung:** Adaptive Schwierigkeit via SpeechBrain

```
         ┌──────────────────────────┐
         │      ANGST               │
         │   (zu schwierig)         │
         ├──────────────────────────┤
         │                          │
    H    │      🎯 FLOW             │  ← Optimal!
    Ö    │   (perfekte Balance)     │
    H    │                          │
    E    ├──────────────────────────┤
         │     LANGEWEILE           │
         │   (zu leicht)            │
         └──────────────────────────┘
              FÄHIGKEITEN →
```

**2. Self-Determination Theory (Deci & Ryan):**
- **Autonomy:** Kind wählt selbst (welche Übung, welches Spiel)
- **Competence:** Kind fühlt sich kompetent (Erfolge werden gefeiert)
- **Relatedness:** Kind fühlt sich verbunden (Mama-Stimme, Terapko als Freund)

**3. Variable Reward Schedule (BF Skinner):**
- Nicht jede Übung gleich belohnen
- Manchmal 1 Stern, manchmal 3, manchmal Bonus-Item
- **Effekt:** Höhere Motivation durch Unvorhersehbarkeit

---

## 2. Haupt-Charakter: Terapko

### 2.1 Character Design

**Name:** Terapko (Bosnisch: "Therapie-Kumpel")

**Aussehen-Optionen:**

**Option 1: Freundlicher Roboter** 🤖
- Runder, kindlicher Körper
- Große Augen (expressiv)
- Flexible Arme (für Gesten)
- Farbe: Blau/Türkis (beruhigend)
- Accessoires: Kopfhörer (Symbol für Hören)

**Option 2: Magisches Tier** 🦊
- Fuchs oder Hund (loyal, freundlich)
- Große Ohren (Symbol für gutes Hören)
- Flauschiges Fell
- Farbe: Orange/Braun
- Accessoires: Kleine Kristalle am Halsband

**Option 3: Hybrid** 🤖🦊
- Roboter mit Tier-Features
- Mechanische Ohren, die bewegen
- LED-Augen (ändern Farbe bei Emotionen)

**Empfehlung:** **Option 1 (Roboter)** - Vielseitig, anpassbar, technologisch passend

### 2.2 Terapko's Persönlichkeit

| Eigenschaft | Beschreibung | Beispiel-Dialog |
|-------------|--------------|-----------------|
| **Geduldig** | Wird nie wütend | "Kein Problem! Lass uns es nochmal versuchen." |
| **Ermutigend** | Immer positiv | "Du bist so mutig! Ich bin stolz auf dich!" |
| **Neugierig** | Stellt Fragen | "Wow, was ist dein Lieblings-Tier?" |
| **Lustig** | Macht Witze | "Ich habe Hunger... auf mehr Zvuk-Kristalle! 😄" |
| **Verletzlich** | Braucht Hilfe | "Hilfst du mir, die Kristalle zu finden?" |

### 2.3 Terapko's Animationen

**Idle Animations:**
- Blinzeln (alle 3-5 Sekunden)
- Atmen (sanfte Auf-Ab-Bewegung)
- Kopf-Drehen (schaut sich um)
- Winken (wenn Kind lange nicht interagiert)

**Reaktions-Animationen:**
- **Erfolg:** Jubeln, Arme hoch, Sterne um Kopf ⭐
- **Fast richtig:** Nicken, Daumen hoch 👍
- **Fehler:** Kopf kratzen, aufmunternder Blick 🤔
- **Warten:** Auf Uhr schauen, geduldig lächeln 🕐

**Spezial-Animationen:**
- **Level-Up:** Konfetti, tanzen, größer werden 🎉
- **Neues Item:** Auspacken, staunen, anprobieren 🎁

**Technische Umsetzung:**
- **Tool:** Rive oder Lottie (Flutter)
- **Format:** .riv oder .json
- **Performance:** Max. 60 FPS, optimiert für Mobile

```dart
// Beispiel: Rive Animation
import 'package:rive/rive.dart';

class TerapkoCharacter extends StatefulWidget {
  final TerapkoEmotion emotion;

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      'assets/animations/terapko.riv',
      artboard: 'Terapko',
      animations: [_getAnimationForEmotion(emotion)],
      fit: BoxFit.contain,
    );
  }

  String _getAnimationForEmotion(TerapkoEmotion emotion) {
    switch (emotion) {
      case TerapkoEmotion.happy: return 'celebrate';
      case TerapkoEmotion.encouraging: return 'thumbs_up';
      case TerapkoEmotion.thinking: return 'head_scratch';
      case TerapkoEmotion.waiting: return 'idle';
    }
  }
}
```

---

## 3. Story & Narrative

### 3.1 Haupt-Story: "Die verlorenen Zvuk-Kristalle"

**Backstory:**
> Terapko kommt aus dem Land der Klänge (Zemlja Zvukova), wo alle Töne als Kristalle existieren. Eines Tages hat ein starker Wind die Kristalle über die ganze Welt verstreut. Terapko braucht Emirs Hilfe, um sie zurückzuholen - indem Emir lernt, jeden Klang perfekt auszusprechen!

**Haupt-Ziel:**
- Sammle alle 100 Zvuk-Kristalle
- Jeder Kristall = ein perfekt gelerntes Wort
- Am Ende: Terapko kann nach Hause zurückkehren (aber bleibt Emirs Freund)

**Warum diese Story?**
- ✅ Klare Mission (Kristalle sammeln)
- ✅ Emotionale Bindung (Terapko braucht Hilfe)
- ✅ Passend zum Thema (Klänge/Laute)
- ✅ Open-ended (kann erweitert werden)

### 3.2 Welten & Level

**5 Welten mit je 20 Kristallen:**

#### Welt 1: Sunčana Livada (Sonnen-Wiese) 🌻
- **Theme:** Natur, Tiere, einfache Worte
- **Farben:** Grün, Gelb, Blau
- **Wörter:** sonce (Sonne), cvijet (Blume), pas (Hund), mačka (Katze)
- **Boss-Level:** Sammle 20 Tier-Laute

#### Welt 2: Plava Šuma (Blauer Wald) 🌲
- **Theme:** Wald, Farben, Zahlen
- **Farben:** Grün, Braun, Blau
- **Wörter:** drvo (Baum), list (Blatt), jedan (eins), dva (zwei)
- **Boss-Level:** Zähle bis 10 mit perfekter Aussprache

#### Welt 3: Grad Riječi (Stadt der Worte) 🏙️
- **Theme:** Stadt, Familie, Aktivitäten
- **Farben:** Grau, Rot, Orange
- **Wörter:** kuća (Haus), mama, tata, auto (Auto)
- **Boss-Level:** Beschreibe deine Familie

#### Welt 4: Magična Plaža (Magischer Strand) 🏖️
- **Theme:** Strand, Wasser, Essen
- **Farben:** Blau, Gelb, Weiß
- **Wörter:** more (Meer), riba (Fisch), voda (Wasser), hrana (Essen)
- **Boss-Level:** Bestelle Essen im Restaurant

#### Welt 5: Zvjezdana Góra (Sternen-Berg) ⛰️
- **Theme:** Berge, Wetter, Gefühle
- **Farben:** Grau, Weiß, Lila
- **Wörter:** snijeg (Schnee), kiša (Regen), sretan (glücklich)
- **Boss-Level:** Erzähle eine kurze Geschichte

### 3.3 Story-Elemente in der App

**Story-Sequenzen (nach jedem 5. Kristall):**
```
Emir hat 5 Kristalle gesammelt!

Terapko: "Wow! Du hast 5 Kristalle! Schau, sie leuchten!"
         [Animation: Kristalle schweben und leuchten]
         "Weißt du was? Diese Kristalle machen mich stärker!"
         [Terapko wird etwas größer/heller]
         "Lass uns weitermachen! Zusammen schaffen wir das!"
         
         [Button: Weiter zum nächsten Abenteuer! →]
```

**Welt-Übergänge:**
```
Du hast alle 20 Kristalle in Sunčana Livada gesammelt!

[Cinematic: Terapko und Emir reisen zur nächsten Welt]
[Kurzes Video/Animation: Flug über Landschaft]

Terapko: "Wow! Schau mal - Plava Šuma!"
         "Hier sind noch mehr Kristalle versteckt!"
         "Bist du bereit für das nächste Abenteuer?"
         
         [Button: Los geht's! 🚀]
```

---

## 4. Belohnungs-System

### 4.1 Belohnungs-Pyramide

```
                    🏆 Legendary Items
                   (nach 1000 Sternen)
                  ____________________
                 /                    \
                /   🎖️ Badges/Erfolge  \
               /    (nach Meilensteinen) \
              /____________________________\
             /                              \
            /    ⭐ Sterne (Haupt-Währung)    \
           /      (nach jeder Übung)           \
          /________________________________________\
```

### 4.2 Sterne-System ⭐

**Wie verdienen:**
| Aktion | Sterne |
|--------|--------|
| Wort perfekt (>90% Score) | 3 ⭐⭐⭐ |
| Wort gut (70-90% Score) | 2 ⭐⭐ |
| Wort ok (50-70% Score) | 1 ⭐ |
| Wort wiederholt nach Fehler | 1 ⭐ |
| 5 Übungen hintereinander | +5 Bonus ⭐ |
| Tägliche Übung (Streak) | +10 Bonus ⭐ |

**Wofür ausgeben:**
- **Terapko Outfits:** 50 ⭐ (Cowboy-Hut, Pirat, Astronaut)
- **Hintergründe:** 30 ⭐ (Weltraum, Unterwasser, Regenbogen)
- **Mini-Spiele freischalten:** 100 ⭐
- **Spezial-Animationen:** 20 ⭐ (Feuerwerk, Konfetti)

### 4.3 Badges & Achievements 🏅

**Kategorien:**

**A) Lern-Badges:**
| Badge | Bedingung | Icon |
|-------|-----------|------|
| S-Laut Anfänger | 10 S-Wörter gelernt | 🐍 |
| S-Laut Profi | 50 S-Wörter perfekt | 🐍✨ |
| S-Laut Meister | 100 S-Wörter @ >90% | 🐍👑 |
| Sch-Laut Anfänger | 10 Sch-Wörter | 🐠 |
| Alphabet-Entdecker | Alle Buchstaben geübt | 🔤 |
| Wort-Sammler | 50 Wörter gelernt | 📚 |
| Sprach-Künstler | 100 Wörter @ >95% | 🎨 |

**B) Streak-Badges:**
| Badge | Bedingung | Icon |
|-------|-----------|------|
| 3-Tage-Krieger | 3 Tage in Folge geübt | 🔥 |
| Wochen-Champion | 7 Tage Streak | 🔥🔥 |
| Monats-Legende | 30 Tage Streak | 🔥🔥🔥 |
| Früh-Vogel | 5x vor 10 Uhr geübt | 🐦 |
| Nacht-Eule | 5x nach 20 Uhr geübt | 🦉 |

**C) Spezial-Badges:**
| Badge | Bedingung | Icon |
|-------|-----------|------|
| Perfektionist | 10 Übungen @ 100% | 💯 |
| Geduldiger Lerner | 20x "Nochmal" gedrückt | 🧘 |
| Entdecker | Alle Welten besucht | 🗺️ |
| Terapko's BFF | 100 Sessions mit Terapko | 💙 |
| Hilfsbereit | Anderen beim Lernen geholfen (Familien-Feature) | 🤝 |

### 4.4 Wort-Museum 🏛️

**Konzept:** Jedes gelernte Wort wird als "Sammelkarte" im Museum ausgestellt.

**UI-Design:**
```
┌────────────────────────────────────────────────────┐
│  🏛️ Mein Zvuk-Museum                               │
│                                                    │
│  Gesammelt: 45/100 Wörter                         │
│  [████████████░░░░░░░░░░░░] 45%                   │
│                                                    │
│  ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐             │
│  │  🌞  │ │  🐕  │ │  🐈  │ │  🏠  │             │
│  │SONCE │ │ PAS  │ │MAČKA │ │ KUĆA │             │
│  │ ⭐⭐⭐ │ │ ⭐⭐⭐ │ │ ⭐⭐  │ │ ⭐⭐⭐ │             │
│  └──────┘ └──────┘ └──────┘ └──────┘             │
│                                                    │
│  ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐             │
│  │  ???  │ │  ???  │ │  ???  │ │  ???  │             │
│  │  ??   │ │  ??   │ │  ??   │ │  ??   │             │
│  │       │ │       │ │       │ │       │             │
│  └──────┘ └──────┘ └──────┘ └──────┘             │
│  [Noch nicht freigeschaltet]                      │
│                                                    │
│  [Filter: Alle ▾] [Sortieren: Neueste ▾]         │
└────────────────────────────────────────────────────┘
```

**Karten-Details (wenn angeklickt):**
```
┌────────────────────────────────────────────────────┐
│             🌞 SONCE (Sonne)                       │
│                                                    │
│  Kategorie: Natur                                 │
│  Phoneme: S-O-N-C-E                               │
│  Schwierigkeit: ★★☆                               │
│                                                    │
│  Deine Statistik:                                 │
│  ├─ Erste Lernung: 15.12.2025                    │
│  ├─ Geübt: 12x                                    │
│  ├─ Erfolgsrate: 92%                              │
│  └─ Best Score: 98%                               │
│                                                    │
│  [🔊 Anhören]  [📝 Nochmal üben]                  │
│                                                    │
│  💬 Terapko sagt:                                 │
│  "Dieses Wort kannst du super! Gut gemacht!"     │
└────────────────────────────────────────────────────┘
```

---

## 5. Progression-System

### 5.1 Level-System

**Gesamt: 20 Level (je 5 Kristalle pro Level)**

```
Level 1: Beginner       (0-5 Kristalle)    → Unlock: Sunčana Livada
Level 2: Novice         (6-10)              → Unlock: Memory-Spiel
Level 3: Apprentice     (11-15)             → Unlock: Neue Terapko-Outfits
Level 4: Learner        (16-20)             → Unlock: Plava Šuma
Level 5: Advanced       (21-25)             → Unlock: Puzzle-Spiel
...
Level 18: Expert        (86-90)             → Unlock: Bonus-Welten
Level 19: Master        (91-95)             → Unlock: Alle Features
Level 20: Grandmaster   (96-100)            → Unlock: Spezial-Zertifikat
```

**Level-Up Animation:**
```dart
class LevelUpAnimation extends StatelessWidget {
  final int newLevel;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      child: Stack(
        children: [
          // Hintergrund: Glühender Effekt
          AnimatedGlow(),
          
          // Terapko wächst
          AnimatedTerapko(scale: 1.2),
          
          // Level-Up Text
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'LEVEL UP!',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Level $newLevel',
                  style: TextStyle(fontSize: 36),
                ),
                SizedBox(height: 32),
                // Neue Freischaltungen
                UnlockCard(
                  icon: '🎮',
                  title: 'Neues Mini-Spiel!',
                  description: 'Memory-Spiel freigeschaltet',
                ),
              ],
            ),
          ),
          
          // Konfetti
          ConfettiAnimation(),
          
          // Sounds
          AudioPlayer.play('level_up_fanfare.mp3'),
        ],
      ),
    );
  }
}
```

### 5.2 Fortschritts-Visualisierung

**Haupt-Screen:**
```
┌────────────────────────────────────────────────────┐
│  Dobro jutro Emir! 👋                              │
│                                                    │
│  🌟 Level 3: Apprentice                           │
│  [████████████░░░░░░░░░░░░] 15/20 Kristalle       │
│                                                    │
│  ⭐ Sterne: 285                                    │
│  🏅 Badges: 5                                      │
│  🔥 Streak: 7 Tage                                │
│                                                    │
│  ┌──────────────────────────────────────────────┐ │
│  │  🎯 Heute's Mission:                         │ │
│  │  ✅ 3 Übungen machen (2/3)                   │ │
│  │  ⬜ Memory-Spiel spielen                     │ │
│  │  ⬜ 1 neues Wort lernen                      │ │
│  └──────────────────────────────────────────────┘ │
│                                                    │
│  [🚀 Übung starten]  [🎮 Spiele]  [🏛️ Museum]   │
└────────────────────────────────────────────────────┘
```

**Welt-Karte:**
```
┌────────────────────────────────────────────────────┐
│                   🗺️ Welten                        │
│                                                    │
│     🌻 Sunčana Livada                             │
│     [████████████████████] 20/20 ✅                │
│           │                                        │
│           ↓                                        │
│     🌲 Plava Šuma                                 │
│     [████████░░░░░░░░░░░░] 8/20 ← Du bist hier   │
│           │                                        │
│           ↓                                        │
│     🏙️ Grad Riječi                                │
│     [░░░░░░░░░░░░░░░░░░░░] 0/20 🔒 Gesperrt       │
│           │                                        │
│           ↓                                        │
│     🏖️ Magična Plaža                              │
│     [░░░░░░░░░░░░░░░░░░░░] 0/20 🔒                │
│           │                                        │
│           ↓                                        │
│     ⛰️ Zvjezdana Góra                             │
│     [░░░░░░░░░░░░░░░░░░░░] 0/20 🔒                │
│                                                    │
│  [Zurück]                                          │
└────────────────────────────────────────────────────┘
```

---

## 6. Mini-Spiele

### 6.1 Übersicht

| Spiel | Zweck | Freischaltung | Dauer |
|-------|-------|---------------|-------|
| **Memory Match** | Wort-Bild-Zuordnung | Level 2 | 3-5 Min |
| **Zvuk Puzzle** | Phoneme zusammensetzen | Level 5 | 5 Min |
| **Sprach-Rennbahn** | Schnelles Sprechen | Level 8 | 2 Min |
| **Terapko's Schatzsuche** | Versteckte Wörter finden | Level 10 | 5 Min |
| **Silben-Baumeister** | Silben zu Wörtern | Level 12 | 5 Min |

### 6.2 Memory Match 🎴

**Gameplay:**
1. 6 Karten-Paare (Wort ↔ Bild)
2. Kind spricht Wort aus → Karte dreht sich um
3. Wenn richtig ausgesprochen → Karte bleibt offen
4. Finde alle Paare!

**Beispiel:**
```
[SONCE] ↔ [🌞]
[PAS]   ↔ [🐕]
[MAČKA] ↔ [🐈]
...
```

**Variationen:**
- **Leicht:** 3 Paare, bekannte Wörter
- **Mittel:** 6 Paare, gemischte Wörter
- **Schwer:** 8 Paare, neue Wörter

**Belohnung:**
- +10 ⭐ für jedes gefundene Paar
- +50 ⭐ Bonus wenn alle Paare gefunden

### 6.3 Zvuk Puzzle 🧩

**Gameplay:**
1. Ein Wort wird in Phoneme zerlegt: S-O-N-C-E
2. Kind zieht Phoneme in richtige Reihenfolge
3. Spricht jedes Phonem aus beim Platzieren
4. Am Ende: Ganzes Wort aussprechen

**UI:**
```
┌────────────────────────────────────────┐
│  Baue das Wort: 🌞                     │
│                                        │
│  [  ] [  ] [  ] [  ] [  ]             │
│   ↑                                    │
│  Ziehe Buchstaben hier hin!           │
│                                        │
│  Verfügbare Phoneme:                  │
│  ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐       │
│  │ E │ │ S │ │ N │ │ O │ │ C │       │
│  └───┘ └───┘ └───┘ └───┘ └───┘       │
│                                        │
│  [Zurücksetzen] [Prüfen]              │
└────────────────────────────────────────┘
```

**Belohnung:**
- +5 ⭐ pro richtigem Phonem
- +20 ⭐ wenn Wort komplett richtig

### 6.4 Sprach-Rennbahn 🏁

**Gameplay:**
1. Terapko fährt Rennen gegen die Zeit
2. Kind spricht Wörter aus → Terapko fährt schneller
3. Je besser Aussprache, desto schneller
4. Ziel: Finish-Linie vor Zeit-Ablauf

**UI:**
```
┌────────────────────────────────────────┐
│  ⏱️ Zeit: 1:45                         │
│                                        │
│  ═══════════════════════════════════   │
│  🤖 ─────────────────────→ 🏁         │
│  👻 ─────────────→                     │
│  ═══════════════════════════════════   │
│                                        │
│  Sage laut: SONCE 🌞                   │
│                                        │
│  [🎤 Aufnehmen]                        │
│                                        │
│  Punkte: 45                            │
└────────────────────────────────────────┘
```

**Belohnung:**
- +10 ⭐ pro Wort
- +100 ⭐ wenn Rennen gewonnen

### 6.5 Silben-Baumeister 🏗️

**Gameplay:**
1. Kind bekommt Silben: SO, NCA, KO
2. Muss daraus Wörter bauen: SON-CE, KO-...
3. Spricht jede Silbe aus
4. Baut Turm: Je mehr Wörter, desto höher Turm

**Belohnung:**
- +15 ⭐ pro Wort
- +50 ⭐ wenn Turm komplett

---

## 7. Soziale Features

### 7.1 Familien-Dashboard

**Für Eltern/Geschwister:**

```
┌────────────────────────────────────────────────────┐
│  👨‍👩‍👦 Familien-Bereich                                │
│                                                    │
│  Emir's Fortschritt heute:                        │
│  ✅ 5 Übungen gemacht                              │
│  ⭐ 15 Sterne gesammelt                            │
│  🏅 1 neues Badge: "3-Tage-Krieger"                │
│                                                    │
│  ┌──────────────────────────────────────────────┐ │
│  │  📹 Emir's beste Aufnahmen                   │ │
│  │                                              │ │
│  │  [▶️ SONCE - 98% Genauigkeit]                │ │
│  │  [▶️ KUĆA - 95% Genauigkeit]                 │ │
│  │                                              │ │
│  │  [Teilen]  [Herunterladen]                  │ │
│  └──────────────────────────────────────────────┘ │
│                                                    │
│  💬 Nachricht an Emir senden:                     │
│  ┌──────────────────────────────────────────────┐ │
│  │ "Tolles Job heute, mein Schatz! Ich bin so  │ │
│  │  stolz auf dich! ❤️"                         │ │
│  └──────────────────────────────────────────────┘ │
│  [Senden]                                          │
│                                                    │
│  📊 [Detaillierte Statistiken ansehen]            │
└────────────────────────────────────────────────────┘
```

**Kind sieht:**
```
[Benachrichtigung]
💌 Neue Nachricht von Mama!

"Tolles Job heute, mein Schatz! Ich bin so stolz auf dich! ❤️"

[Mama eine Sprachnachricht zurück schicken 🎤]
```

### 7.2 Meilenstein-Benachrichtigungen

**Push-Notifications an Eltern:**
- "🎉 Emir hat heute 10 Wörter perfekt gesprochen!"
- "🏅 Emir hat ein neues Badge verdient: S-Laut Meister!"
- "🔥 7-Tage-Streak! Emir ist super motiviert!"
- "⚠️ Hinweis: Emir hat Schwierigkeiten mit SCH-Laut. Vielleicht mit Logopädin besprechen?"

### 7.3 Virtuelle High-Fives 🙌

**Feature:**
- Nach Übung: "Gib Mama einen High-Five!"
- Kind klickt auf Button
- Eltern bekommen Benachrichtigung + Vibration (wenn in der Nähe)
- Eltern können zurück-high-fiven

**UI:**
```
Emir hat dir einen High-Five gesendet! 🙌

[High-Five zurück! 👋]
```

---

## 8. Tägliche Rituale

### 8.1 Morgen-Routine (09:00)

```
[App öffnet]

Terapko: "Dobro jutro Emir! 🌅"
         "Ich habe heute ein besonderes Abenteuer für dich!"
         "Bist du bereit?"

[Animation: Sonne geht auf, Vögel zwitschern]

Terapko: "Lass uns mit einem Aufwärm-Spiel starten!"

[Mini-Game: 3 einfache Wörter zum Aufwärmen]

Terapko: "Super! Du bist bereit! Auf geht's!"

[Weiter zur Haupt-Übung]
```

### 8.2 Mittag-Check (14:00)

```
[Notification]

Terapko: "Hej Emir! 👋"
         "Hast du Lust auf ein schnelles Spiel?"
         "Nur 5 Minuten! 🎮"

[Button: Ja, gerne! | Später]
```

### 8.3 Abend-Zusammenfassung (19:00)

```
Terapko: "Wow, was für ein Tag! 🌟"
         "Lass uns schauen, was du heute geschafft hast:"

[Animation: Fortschritts-Zusammenfassung]

│ Heute hast du:
│ ✅ 8 Übungen gemacht
│ ⭐ 24 Sterne gesammelt
│ 🏅 1 Badge verdient
│ 📚 3 neue Wörter gelernt

Terapko: "Ich bin so stolz auf dich!"
         "Morgen geht's weiter! Bis dann! 👋"

[Option: Mama/Papa zeigen]
```

### 8.4 Wöchentlicher Report (Sonntag 20:00)

**An Eltern:**
```
📊 Emir's Wochen-Zusammenfassung

Diese Woche hat Emir:
✅ 35 Übungen gemacht (↑12 vs. letzte Woche)
⭐ 105 Sterne gesammelt
🔥 7-Tage-Streak gehalten!
📚 12 neue Wörter gelernt

🎯 Top-Leistungen:
• S-Laut: 95% Genauigkeit (ausgezeichnet!)
• Wort "sonce": 100% in 5 Versuchen

⚠️ Hinweise:
• SCH-Laut: 65% Genauigkeit (mehr Übung nötig)
• Empfehlung: Fokus auf "Schule", "Fisch", "Tasche"

💡 Tipp: 
Versuche spielerisch SCH-Wörter im Alltag einzubauen,
z.B. beim Essen: "Was möchtest du auf deinem Tisch?"

[Detaillierten Report ansehen]
[PDF exportieren für Therapeuten]
```

---

## 9. Retention-Strategien

### 9.1 Tägliche Anreize

| Strategie | Umsetzung | Psychologie |
|-----------|-----------|-------------|
| **Streak-System** | Bonus-Sterne für tägliche Nutzung | Fear of missing out (FOMO) |
| **Tägliche Mission** | 3 kleine Aufgaben pro Tag | Clear goals = higher motivation |
| **Login-Belohnung** | Tag 1: 5⭐, Tag 2: 10⭐, Tag 7: 50⭐ | Progressive rewards |
| **Zeitlich begrenzte Events** | "Wochenend-Challenge: Doppelte Sterne!" | Urgency |

### 9.2 Comeback-Mechanismen

**Wenn Kind 2+ Tage nicht übt:**

```
[Push Notification]

Terapko vermisst dich! 🥺

"Hallo Emir, ich bin Terapko!
 Ich habe dich vermisst!
 Komm zurück und wir sammeln zusammen Kristalle! 💎"

[App öffnen]
```

**Comeback-Bonus:**
```
Willkommen zurück! 🎉

Terapko: "Du bist zurück! Ich bin so glücklich!"
         "Hier, ein Willkommens-Geschenk!"

[+20 Bonus-Sterne]
[Neues Mini-Spiel freigeschaltet]

Terapko: "Lass uns da weitermachen, wo wir aufgehört haben!"
```

### 9.3 Saisonale Events

**Weihnachten:**
- Terapko trägt Weihnachtsmütze 🎅
- Spezielle Weihnachts-Wörter (Božić, paketić, Djed Mraz)
- Schnee-Animation im Hintergrund ❄️

**Geburtstag (Emir):**
- Geburtstags-Party in der App 🎂
- Terapko singt "Sretan rođendan!"
- Spezial-Badge: "Jahreszahl-Held" (z.B. 5 Jahre)

**Ramadan/Bajram (falls relevant):**
- Spezielle Grüße
- Ramadan-Vokabular

---

## 10. Accessibility & Inklusion

### 10.1 Für Hörbehinderung optimiert

| Feature | Implementierung |
|---------|-----------------|
| **Visuelles Feedback** | Immer Text + Icons, nie nur Audio |
| **Untertitel** | Synchron mit Sprache, große Schrift |
| **Vibration** | Haptisches Feedback bei Erfolg/Fehler |
| **Lautstärke-Anpassung** | Individuelle Anpassung pro Ohr |
| **Audiogramm-basiert** | TTS passt sich an Hörverlust an |

### 10.2 Für 4-Jährige optimiert

| Feature | Implementierung |
|---------|-----------------|
| **Große Buttons** | Min. 60x60 px, leicht klickbar |
| **Einfache Navigation** | Max. 2-3 Ebenen tief |
| **Klare Icons** | Universelle Symbole (🏠=Home, ⭐=Sterne) |
| **Keine Timer-Pressure** | Keine Zeitlimits (außer bei Rennbahn-Spiel) |
| **Fehler-Toleranz** | Unbegrenzt viele Versuche |

---

## 11. Testing & Iteration

### 11.1 A/B-Testing-Ideen

**Test 1: Belohnungs-Frequenz**
- Variante A: Stern nach jeder Übung
- Variante B: Stern nur bei >70% Erfolg
- **Metrik:** Retention Rate nach 7 Tagen

**Test 2: Terapko's Persönlichkeit**
- Variante A: Sehr enthusiastisch ("WOW! SUPER!")
- Variante B: Ruhig und geduldig ("Gut gemacht, das war schön")
- **Metrik:** User-Engagement (Minuten pro Session)

**Test 3: Story vs. No-Story**
- Variante A: Mit Zvuk-Kristalle-Story
- Variante B: Ohne Story (nur Übungen)
- **Metrik:** Completion Rate

### 11.2 User-Feedback sammeln

**Nach jeder Session:**
```
Terapko: "Wie hat dir das heute gefallen?"

[😀 Super!] [😊 Gut] [😐 Ok] [😞 Nicht so]

[Falls 😞 oder 😐]
Terapko: "Was können wir besser machen?"
[Zu schwer] [Zu langweilig] [Zu laut] [Anderes]
```

**An Eltern:**
- Wöchentliche Umfrage: "Wie zufrieden sind Sie mit Emirs Fortschritt?"
- NPS-Score: "Würden Sie Terapko weiterempfehlen?"

---

**Ende der Gamification-Dokumentation**

---

**Nächste Schritte:**
1. Terapko-Charakter designen (Rive/Lottie)
2. Stern/Badge-System implementieren
3. Mini-Spiele prototypen
4. Eltern-Dashboard bauen

**Ressourcen:**
- [IMPLEMENTIERUNGS_ROADMAP.md](./IMPLEMENTIERUNGS_ROADMAP.md) - Entwicklungs-Zeitplan
- [BOSNISCHE_INHALTE.md](./BOSNISCHE_INHALTE.md) - Wort-Bibliothek
