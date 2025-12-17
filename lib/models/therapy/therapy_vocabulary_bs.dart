import 'package:flutter/material.dart' show Color;

/// Therapie-Wort mit Silben-Aufteilung und Metadaten
class TherapyWord {
  final String word;
  final List<String> syllables;
  final String imageAsset;
  final String category;
  final int difficulty; // 1-5
  final String? audioTip; // Aussprache-Tipp für Eltern
  final String? lipMovement; // Beschreibung der Lippenbewegung

  const TherapyWord({
    required this.word,
    required this.syllables,
    required this.imageAsset,
    required this.category,
    this.difficulty = 1,
    this.audioTip,
    this.lipMovement,
  });

  /// Anzahl der Silben
  int get syllableCount => syllables.length;

  /// Wort mit Bindestrichen (Ma-ma)
  String get hyphenated => syllables.join('-');
}

/// Therapie-Phrase für 2-3 Wort-Kombinationen
class TherapyPhrase {
  final String phrase;
  final List<String> words;
  final String meaning;
  final String context;
  final String imageAsset;
  final int difficulty;

  const TherapyPhrase({
    required this.phrase,
    required this.words,
    required this.meaning,
    required this.context,
    required this.imageAsset,
    this.difficulty = 2,
  });
}

/// Kategorie für Therapie-Wörter
class TherapyCategory {
  final String id;
  final String name;
  final String icon;
  final int colorValue;
  final List<TherapyWord> words;
  final int unlockLevel; // Ab welchem Level verfügbar

  const TherapyCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.colorValue,
    required this.words,
    this.unlockLevel = 1,
  });

  Color get color => Color(colorValue);
}

/// =================================================================
/// BOSNISCHE THERAPIE-WÖRTER FÜR 4-JÄHRIGEN MIT HÖRVERLUST
/// =================================================================
/// 
/// Aufbau nach logopädischen Prinzipien:
/// - Stufe 1: Einfache Wörter (1-2 Silben, einfache Laute)
/// - Stufe 2: Erweiterte Wörter (2-3 Silben)
/// - Stufe 3: Sätze (2-3 Wort-Kombinationen)
/// =================================================================

class TherapyVocabularyBS {
  
  // ================================================================
  // STUFE 1: ERSTE WÖRTER (Die wichtigsten 15 Wörter)
  // ================================================================
  // Fokus: Einfache Laute (M, P, B, D, T, N, A, O, U, I)
  // Diese Laute sind am einfachsten für schwerhörige Kinder
  
  static const porodica = TherapyCategory(
    id: 'porodica',
    name: 'Porodica',
    icon: '👨‍👩‍👧‍👦',
    colorValue: 0xFFE91E63,
    unlockLevel: 1,
    words: [
      TherapyWord(
        word: 'mama',
        syllables: ['ma', 'ma'],
        imageAsset: 'assets/therapy/porodica/mama.png',
        category: 'porodica',
        difficulty: 1,
        audioTip: 'Usta otvorena, jezik dole',
        lipMovement: 'Usne zatvorene → otvori usta',
      ),
      TherapyWord(
        word: 'papa',
        syllables: ['pa', 'pa'],
        imageAsset: 'assets/therapy/porodica/papa.png',
        category: 'porodica',
        difficulty: 1,
        audioTip: 'Usne zajedno, pa pusti zrak',
        lipMovement: 'Usne zatvorene → puhni',
      ),
      TherapyWord(
        word: 'tata',
        syllables: ['ta', 'ta'],
        imageAsset: 'assets/therapy/porodica/tata.png',
        category: 'porodica',
        difficulty: 1,
        audioTip: 'Jezik iza gornjih zuba',
      ),
      TherapyWord(
        word: 'baba',
        syllables: ['ba', 'ba'],
        imageAsset: 'assets/therapy/porodica/baba.png',
        category: 'porodica',
        difficulty: 1,
        audioTip: 'Kao "papa" ali sa glasom',
      ),
      TherapyWord(
        word: 'deda',
        syllables: ['de', 'da'],
        imageAsset: 'assets/therapy/porodica/deda.png',
        category: 'porodica',
        difficulty: 1,
      ),
      TherapyWord(
        word: 'beba',
        syllables: ['be', 'ba'],
        imageAsset: 'assets/therapy/porodica/beba.png',
        category: 'porodica',
        difficulty: 1,
      ),
    ],
  );

