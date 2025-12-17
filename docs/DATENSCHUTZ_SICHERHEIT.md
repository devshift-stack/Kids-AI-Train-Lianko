# 🔒 Datenschutz & Sicherheit - Terapko AI

**Version:** 1.0  
**Datum:** 17. Dezember 2025  
**DSGVO-konform:** Ja  
**Zertifizierungen:** Geplant (ISO 27001, SOC 2)

---

## 📋 Inhaltsverzeichnis

1. [Rechtlicher Rahmen](#rechtlicher-rahmen)
2. [Datenschutz-Prinzipien](#datenschutz-prinzipien)
3. [Welche Daten werden erfasst?](#welche-daten-werden-erfasst)
4. [Datenspeicherung & Verschlüsselung](#datenspeicherung--verschlüsselung)
5. [Elternrechte (DSGVO)](#elternrechte-dsgvo)
6. [Sicherheitsmaßnahmen](#sicherheitsmaßnahmen)
7. [Third-Party-Services](#third-party-services)
8. [Kinder-spezifische Anforderungen](#kinder-spezifische-anforderungen)
9. [Incident Response Plan](#incident-response-plan)
10. [Privacy Policy (Vorlage)](#privacy-policy-vorlage)

---

## 1. Rechtlicher Rahmen

### Anwendbare Gesetze

| Gesetz | Region | Relevanz | Status |
|--------|--------|----------|--------|
| **DSGVO** | EU | Datenschutz-Grundverordnung | ✅ Muss einhalten |
| **ePrivacy** | EU | Elektronische Kommunikation | ✅ Muss einhalten |
| **COPPA** | USA | Children's Online Privacy Protection Act | ⚠️ Nur wenn US-Nutzer |
| **CCPA** | Kalifornien | California Consumer Privacy Act | ⚠️ Nur wenn CA-Nutzer |
| **Bosnisches Datenschutzgesetz** | BiH | Zakon o zaštiti podataka | ✅ Muss einhalten |

### DSGVO-Anforderungen (Artikel 8)

**Kinder unter 16 Jahren:**
- Elterliche Einwilligung erforderlich
- Klare, einfache Sprache für Datenschutzerklärung
- Besondere Schutzmaßnahmen

**Unsere Zielgruppe (4 Jahre):**
- **IMMER** elterliche Einwilligung erforderlich
- Eltern haben volle Kontrolle
- Kind-freundliche Erklärungen

---

## 2. Datenschutz-Prinzipien

### Privacy by Design

**Prinzipien:**
1. **Datenminimierung:** Nur nötige Daten sammeln
2. **Zweckbindung:** Daten nur für deklarierten Zweck nutzen
3. **Speicherbegrenzung:** Daten löschen wenn nicht mehr nötig
4. **Integrität:** Daten vor Verlust/Manipulation schützen
5. **Transparenz:** Eltern wissen immer, was gesammelt wird

### Privacy by Default

**Standardeinstellungen:**
- Strengster Datenschutz per Default
- Opt-in statt Opt-out für optionale Features
- Lokale Speicherung bevorzugt (statt Cloud)
- Anonymisierung wo möglich

---

## 3. Welche Daten werden erfasst?

### Notwendige Daten (für App-Funktion)

| Datentyp | Beispiel | Zweck | Speicherort | Löschung |
|----------|----------|-------|-------------|----------|
| **Name des Kindes** | "Emir" | Personalisierung | Firestore (verschlüsselt) | Auf Eltern-Anfrage |
| **Alter** | 4 Jahre | Alters-Anpassung | Firestore | Auf Anfrage |
| **Audiogramm-Daten** | dB-Werte | TTS-Optimierung | Firestore (verschlüsselt) | Auf Anfrage |
| **Übungs-Verlauf** | Welche Wörter geübt | Fortschritt-Tracking | Firestore | Nach 2 Jahren |
| **Spracherkennung-Ergebnisse** | Score, Phoneme | Feedback & Analyse | Firestore | Nach 1 Jahr |
| **Audio-Aufnahmen (Kind)** | WAV-Dateien | Analyse (lokal) | On-Device → gelöscht nach Analyse | Sofort |
| **Audio-Aufnahmen (Eltern)** | Für Voice Cloning | ElevenLabs TTS | ElevenLabs (siehe unten) | Auf Anfrage |
| **Eltern-Email** | parent@email.com | Login, Benachrichtigungen | Firebase Auth | Auf Anfrage |

### Optionale Daten (mit Einwilligung)

| Datentyp | Zweck | Default | Opt-In/Out |
|----------|-------|---------|------------|
| **Nutzungs-Statistiken** | Verbesserung der App | OFF | Opt-In |
| **Crash-Reports** | Bug-Fixing | ON | Opt-Out |
| **Audio-Aufnahmen (langfristig)** | Fortschritts-Vergleich | OFF | Opt-In |
| **Push-Notifications** | Erinnerungen | OFF | Opt-In |

### Daten die NICHT erfasst werden

❌ **Niemals erfasst:**
- Kein Name der Eltern (nur Email für Login)
- Keine Adresse
- Keine Telefonnummer
- Keine Fotos vom Kind (außer Audiogramm)
- Keine Standort-Daten
- Keine Geräte-IDs (außer Firebase-intern)
- Keine Tracking-Cookies für Werbung

---

## 4. Datenspeicherung & Verschlüsselung

### Firestore (Hauptdatenbank)

**Sicherheitsregeln:**

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Basis-Regel: Nur authentifizierte Nutzer
    match /{document=**} {
      allow read, write: if false;  // Default: Nichts erlauben
    }
    
    // User kann nur eigene Daten lesen/schreiben
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
      
      // Subcollections
      match /exercises/{exerciseId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
      
      match /sessions/{sessionId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
      
      match /rewards/{rewardId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
      
      // Audiogram: Nur Lesen für Eltern, Schreiben nur mit Validierung
      match /audiograms/{audiogramId} {
        allow read: if request.auth != null && request.auth.uid == userId;
        allow write: if request.auth != null 
                     && request.auth.uid == userId
                     && request.resource.data.confirmedByParent == true;
      }
    }
  }
}
```

**Verschlüsselung:**
- Transport: TLS 1.3 (HTTPS)
- At-Rest: AES-256 (Firebase Standard)
- Sensible Felder (Audiogramm): Zusätzliche Client-Side-Verschlüsselung

```dart
// Beispiel: Verschlüsselte Speicherung
import 'package:encrypt/encrypt.dart';

class SecureStorage {
  final key = Key.fromSecureRandom(32);
  final iv = IV.fromSecureRandom(16);
  final encrypter = Encrypter(AES(key));

  Future<void> saveAudiogramSecure(AudiogramData audiogram) async {
    // Serialize to JSON
    final json = jsonEncode(audiogram.toMap());
    
    // Encrypt
    final encrypted = encrypter.encrypt(json, iv: iv);
    
    // Save to Firestore
    await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .update({
        'audiogram_encrypted': encrypted.base64,
        'audiogram_iv': iv.base64,
      });
  }

  Future<AudiogramData> loadAudiogramSecure() async {
    final doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .get();
    
    final encryptedBase64 = doc.data()!['audiogram_encrypted'];
    final ivBase64 = doc.data()!['audiogram_iv'];
    
    final encrypted = Encrypted.fromBase64(encryptedBase64);
    final iv = IV.fromBase64(ivBase64);
    
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    
    return AudiogramData.fromMap(jsonDecode(decrypted));
  }
}
```

### Firebase Storage (Audio-Dateien)

**Struktur:**
```
/users/{userId}/
  /voice_clone/
    - recording_1.wav (Eltern-Aufnahme für ElevenLabs)
    - recording_2.wav
  /audiogram_images/
    - audiogram_2025-12-17.jpg (Original-Foto)
```

**Security Rules:**
```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    // User kann nur eigene Dateien zugreifen
    match /users/{userId}/{allPaths=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

**Verschlüsselung:**
- Firebase Storage verschlüsselt automatisch (AES-256)
- Zusätzlich: Dateien mit Passwort schützen (optional)

### On-Device Storage (Whisper Model, Cache)

**Flutter Hive (Lokal):**
```dart
// Encrypted Box für sensible Daten
import 'package:hive_flutter/hive_flutter.dart';

await Hive.initFlutter();

// Generate secure key
final key = Hive.generateSecureKey();
await secureStorage.write(key: 'hive_key', value: base64.encode(key));

// Open encrypted box
final encryptionKey = await secureStorage.read(key: 'hive_key');
final box = await Hive.openBox(
  'user_data',
  encryptionCipher: HiveAesCipher(base64.decode(encryptionKey!)),
);

// Store data
await box.put('child_name', 'Emir');  // Verschlüsselt gespeichert
```

**Was wird lokal gespeichert:**
- Whisper-Model (nicht sensitiv)
- TTS-Audio-Cache (temporär)
- User-Einstellungen
- Session-Token (verschlüsselt)

---

## 5. Elternrechte (DSGVO)

### Rechte gemäß DSGVO

| Recht | Beschreibung | Umsetzung in App |
|-------|--------------|------------------|
| **Auskunftsrecht** (Art. 15) | Welche Daten werden gespeichert? | "Meine Daten anzeigen"-Button im Dashboard |
| **Recht auf Berichtigung** (Art. 16) | Falsche Daten korrigieren | Editierbare Felder (Name, Alter, Audiogramm) |
| **Recht auf Löschung** (Art. 17) | "Recht auf Vergessenwerden" | "Account löschen"-Button |
| **Recht auf Datenübertragbarkeit** (Art. 20) | Daten exportieren | "Daten exportieren (JSON)"-Button |
| **Widerspruchsrecht** (Art. 21) | Nutzung widersprechen | "Analytics deaktivieren" |
| **Einwilligung widerrufen** (Art. 7(3)) | Einwilligung zurückziehen | Jederzeit in Einstellungen |

### Implementierung: Daten-Export

```dart
// lib/services/privacy/data_export_service.dart
class DataExportService {
  Future<Map<String, dynamic>> exportUserData(String userId) async {
    final firestore = FirebaseFirestore.instance;
    
    // User-Profil
    final userDoc = await firestore.collection('users').doc(userId).get();
    
    // Übungen
    final exercises = await firestore
      .collection('users')
      .doc(userId)
      .collection('exercises')
      .get();
    
    // Sessions
    final sessions = await firestore
      .collection('users')
      .doc(userId)
      .collection('sessions')
      .get();
    
    // Zusammenstellen
    return {
      'export_date': DateTime.now().toIso8601String(),
      'user_profile': userDoc.data(),
      'exercises': exercises.docs.map((d) => d.data()).toList(),
      'sessions': sessions.docs.map((d) => d.data()).toList(),
      'metadata': {
        'app_version': '1.0.0',
        'format': 'JSON',
      },
    };
  }
  
  Future<File> exportToJson(String userId) async {
    final data = await exportUserData(userId);
    final json = jsonEncode(data);
    
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/terapko_data_export_${DateTime.now().millisecondsSinceEpoch}.json');
    
    await file.writeAsString(json);
    return file;
  }
}
```

### Implementierung: Account-Löschung

```dart
// lib/services/privacy/account_deletion_service.dart
class AccountDeletionService {
  Future<void> deleteAccount(String userId) async {
    final firestore = FirebaseFirestore.instance;
    final storage = FirebaseStorage.instance;
    
    // 1. Alle Firestore-Daten löschen
    await _deleteCollection(firestore, 'users/$userId/exercises');
    await _deleteCollection(firestore, 'users/$userId/sessions');
    await _deleteCollection(firestore, 'users/$userId/rewards');
    await _deleteUserDocument(userId);
    
    // 2. Alle Storage-Dateien löschen
    await _deleteStorageFolder(storage, 'users/$userId');
    
    // 3. ElevenLabs Voice löschen (API-Call)
    await _deleteElevenLabsVoice(userId);
    
    // 4. Firebase Auth User löschen
    await FirebaseAuth.instance.currentUser?.delete();
    
    // 5. Lokalen Cache löschen
    await _clearLocalStorage();
    
    // Done!
    print('Account komplett gelöscht');
  }
  
  Future<void> _deleteCollection(FirebaseFirestore firestore, String path) async {
    final batch = firestore.batch();
    final snapshot = await firestore.collection(path).get();
    
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    
    await batch.commit();
  }
}
```

---

## 6. Sicherheitsmaßnahmen

### Authentifizierung & Autorisierung

**Firebase Authentication:**

```dart
// lib/services/auth/auth_service.dart
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Eltern-Login (Email + Passwort)
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('Kein Benutzer mit dieser Email gefunden');
      } else if (e.code == 'wrong-password') {
        throw Exception('Falsches Passwort');
      }
      rethrow;
    }
  }
  
  // Passwort-Stärke-Check
  bool isPasswordStrong(String password) {
    // Mindestens 8 Zeichen
    if (password.length < 8) return false;
    
    // Mind. 1 Großbuchstabe, 1 Kleinbuchstabe, 1 Zahl
    final hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    final hasLowerCase = password.contains(RegExp(r'[a-z]'));
    final hasDigit = password.contains(RegExp(r'[0-9]'));
    
    return hasUpperCase && hasLowerCase && hasDigit;
  }
  
  // 2FA (optional, für Extra-Sicherheit)
  Future<void> enableTwoFactor(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.currentUser?.linkWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print('2FA failed: $e');
      },
      codeSent: (String verificationId, int? resendToken) {
        // Code per SMS gesendet
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
```

**Parent-Dashboard-Zugriff:**

```dart
// Zusätzlicher PIN-Schutz
class ParentAuthScreen extends StatefulWidget {
  @override
  State<ParentAuthScreen> createState() => _ParentAuthScreenState();
}

class _ParentAuthScreenState extends State<ParentAuthScreen> {
  final _pinController = TextEditingController();
  
  Future<void> _authenticate() async {
    final prefs = await SharedPreferences.getInstance();
    final storedPinHash = prefs.getString('parent_pin_hash');
    
    final inputHash = sha256.convert(utf8.encode(_pinController.text)).toString();
    
    if (inputHash == storedPinHash) {
      context.go('/parent-dashboard');
    } else {
      _showError('Falscher PIN');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Eltern-PIN eingeben:'),
            TextField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 4,
            ),
            ElevatedButton(
              onPressed: _authenticate,
              child: Text('Anmelden'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Sichere Kommunikation

**HTTPS-Only:**
```dart
// lib/core/config/network_config.dart
class NetworkConfig {
  static final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.terapko.app',  // Nur HTTPS!
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );
  
  // SSL-Pinning (für Extra-Sicherheit)
  static void setupSSLPinning() {
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = (cert, host, port) {
          // Nur unser Zertifikat akzeptieren
          return cert.sha256.toString() == 'OUR_CERT_HASH';
        };
        return client;
      },
    );
  }
}
```

### Input-Validation & Sanitization

```dart
// lib/core/utils/input_validator.dart
class InputValidator {
  // XSS-Protection
  static String sanitizeUserInput(String input) {
    return input
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('&', '&amp;')
      .replaceAll('"', '&quot;')
      .replaceAll("'", '&#x27;');
  }
  
  // SQL-Injection-Protection (nicht relevant bei NoSQL, aber gut zu haben)
  static String sanitizeDatabaseInput(String input) {
    return input
      .replaceAll("'", "''")
      .replaceAll(';', '')
      .replaceAll('--', '');
  }
  
  // File-Upload-Validation
  static bool isValidAudiogramImage(File file) {
    // Check file size (max 10 MB)
    if (file.lengthSync() > 10 * 1024 * 1024) {
      return false;
    }
    
    // Check MIME type
    final bytes = file.readAsBytesSync();
    final mimeType = lookupMimeType('', headerBytes: bytes);
    
    return ['image/jpeg', 'image/png'].contains(mimeType);
  }
}
```

### Rate Limiting

```python
# backend/app.py (Flask Backend)
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address

app = Flask(__name__)
limiter = Limiter(
    app=app,
    key_func=get_remote_address,
    default_limits=["200 per day", "50 per hour"]
)

@app.route('/api/analyze-speech', methods=['POST'])
@limiter.limit("10 per minute")  # Max 10 Anfragen pro Minute
def analyze_speech():
    # ...
    pass
```

---

## 7. Third-Party-Services

### Übersicht

| Service | Zweck | Daten geteilt | Datenschutz-Policy | DSGVO-konform |
|---------|-------|---------------|-------------------|---------------|
| **Firebase** | Backend, Auth, Storage | User-Daten | [Link](https://firebase.google.com/support/privacy) | ✅ Ja |
| **ElevenLabs** | Voice Cloning | Audio-Aufnahmen (Eltern) | [Link](https://elevenlabs.io/privacy) | ✅ Ja (EU-Server) |
| **Google Gemini** | Audiogramm-Analyse | Audiogramm-Bilder | [Link](https://policies.google.com/privacy) | ✅ Ja |
| **Crashlytics** | Fehler-Tracking | Crash-Logs (anonymisiert) | Firebase Policy | ✅ Ja |
| **Analytics** (optional) | Nutzungs-Statistiken | Aggregierte Events | Firebase Policy | ✅ Ja (Opt-In) |

### Data Processing Agreements (DPA)

**Firebase:**
- Automatisch durch Google Cloud
- DSGVO-konform
- Server: EU (europe-west1)

**ElevenLabs:**
- DPA auf Anfrage
- Server: EU (London)
- Voice-Daten werden gelöscht nach Cloning (auf Anfrage)

**Gemini:**
- Google Cloud DPA
- Keine Daten-Speicherung (stateless API)

### Daten-Minimierung bei Third-Parties

```dart
// Nur nötige Daten an ElevenLabs senden
Future<String> cloneVoice(List<String> audioPaths) async {
  // KEINE User-IDs, Namen, etc. in API-Call!
  
  final formData = FormData();
  formData.fields.add(MapEntry('name', 'Voice_${uuid.v4()}'));  // Anonymer Name
  
  for (final path in audioPaths) {
    formData.files.add(MapEntry(
      'files',
      await MultipartFile.fromFile(path),
    ));
  }
  
  final response = await dio.post('/voices/add', data: formData);
  
  // Voice-ID zurück, aber keine persönlichen Daten gespeichert
  return response.data['voice_id'];
}
```

---

## 8. Kinder-spezifische Anforderungen

### Age-Gate (Altersverifikation)

**Onboarding-Flow:**
1. App öffnen
2. Frage: "Bist du ein Elternteil?" (JA/NEIN)
3. Wenn JA: Email + Passwort eingeben
4. Erst dann: Kind-Profil erstellen

```dart
class AgeGateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Willkommen bei Terapko AI!', style: TextStyle(fontSize: 32)),
            SizedBox(height: 32),
            Text('Diese App ist für Kinder.'),
            Text('Bist du ein Elternteil oder Erziehungsberechtigter?'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => context.go('/parent-signup'),
                  child: Text('JA, ich bin Elternteil'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => _showChildWarning(),
                  child: Text('NEIN'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  void _showChildWarning() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Bitte hole deine Eltern'),
        content: Text('Diese App darf nur mit Erlaubnis deiner Eltern genutzt werden.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
```

### Elterliche Einwilligung

**Consent-Management:**

```dart
class ConsentManager {
  Future<void> requestConsent(BuildContext context) async {
    final consent = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Datenschutz-Einwilligung'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Wir benötigen Ihre Einwilligung für:'),
              SizedBox(height: 16),
              
              // Erforderlich
              Text('✅ Erforderlich (für App-Nutzung):',
                style: TextStyle(fontWeight: FontWeight.bold)),
              Text('• Name des Kindes'),
              Text('• Alter'),
              Text('• Audiogramm-Daten'),
              Text('• Übungs-Fortschritt'),
              SizedBox(height: 16),
              
              // Optional
              Text('Optional (mit separater Einwilligung):',
                style: TextStyle(fontWeight: FontWeight.bold)),
              Text('• Nutzungs-Statistiken'),
              Text('• Langfristige Audio-Aufnahmen'),
              SizedBox(height: 16),
              
              Text('Ihre Rechte:'),
              Text('• Auskunft über gespeicherte Daten'),
              Text('• Daten korrigieren oder löschen'),
              Text('• Daten exportieren'),
              SizedBox(height: 16),
              
              TextButton(
                onPressed: () => _showFullPrivacyPolicy(),
                child: Text('Vollständige Datenschutzerklärung lesen'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Ablehnen'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Zustimmen'),
          ),
        ],
      ),
    );
    
    if (consent == true) {
      await _saveConsent();
    } else {
      // App kann nicht ohne Consent genutzt werden
      exit(0);
    }
  }
  
  Future<void> _saveConsent() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('privacy_consent_given', true);
    await prefs.setString('privacy_consent_date', DateTime.now().toIso8601String());
    await prefs.setString('privacy_policy_version', '1.0');
  }
}
```

### Kind-freundliche Erklärungen

**Datenschutz für Kinder (4 Jahre):**

```
👋 Hej Emir!

Weißt du, was Datenschutz ist?

Das bedeutet: Wir passen auf deine Informationen auf! 🔒

Was wissen wir über dich?
• Dein Name (Emir)
• Wie alt du bist (4 Jahre)
• Welche Wörter du übst

Was machen wir NICHT?
• Niemand anders kann deine Informationen sehen
• Wir verkaufen nichts
• Wir zeigen keine Werbung

Wenn du etwas nicht magst, können deine Eltern es löschen! ❌

Fragen? Frag deine Mama oder Papa! 👨👩
```

---

## 9. Incident Response Plan

### Sicherheitsvorfall-Kategorien

| Kategorie | Beispiel | Schwere | Reaktionszeit |
|-----------|----------|---------|---------------|
| **Kritisch** | Daten-Leak | 🔴 Hoch | Sofort (<1h) |
| **Hoch** | Unauthorized Access | 🟠 Mittel | <4h |
| **Mittel** | Versuchter Angriff | 🟡 Niedrig | <24h |
| **Niedrig** | Verdächtige Aktivität | 🟢 Info | <7 Tage |

### Incident Response Team

| Rolle | Verantwortung | Kontakt |
|-------|---------------|---------|
| **Incident Manager** | Koordination | incident@terapko.app |
| **Tech Lead** | Technische Analyse | tech@terapko.app |
| **Legal Counsel** | Rechtliche Bewertung | legal@terapko.app |
| **PR/Kommunikation** | Nutzer-Kommunikation | pr@terapko.app |

### Response-Ablauf

**Phase 1: Detection (0-1h)**
1. Alarm erhalten (Monitoring, User-Report)
2. Incident Manager aktivieren
3. Schwere bewerten (Kritisch/Hoch/Mittel/Niedrig)

**Phase 2: Containment (1-4h)**
1. Betroffene Systeme isolieren
2. Weitere Schäden verhindern
3. Forensik-Daten sichern

**Phase 3: Investigation (4-24h)**
1. Ursache identifizieren
2. Umfang des Lecks feststellen
3. Betroffene Nutzer identifizieren

**Phase 4: Notification (innerhalb 72h, DSGVO Art. 33)**
1. Datenschutzbehörde informieren (wenn personenbezogen)
2. Betroffene Nutzer informieren (wenn hohes Risiko)
3. Öffentliche Kommunikation (wenn nötig)

**Phase 5: Recovery (variabel)**
1. Sicherheitslücke schließen
2. Systeme wiederherstellen
3. Post-Incident-Review

### Beispiel: Daten-Leak Response

```
Tag 1, 10:00: Verdacht auf Datenbank-Leak
Tag 1, 10:15: Incident Manager alarmiert, Team aktiviert
Tag 1, 10:30: Firestore-Zugriff vorübergehend eingeschränkt
Tag 1, 11:00: Ursache identifiziert (falsche Security Rule)
Tag 1, 12:00: Security Rule gefixt, getestet
Tag 1, 14:00: Umfang: 50 User-Profile betroffen (Namen, Alter)
Tag 1, 16:00: Datenschutzbehörde informiert
Tag 2, 09:00: Betroffene Eltern per Email informiert
Tag 3, 14:00: Post-Incident-Review: Lessons Learned dokumentiert
```

**Email an betroffene Nutzer:**

```
Betreff: Sicherheitsvorfall bei Terapko AI - Wichtige Information

Sehr geehrte Eltern,

wir informieren Sie über einen Sicherheitsvorfall bei Terapko AI.

WAS IST PASSIERT?
Am [Datum] haben wir einen unbefugten Zugriff auf unsere Datenbank festgestellt.
Betroffen waren Namen und Alter von ca. 50 Kindern.

WELCHE DATEN SIND BETROFFEN?
• Name Ihres Kindes
• Alter
• NICHT betroffen: Audio-Aufnahmen, Audiogramme, Email-Adressen

WAS HABEN WIR GETAN?
• Sicherheitslücke sofort geschlossen
• Datenschutzbehörde informiert
• Zusätzliche Sicherheitsmaßnahmen implementiert

WAS SOLLTEN SIE TUN?
• Passwort ändern (vorsichtshalber)
• Bei Fragen: security@terapko.app

Wir entschuldigen uns aufrichtig für diesen Vorfall.
Die Sicherheit Ihrer Daten hat für uns höchste Priorität.

Mit freundlichen Grüßen,
Terapko AI Team
```

---

## 10. Privacy Policy (Vorlage)

### Datenschutzerklärung - Terapko AI

**Stand:** 17. Dezember 2025  
**Version:** 1.0

#### 1. Verantwortlicher

Terapko AI  
[Adresse]  
Email: privacy@terapko.app  
Datenschutzbeauftragter: [Name]

#### 2. Welche Daten erfassen wir?

**Erforderliche Daten:**
- Name des Kindes (für Personalisierung)
- Alter (für Alters-Anpassung)
- Audiogramm-Daten (für TTS-Optimierung)
- Übungs-Fortschritt (für Fortschritts-Tracking)
- Eltern-Email (für Login)

**Optionale Daten (mit Einwilligung):**
- Nutzungs-Statistiken (zur App-Verbesserung)
- Langfristige Audio-Aufnahmen (für Fortschritts-Vergleich)

**Daten die wir NICHT erfassen:**
- Keine Adresse, Telefonnummer
- Keine Fotos (außer Audiogramm)
- Keine Standort-Daten
- Keine Werbe-Tracker

#### 3. Rechtsgrundlage (DSGVO)

- Art. 6 Abs. 1 lit. a: Einwilligung
- Art. 6 Abs. 1 lit. b: Vertragserfüllung
- Art. 9 Abs. 2 lit. a: Gesundheitsdaten (Audiogramm) mit expliziter Einwilligung

#### 4. Zweck der Verarbeitung

- Personalisierung der App
- Fortschritts-Tracking
- TTS-Optimierung für Hörgeräte
- App-Verbesserung (optional)

#### 5. Speicherdauer

- Übungs-Daten: 2 Jahre
- Audiogramm: Bis zur Löschung durch Eltern
- Audio-Aufnahmen (Kind): Sofort nach Analyse gelöscht
- Audio-Aufnahmen (Eltern): Bei ElevenLabs bis zur Löschung

#### 6. Ihre Rechte

- **Auskunft:** Welche Daten haben wir?
- **Berichtigung:** Daten korrigieren
- **Löschung:** "Recht auf Vergessenwerden"
- **Datenübertragbarkeit:** Daten exportieren
- **Widerspruch:** Verarbeitung widersprechen
- **Beschwerde:** Bei Datenschutzbehörde

Kontakt: privacy@terapko.app

#### 7. Weitergabe an Dritte

- **Firebase (Google):** Hosting, Datenbank
- **ElevenLabs:** Voice Cloning (nur Eltern-Audio)
- **Google Gemini:** Audiogramm-Analyse (keine Speicherung)

Alle Dienste sind DSGVO-konform.

#### 8. Sicherheitsmaßnahmen

- TLS 1.3-Verschlüsselung
- AES-256-Verschlüsselung at-rest
- Zugriffskontrolle
- Regelmäßige Sicherheits-Audits

#### 9. Änderungen

Wir informieren Sie bei wesentlichen Änderungen per Email.

#### 10. Kontakt

Bei Fragen: privacy@terapko.app

---

**Letztes Update:** 17. Dezember 2025

---

## 11. Checklists

### Pre-Launch Security Checklist

- [ ] Firestore Security Rules getestet
- [ ] Firebase Storage Rules getestet
- [ ] Alle Eingaben validiert (XSS, SQL-Injection)
- [ ] HTTPS-Only erzwungen
- [ ] Passwort-Hashing (bcrypt/SHA-256)
- [ ] Verschlüsselung für sensitive Daten (Audiogramm)
- [ ] Rate Limiting implementiert
- [ ] Consent-Management funktioniert
- [ ] Privacy Policy verfügbar
- [ ] Daten-Export funktioniert
- [ ] Account-Löschung funktioniert
- [ ] Incident Response Plan dokumentiert
- [ ] Third-Party DPAs unterschrieben
- [ ] Penetration Test durchgeführt

### DSGVO-Compliance Checklist

- [ ] Rechtliche Grundlage dokumentiert
- [ ] Elterliche Einwilligung eingeholt
- [ ] Privacy Policy in einfacher Sprache
- [ ] Alle Rechte implementiert (Auskunft, Löschung, etc.)
- [ ] Datenminimierung umgesetzt
- [ ] Speicherdauer definiert
- [ ] Daten-Processing-Agreements mit Dritten
- [ ] Datenschutz-Folgenabschätzung (falls nötig)
- [ ] Datenschutzbeauftragter bestellt (falls >10 Mitarbeiter)

---

**Ende der Datenschutz-Dokumentation**

**Bei Fragen:** privacy@terapko.app  
**Für technische Sicherheit:** security@terapko.app

---

*"Datenschutz ist kein Feature - es ist ein Grundrecht."* 🔒
