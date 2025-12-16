# Anleitung für Parent Dashboard Agent

## Lianko Einstellungen im Parent Dashboard

**Letzte Aktualisierung:** 2025-12-16

---

## Übersicht

Das Parent Dashboard steuert folgende Lianko-Einstellungen für jedes Kind:

| Einstellung | Typ | Default | Beschreibung |
|-------------|-----|---------|--------------|
| `subtitlesEnabled` | bool | `false` | Untertitel an/aus |
| `language` | string | `"bs"` | Sprache (bs, en, de, hr, sr, tr) |
| `speechRate` | double | `0.4` | Sprechgeschwindigkeit (0.3-0.6) |
| `autoRepeat` | bool | `true` | Bei Fehler automatisch wiederholen |
| `maxAttempts` | int | `3` | Max. Versuche pro Wort |
| `parentRecordingEnabled` | bool | `false` | Eltern-Aufnahme aktiviert |
| `parentRecordingUrl` | string | `null` | URL zur Eltern-Aufnahme (Firebase Storage) |

---

## Feature: Eltern-Aufnahme (NEU)

### Was ist das?

Eltern können **eigene Sprachaufnahmen** erstellen, die statt der TTS-Stimme abgespielt werden. Das Kind hört dann die vertraute Stimme der Eltern.

### Ablauf im Parent Dashboard

```
┌─────────────────────────────────────────────────────────────┐
│  PARENT DASHBOARD - Kind: Lian                              │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Lianko Einstellungen                                       │
│  ─────────────────────                                      │
│                                                              │
│  Sprache:        [▼ Deutsch]                                │
│                                                              │
│  Untertitel:     [ ] Aus  [x] An                            │
│                                                              │
│  ─────────────────────────────────────────────────────────  │
│                                                              │
│  🎤 Eltern-Aufnahme                                         │
│                                                              │
│  [ ] Aus  [x] An                                            │
│                                                              │
│  Wortliste für Aufnahme:                                    │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ Hund     [🎤 Aufnehmen] [▶ Abspielen] [✓ Fertig]   │   │
│  │ Katze    [🎤 Aufnehmen] [▶ Abspielen] [ ]          │   │
│  │ Maus     [🎤 Aufnehmen] [ ]           [ ]          │   │
│  │ Vogel    [🎤 Aufnehmen] [ ]           [ ]          │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                              │
│  Fortschritt: 1/4 Wörter aufgenommen                        │
│                                                              │
│  [Alle löschen]                    [Speichern]              │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Technische Umsetzung für Parent Agent

### 1. Datenstruktur in Firebase

```
/users/{parentId}/children/{childId}/liankoSettings/
├── subtitlesEnabled: false
├── language: "de"
├── speechRate: 0.4
├── parentRecordingEnabled: false
└── parentRecordings/
    ├── hund: "gs://bucket/recordings/hund_123.mp3"
    ├── katze: "gs://bucket/recordings/katze_123.mp3"
    └── ...
```

### 2. API Endpunkte (Firebase Functions oder direkt Firestore)

```dart
// Einstellung speichern
Future<void> saveLiankoSettings(String childId, Map<String, dynamic> settings);

// Aufnahme hochladen
Future<String> uploadParentRecording(String childId, String word, File audioFile);

// Aufnahme löschen
Future<void> deleteParentRecording(String childId, String word);

// Alle Einstellungen laden
Future<LiankoSettings> getLiankoSettings(String childId);
```

### 3. UI-Komponenten für Parent Dashboard

#### 3.1 Einstellungs-Screen

```dart
class LiankoSettingsScreen extends ConsumerWidget {
  final String childId;

  // Zeigt alle Lianko-Einstellungen
  // - Sprache Dropdown
  // - Untertitel Toggle
  // - Eltern-Aufnahme Toggle
  // - Aufnahme-Liste (wenn aktiviert)
}
```

#### 3.2 Aufnahme-Widget

```dart
class ParentRecordingWidget extends StatefulWidget {
  final String word;
  final String? existingRecordingUrl;
  final Function(File) onRecorded;

  // [🎤] Button → Aufnahme starten
  // [⏹️] Button → Aufnahme stoppen
  // [▶️] Button → Abspielen
  // [🗑️] Button → Löschen
}
```

### 4. Synchronisation mit Lianko App

```
┌─────────────────┐                    ┌─────────────────┐
│ Parent Dashboard │                    │   Lianko App    │
│                  │                    │                  │
│  Einstellungen   │───── Firebase ────►│  Lädt Settings  │
│  speichern       │      Firestore     │  beim Start     │
│                  │                    │                  │
│  Aufnahme        │───── Firebase ────►│  Spielt Eltern- │
│  hochladen       │      Storage       │  Aufnahme ab    │
└─────────────────┘                    └─────────────────┘
```

---

## Wortlisten für Aufnahmen

### Standard-Wortlisten (Kategorien)

```yaml
tiere:
  - Hund
  - Katze
  - Maus
  - Vogel
  - Fisch
  - Pferd
  - Kuh
  - Schwein

familie:
  - Mama
  - Papa
  - Oma
  - Opa
  - Bruder
  - Schwester

zahlen:
  - Eins
  - Zwei
  - Drei
  - Vier
  - Fünf

farben:
  - Rot
  - Blau
  - Grün
  - Gelb
```

### Eltern können eigene Wörter hinzufügen

```
[+ Eigenes Wort hinzufügen]
┌─────────────────────────┐
│ Wort: [_______________] │
│                         │
│ [Abbrechen] [Hinzufügen]│
└─────────────────────────┘
```

---

## Ablauf im Parent Dashboard

### Schritt 1: Lianko-Einstellungen öffnen

```
Dashboard → Kind auswählen → Lianko Einstellungen
```

### Schritt 2: Eltern-Aufnahme aktivieren

```
Toggle: Eltern-Aufnahme [AUS] → [AN]
```

### Schritt 3: Kategorie wählen

```
[Tiere] [Familie] [Zahlen] [Farben] [Eigene]
```

### Schritt 4: Wörter aufnehmen

```
1. Wort antippen
2. 🎤 drücken und sprechen
3. ⏹️ drücken zum Beenden
4. ▶️ zum Kontrollieren
5. ✓ wenn zufrieden
```

### Schritt 5: Speichern

```
[Speichern] → Sync mit Lianko App
```

---

## Fehlerbehandlung

| Fehler | Lösung |
|--------|--------|
| Mikrofon nicht erlaubt | Permission-Dialog anzeigen |
| Upload fehlgeschlagen | Retry-Button, offline speichern |
| Aufnahme zu kurz (<0.5s) | "Aufnahme zu kurz, bitte nochmal" |
| Aufnahme zu lang (>10s) | "Maximal 10 Sekunden" |

---

## Sicherheit

- Aufnahmen nur für eigene Kinder
- Firebase Storage Rules prüfen parentId
- Aufnahmen werden verschlüsselt gespeichert
- Löschung löscht auch aus Storage

---

## Zusammenfassung für Parent Agent

**Du musst implementieren:**

1. ✅ UI für Lianko-Einstellungen (Sprache, Untertitel, etc.)
2. ✅ Toggle für Eltern-Aufnahme aktivieren
3. ✅ Aufnahme-Widget (Record, Play, Delete)
4. ✅ Upload zu Firebase Storage
5. ✅ Sync der Settings zu Firestore
6. ✅ Wortlisten-Verwaltung

**Lianko App liest diese Settings und spielt Eltern-Aufnahmen ab (wenn vorhanden).**