  static const osnovno = TherapyCategory(
    id: 'osnovno',
    name: 'Osnovno',
    icon: '✋',
    colorValue: 0xFF4CAF50,
    unlockLevel: 1,
    words: [
      TherapyWord(
        word: 'da',
        syllables: ['da'],
        imageAsset: 'assets/therapy/osnovno/da.png',
        category: 'osnovno',
        difficulty: 1,
        audioTip: 'Kratko i jasno',
      ),
      TherapyWord(
        word: 'ne',
        syllables: ['ne'],
        imageAsset: 'assets/therapy/osnovno/ne.png',
        category: 'osnovno',
        difficulty: 1,
      ),
      TherapyWord(
        word: 'evo',
        syllables: ['e', 'vo'],
        imageAsset: 'assets/therapy/osnovno/evo.png',
        category: 'osnovno',
        difficulty: 1,
        audioTip: 'Pokazuj rukom dok govoriš',
      ),
      TherapyWord(
        word: 'daj',
        syllables: ['daj'],
        imageAsset: 'assets/therapy/osnovno/daj.png',
        category: 'osnovno',
        difficulty: 1,
        audioTip: 'Pruži ruku dok govoriš',
      ),
      TherapyWord(
        word: 'hoću',
        syllables: ['ho', 'ću'],
        imageAsset: 'assets/therapy/osnovno/hocu.png',
        category: 'osnovno',
        difficulty: 2,
      ),
      TherapyWord(
        word: 'neću',
        syllables: ['ne', 'ću'],
        imageAsset: 'assets/therapy/osnovno/necu.png',
        category: 'osnovno',
        difficulty: 2,
      ),
      TherapyWord(
        word: 'molim',
        syllables: ['mo', 'lim'],
        imageAsset: 'assets/therapy/osnovno/molim.png',
        category: 'osnovno',
        difficulty: 2,
      ),
      TherapyWord(
        word: 'hvala',
        syllables: ['hva', 'la'],
        imageAsset: 'assets/therapy/osnovno/hvala.png',
        category: 'osnovno',
        difficulty: 2,
      ),
    ],
  );

  // ================================================================
  // STUFE 2: ERWEITERTE WÖRTER
  // ================================================================

  static const zivotinje = TherapyCategory(
    id: 'zivotinje',
    name: 'Životinje',
    icon: '🐾',
    colorValue: 0xFF795548,
    unlockLevel: 1,
    words: [
      TherapyWord(
        word: 'pas',
        syllables: ['pas'],
        imageAsset: 'assets/therapy/zivotinje/pas.png',
        category: 'zivotinje',
        difficulty: 1,
        audioTip: 'Reci "vau-vau" kao pas',
      ),
      TherapyWord(
        word: 'maca',
        syllables: ['ma', 'ca'],
        imageAsset: 'assets/therapy/zivotinje/maca.png',
        category: 'zivotinje',
        difficulty: 1,
        audioTip: 'Reci "mijau" kao mačka',
      ),
      TherapyWord(
        word: 'koka',
        syllables: ['ko', 'ka'],
        imageAsset: 'assets/therapy/zivotinje/koka.png',
        category: 'zivotinje',
        difficulty: 1,
      ),
      TherapyWord(
        word: 'ptica',
        syllables: ['pti', 'ca'],
        imageAsset: 'assets/therapy/zivotinje/ptica.png',
        category: 'zivotinje',
        difficulty: 2,
      ),
      TherapyWord(
        word: 'riba',
        syllables: ['ri', 'ba'],
        imageAsset: 'assets/therapy/zivotinje/riba.png',
        category: 'zivotinje',
        difficulty: 2,
      ),
      TherapyWord(
        word: 'konj',
        syllables: ['konj'],
        imageAsset: 'assets/therapy/zivotinje/konj.png',
        category: 'zivotinje',
        difficulty: 2,
      ),
      TherapyWord(
        word: 'krava',
        syllables: ['kra', 'va'],
        imageAsset: 'assets/therapy/zivotinje/krava.png',
        category: 'zivotinje',
        difficulty: 2,
        audioTip: 'Reci "muuu" kao krava',
      ),
      TherapyWord(
        word: 'ovca',
        syllables: ['ov', 'ca'],
        imageAsset: 'assets/therapy/zivotinje/ovca.png',
        category: 'zivotinje',
        difficulty: 2,
      ),
      TherapyWord(
        word: 'patka',
        syllables: ['pat', 'ka'],
        imageAsset: 'assets/therapy/zivotinje/patka.png',
        category: 'zivotinje',
        difficulty: 2,
      ),
      TherapyWord(
        word: 'zeka',
        syllables: ['ze', 'ka'],
        imageAsset: 'assets/therapy/zivotinje/zeka.png',
        category: 'zivotinje',
        difficulty: 2,
      ),
    ],
  );

  static const hrana = TherapyCategory(
    id: 'hrana',
    name: 'Hrana',
    icon: '🍎',
    colorValue: 0xFFFF9800,
    unlockLevel: 1,
    words: [
      TherapyWord(
        word: 'voda',
        syllables: ['vo', 'da'],
        imageAsset: 'assets/therapy/hrana/voda.png',
        category: 'hrana',
        difficulty: 1,
        audioTip: 'Jako važna riječ!',
      ),
      TherapyWord(
        word: 'sok',
        syllables: ['sok'],
        imageAsset: 'assets/therapy/hrana/sok.png',
        category: 'hrana',
        difficulty: 1,
      ),
      TherapyWord(
        word: 'hljeb',
        syllables: ['hljeb'],
        imageAsset: 'assets/therapy/hrana/hljeb.png',
        category: 'hrana',
        difficulty: 2,
      ),
      TherapyWord(
        word: 'jabuka',
        syllables: ['ja', 'bu', 'ka'],
        imageAsset: 'assets/therapy/hrana/jabuka.png',
        category: 'hrana',
        difficulty: 2,
      ),
      TherapyWord(
        word: 'banana',
        syllables: ['ba', 'na', 'na'],
        imageAsset: 'assets/therapy/hrana/banana.png',
        category: 'hrana',
        difficulty: 2,
      ),
      TherapyWord(
        word: 'mlijeko',
        syllables: ['mli', 'je', 'ko'],
        imageAsset: 'assets/therapy/hrana/mlijeko.png',
        category: 'hrana',
        difficulty: 2,
      ),
      TherapyWord(
        word: 'kolač',
        syllables: ['ko', 'lač'],
        imageAsset: 'assets/therapy/hrana/kolac.png',
        category: 'hrana',
        difficulty: 2,
      ),
      TherapyWord(
        word: 'jaje',
        syllables: ['ja', 'je'],
        imageAsset: 'assets/therapy/hrana/jaje.png',
        category: 'hrana',
        difficulty: 2,
      ),
    ],
  );

  static const tijelo = TherapyCategory(
    id: 'tijelo',
    name: 'Tijelo',
    icon: '🖐️',
    colorValue: 0xFF2196F3,
    unlockLevel: 1,
    words: [
      TherapyWord(
        word: 'ruka',
        syllables: ['ru', 'ka'],
        imageAsset: 'assets/therapy/tijelo/ruka.png',
        category: 'tijelo',
        difficulty: 1,
        audioTip: 'Pokaži svoju ruku!',
      ),
      TherapyWord(
        word: 'noga',
        syllables: ['no', 'ga'],
        imageAsset: 'assets/therapy/tijelo/noga.png',
        category: 'tijelo',
        difficulty: 1,
      ),
      TherapyWord(
        word: 'oko',
        syllables: ['o', 'ko'],
        imageAsset: 'assets/therapy/tijelo/oko.png',
        category: 'tijelo',
        difficulty: 1,
      ),
      TherapyWord(
        word: 'uho',
        syllables: ['u', 'ho'],
        imageAsset: 'assets/therapy/tijelo/uho.png',
        category: 'tijelo',
        difficulty: 1,
        audioTip: 'Pokaži svoje uho - slušaj dobro!',
      ),
      TherapyWord(
        word: 'nos',
        syllables: ['nos'],
        imageAsset: 'assets/therapy/tijelo/nos.png',
        category: 'tijelo',
        difficulty: 1,
      ),
      TherapyWord(
        word: 'usta',
        syllables: ['us', 'ta'],
        imageAsset: 'assets/therapy/tijelo/usta.png',
        category: 'tijelo',
        difficulty: 1,
      ),
      TherapyWord(
        word: 'glava',
        syllables: ['gla', 'va'],
        imageAsset: 'assets/therapy/tijelo/glava.png',
        category: 'tijelo',
        difficulty: 2,
      ),
      TherapyWord(
        word: 'trbuh',
        syllables: ['tr', 'buh'],
        imageAsset: 'assets/therapy/tijelo/trbuh.png',
        category: 'tijelo',
        difficulty: 2,
      ),
    ],
  );

  static const boje = TherapyCategory(
    id: 'boje',
    name: 'Boje',
    icon: '🌈',
    colorValue: 0xFF9C27B0,
    unlockLevel: 2,
    words: [
      TherapyWord(
        word: 'crveno',
        syllables: ['cr', 've', 'no'],
        imageAsset: 'assets/therapy/boje/crveno.png',
        category: 'boje',
        difficulty: 2,
      ),
      TherapyWord(
        word: 'plavo',
        syllables: ['pla', 'vo'],
        imageAsset: 'assets/therapy/boje/plavo.png',
        category: 'boje',
        difficulty: 2,
      ),
      TherapyWord(
        word: 'žuto',
        syllables: ['žu', 'to'],
        imageAsset: 'assets/therapy/boje/zuto.png',
        category: 'boje',
        difficulty: 2,
      ),
      TherapyWord(
        word: 'zeleno',
        syllables: ['ze', 'le', 'no'],
        imageAsset: 'assets/therapy/boje/zeleno.png',
        category: 'boje',
        difficulty: 2,
      ),
      TherapyWord(
        word: 'bijelo',
        syllables: ['bi', 'je', 'lo'],
        imageAsset: 'assets/therapy/boje/bijelo.png',
        category: 'boje',
        difficulty: 2,
      ),
      TherapyWord(
        word: 'crno',
        syllables: ['cr', 'no'],
        imageAsset: 'assets/therapy/boje/crno.png',
        category: 'boje',
        difficulty: 2,
      ),
    ],
  );

  static const igracke = TherapyCategory(
    id: 'igracke',
    name: 'Igračke',
    icon: '🧸',
    colorValue: 0xFFFF5722,
    unlockLevel: 2,
    words: [
      TherapyWord(
        word: 'lopta',
        syllables: ['lop', 'ta'],
        imageAsset: 'assets/therapy/igracke/lopta.png',
        category: 'igracke',
        difficulty: 1,
      ),
      TherapyWord(
        word: 'auto',
        syllables: ['au', 'to'],
        imageAsset: 'assets/therapy/igracke/auto.png',
        category: 'igracke',
        difficulty: 1,
        audioTip: 'Reci "brum-brum"!',
      ),
      TherapyWord(
        word: 'lutka',
        syllables: ['lut', 'ka'],
        imageAsset: 'assets/therapy/igracke/lutka.png',
        category: 'igracke',
        difficulty: 2,
      ),
      TherapyWord(
        word: 'kocka',
        syllables: ['koc', 'ka'],
        imageAsset: 'assets/therapy/igracke/kocka.png',
        category: 'igracke',
        difficulty: 2,
      ),
      TherapyWord(
        word: 'medo',
        syllables: ['me', 'do'],
        imageAsset: 'assets/therapy/igracke/medo.png',
        category: 'igracke',
        difficulty: 1,
      ),
    ],
  );

  static const brojevi = TherapyCategory(
    id: 'brojevi',
    name: 'Brojevi',
    icon: '🔢',
    colorValue: 0xFF00BCD4,
    unlockLevel: 2,
    words: [
      TherapyWord(
        word: 'jedan',
        syllables: ['je', 'dan'],
        imageAsset: 'assets/therapy/brojevi/1.png',
        category: 'brojevi',
        difficulty: 2,
        audioTip: 'Pokaži 1 prst',
      ),
      TherapyWord(
        word: 'dva',
        syllables: ['dva'],
        imageAsset: 'assets/therapy/brojevi/2.png',
        category: 'brojevi',
        difficulty: 2,
      ),
      TherapyWord(
        word: 'tri',
        syllables: ['tri'],
        imageAsset: 'assets/therapy/brojevi/3.png',
        category: 'brojevi',
        difficulty: 2,
      ),
      TherapyWord(
        word: 'četiri',
        syllables: ['če', 'ti', 'ri'],
        imageAsset: 'assets/therapy/brojevi/4.png',
        category: 'brojevi',
        difficulty: 3,
      ),
      TherapyWord(
        word: 'pet',
        syllables: ['pet'],
        imageAsset: 'assets/therapy/brojevi/5.png',
        category: 'brojevi',
        difficulty: 2,
      ),
    ],
  );

  // ================================================================
  // STUFE 3: SÄTZE (2-3 Wort-Kombinationen)
  // ================================================================

  static const phrases = [
    TherapyPhrase(
      phrase: 'Daj mi',
      words: ['daj', 'mi'],
      meaning: 'Gib mir',
      context: 'Kada želiš nešto',
      imageAsset: 'assets/therapy/fraze/daj_mi.png',
      difficulty: 2,
    ),
    TherapyPhrase(
      phrase: 'Hoću jesti',
      words: ['hoću', 'jesti'],
      meaning: 'Ich will essen',
      context: 'Kada si gladan',
      imageAsset: 'assets/therapy/fraze/hocu_jesti.png',
      difficulty: 2,
    ),
    TherapyPhrase(
      phrase: 'Hoću piti',
      words: ['hoću', 'piti'],
      meaning: 'Ich will trinken',
      context: 'Kada si žedan',
      imageAsset: 'assets/therapy/fraze/hocu_piti.png',
      difficulty: 2,
    ),
    TherapyPhrase(
      phrase: 'Mama dođi',
      words: ['mama', 'dođi'],
      meaning: 'Mama komm',
      context: 'Kada treba mama',
      imageAsset: 'assets/therapy/fraze/mama_dodi.png',
      difficulty: 2,
    ),
    TherapyPhrase(
      phrase: 'Još malo',
      words: ['još', 'malo'],
      meaning: 'Noch ein bisschen',
      context: 'Kada hoćeš još',
      imageAsset: 'assets/therapy/fraze/jos_malo.png',
      difficulty: 2,
    ),
    TherapyPhrase(
      phrase: 'Volim te',
      words: ['volim', 'te'],
      meaning: 'Ich liebe dich',
      context: 'Za mamu, papu, babu...',
      imageAsset: 'assets/therapy/fraze/volim_te.png',
      difficulty: 2,
    ),
    TherapyPhrase(
      phrase: 'Daj loptu',
      words: ['daj', 'loptu'],
      meaning: 'Gib den Ball',
      context: 'Kada se igraš',
      imageAsset: 'assets/therapy/fraze/daj_loptu.png',
      difficulty: 2,
    ),
    TherapyPhrase(
      phrase: 'Gdje je mama',
      words: ['gdje', 'je', 'mama'],
      meaning: 'Wo ist Mama',
      context: 'Kada tražiš mamu',
      imageAsset: 'assets/therapy/fraze/gdje_mama.png',
      difficulty: 3,
    ),
  ];

  // ================================================================
  // TIER-GERÄUSCHE FÜR HÖR-TRAINING
  // ================================================================

  static const animalSounds = [
    AnimalSound(
      animal: 'pas',
      sound: 'vau-vau',
      audioAsset: 'assets/therapy/sounds/pas.mp3',
      imageAsset: 'assets/therapy/zivotinje/pas.png',
    ),
    AnimalSound(
      animal: 'mačka',
      sound: 'mijau',
      audioAsset: 'assets/therapy/sounds/macka.mp3',
      imageAsset: 'assets/therapy/zivotinje/maca.png',
    ),
    AnimalSound(
      animal: 'krava',
      sound: 'muuu',
      audioAsset: 'assets/therapy/sounds/krava.mp3',
      imageAsset: 'assets/therapy/zivotinje/krava.png',
    ),
    AnimalSound(
      animal: 'ptica',
      sound: 'ćir-ćir',
      audioAsset: 'assets/therapy/sounds/ptica.mp3',
      imageAsset: 'assets/therapy/zivotinje/ptica.png',
    ),
    AnimalSound(
      animal: 'patka',
      sound: 'kva-kva',
      audioAsset: 'assets/therapy/sounds/patka.mp3',
      imageAsset: 'assets/therapy/zivotinje/patka.png',
    ),
    AnimalSound(
      animal: 'ovca',
      sound: 'beee',
      audioAsset: 'assets/therapy/sounds/ovca.mp3',
      imageAsset: 'assets/therapy/zivotinje/ovca.png',
    ),
    AnimalSound(
      animal: 'konj',
      sound: 'ihaaa',
      audioAsset: 'assets/therapy/sounds/konj.mp3',
      imageAsset: 'assets/therapy/zivotinje/konj.png',
    ),
    AnimalSound(
      animal: 'koka',
      sound: 'ko-ko-ko',
      audioAsset: 'assets/therapy/sounds/koka.mp3',
      imageAsset: 'assets/therapy/zivotinje/koka.png',
    ),
  ];

  // ================================================================
  // HELPER METHODS
  // ================================================================

  /// Gibt alle Kategorien zurück
  static List<TherapyCategory> getAll() => [
    porodica,
    osnovno,
    zivotinje,
    hrana,
    tijelo,
    boje,
    igracke,
    brojevi,
  ];

  /// Kategorien für ein bestimmtes Level
  static List<TherapyCategory> getForLevel(int level) {
    return getAll().where((c) => c.unlockLevel <= level).toList();
  }

  /// Erste 10 wichtigste Wörter für Anfang
  static List<TherapyWord> getStarterWords() {
    return [
      porodica.words[0], // mama
      porodica.words[1], // papa
      osnovno.words[0],  // da
      osnovno.words[1],  // ne
      osnovno.words[3],  // daj
      hrana.words[0],    // voda
      zivotinje.words[0], // pas
      igracke.words[0],   // lopta
      tijelo.words[0],    // ruka
      porodica.words[3],  // baba
    ];
  }

  /// Wörter nach Schwierigkeit
  static List<TherapyWord> getByDifficulty(int difficulty) {
    final allWords = <TherapyWord>[];
    for (final category in getAll()) {
      allWords.addAll(
        category.words.where((w) => w.difficulty == difficulty)
      );
    }
    return allWords;
  }

  /// Anzahl aller Wörter
  static int get totalWordCount {
    return getAll().fold<int>(0, (sum, c) => sum + c.words.length);
  }
}

/// Tiergeräusch für Hörtraining
class AnimalSound {
  final String animal;
  final String sound;
  final String audioAsset;
  final String imageAsset;

  const AnimalSound({
    required this.animal,
    required this.sound,
    required this.audioAsset,
    required this.imageAsset,
  });
}

/// =================================================================
/// SILBEN-TRAINING DATEN
/// =================================================================

class SyllableTrainingBS {
  
  /// Einfache Silben (CV-Struktur)
  static const basicSyllables = [
    // Mit A
    'ma', 'pa', 'ba', 'da', 'ta', 'na', 'ka', 'ga',
    // Mit O
    'mo', 'po', 'bo', 'do', 'to', 'no', 'ko', 'go',
    // Mit U
    'mu', 'pu', 'bu', 'du', 'tu', 'nu', 'ku', 'gu',
    // Mit I
    'mi', 'pi', 'bi', 'di', 'ti', 'ni', 'ki', 'gi',
    // Mit E
    'me', 'pe', 'be', 'de', 'te', 'ne', 'ke', 'ge',
  ];

  /// Silbenketten zum Üben
  static const syllableChains = [
    // Wiederholung (leicht)
    ['ma', 'ma', 'ma'],
    ['pa', 'pa', 'pa'],
    ['ba', 'ba', 'ba'],
    
    // Wechsel (mittel)
    ['ma', 'pa', 'ma'],
    ['pa', 'ma', 'pa'],
    ['ba', 'da', 'ba'],
    
    // Drei verschiedene (schwer)
    ['ma', 'pa', 'ba'],
    ['da', 'ta', 'na'],
    ['ko', 'go', 'no'],
  ];

  /// Silben nach Schwierigkeit
  static List<String> getSyllablesByDifficulty(int level) {
    switch (level) {
      case 1:
        // Nur mit A und O (am einfachsten)
        return ['ma', 'pa', 'ba', 'da', 'mo', 'po', 'bo', 'do'];
      case 2:
        // Alle einfachen
        return basicSyllables;
      case 3:
        // + komplexere Silben
        return [...basicSyllables, 'tra', 'kra', 'pra', 'bra'];
      default:
        return basicSyllables;
    }
  }
}

/// =================================================================
/// FEEDBACK-TEXTE AUF BOSNISCH
/// =================================================================

class TherapyFeedbackBS {
  
  static const correct = [
    'Bravo!',
    'Super!',
    'Odlično!',
    'Svaka čast!',
    'Tako je!',
    'Baš tako!',
    'Perfektno!',
    'Ti si šampion!',
  ];

  static const almostCorrect = [
    'Skoro savršeno!',
    'Jako dobro!',
    'Bravo, samo malo sporije!',
    'Super, pokušaj još jednom!',
  ];

  static const tryAgain = [
    'Hajde ponovo!',
    'Još jednom!',
    'Pokušaj opet!',
    'Slušaj pa ponovi!',
  ];

  static const encouragement = [
    'Možeš ti to!',
    'Polako, nije problem!',
    'Slušaj i ponovi!',
    'Mama te voli, pokušaj opet!',
    'Ti si hrabar!',
    'Lianko vjeruje u tebe!',
  ];

  static const dailyGreetings = [
    'Zdravo! Hajmo učiti!',
    'Lianko te čeka!',
    'Lijepo te vidjeti!',
    'Spremni za igru?',
    'Danas ćemo se zabavljati!',
  ];

  static const sessionComplete = [
    'Završeno za danas! Bravo!',
    'Super si bio/bila!',
    'Sutra opet! Volim te!',
    'Zaslužio/la si nagradu!',
  ];
}
