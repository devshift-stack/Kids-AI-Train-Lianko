#!/bin/bash

# Asset Generator V2 für Lianko App
# Größere Emojis, bessere Farben, schöneres Design

ASSETS_DIR="/Users/dsselmanovic/devshift-stack/Kids-AI-Train-Lianko/assets"

# Funktion zum Erstellen eines verbesserten SVG
create_svg() {
    local path="$1"
    local text="$2"
    local emoji="$3"
    local bg_color="$4"
    local accent_color="${5:-#333333}"

    cat > "$path" << EOF
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
  <defs>
    <linearGradient id="bg_${RANDOM}" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:${bg_color};stop-opacity:1" />
      <stop offset="100%" style="stop-color:${bg_color};stop-opacity:0.7" />
    </linearGradient>
    <filter id="shadow_${RANDOM}" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="4" stdDeviation="8" flood-opacity="0.2"/>
    </filter>
  </defs>
  <rect width="512" height="512" rx="60" fill="url(#bg_${RANDOM})"/>
  <circle cx="256" cy="200" r="140" fill="white" opacity="0.3"/>
  <text x="256" y="240" font-size="180" text-anchor="middle" filter="url(#shadow_${RANDOM})">${emoji}</text>
  <rect x="40" y="380" width="432" height="90" rx="20" fill="white" opacity="0.9"/>
  <text x="256" y="440" font-size="52" font-family="Arial Rounded MT Bold, Arial, sans-serif" font-weight="bold" text-anchor="middle" fill="${accent_color}">${text}</text>
</svg>
EOF
    echo "✓ $path"
}

echo "🎨 Erstelle verbesserte Assets V2..."
echo ""

# ==================== COMMUNICATION ====================
echo "📁 Communication (47 Bilder)..."

# Schmerzen (rot) - #E53935
create_svg "$ASSETS_DIR/communication/schmerzen/kopf.png" "Kopf tut weh" "🤕" "#FFCDD2" "#C62828"
create_svg "$ASSETS_DIR/communication/schmerzen/bauch.png" "Bauch tut weh" "🤢" "#FFCDD2" "#C62828"
create_svg "$ASSETS_DIR/communication/schmerzen/hals.png" "Hals tut weh" "😷" "#FFCDD2" "#C62828"
create_svg "$ASSETS_DIR/communication/schmerzen/ohr.png" "Ohr tut weh" "👂" "#FFCDD2" "#C62828"
create_svg "$ASSETS_DIR/communication/schmerzen/zahn.png" "Zahn tut weh" "🦷" "#FFCDD2" "#C62828"
create_svg "$ASSETS_DIR/communication/schmerzen/bein.png" "Bein tut weh" "🦵" "#FFCDD2" "#C62828"
create_svg "$ASSETS_DIR/communication/schmerzen/arm.png" "Arm tut weh" "💪" "#FFCDD2" "#C62828"

# Essen (orange) - #FF9800
create_svg "$ASSETS_DIR/communication/essen/fruehstueck.png" "Frühstück" "🍳" "#FFE0B2" "#E65100"
create_svg "$ASSETS_DIR/communication/essen/muesli.png" "Müsli" "🥣" "#FFE0B2" "#E65100"
create_svg "$ASSETS_DIR/communication/essen/brot.png" "Brot" "🍞" "#FFE0B2" "#E65100"
create_svg "$ASSETS_DIR/communication/essen/ei.png" "Ei" "🥚" "#FFE0B2" "#E65100"
create_svg "$ASSETS_DIR/communication/essen/mittag.png" "Mittagessen" "🍽️" "#FFE0B2" "#E65100"
create_svg "$ASSETS_DIR/communication/essen/snack.png" "Snack" "🍪" "#FFE0B2" "#E65100"
create_svg "$ASSETS_DIR/communication/essen/obst.png" "Obst" "🍎" "#FFE0B2" "#E65100"
create_svg "$ASSETS_DIR/communication/essen/kekse.png" "Kekse" "🍪" "#FFE0B2" "#E65100"
create_svg "$ASSETS_DIR/communication/essen/suess.png" "Süßigkeiten" "🍬" "#FFE0B2" "#E65100"
create_svg "$ASSETS_DIR/communication/essen/abend.png" "Abendessen" "🌙" "#FFE0B2" "#E65100"

# Trinken (blau) - #2196F3
create_svg "$ASSETS_DIR/communication/trinken/wasser.png" "Wasser" "💧" "#BBDEFB" "#1565C0"
create_svg "$ASSETS_DIR/communication/trinken/saft.png" "Saft" "🧃" "#BBDEFB" "#1565C0"
create_svg "$ASSETS_DIR/communication/trinken/milch.png" "Milch" "🥛" "#BBDEFB" "#1565C0"
create_svg "$ASSETS_DIR/communication/trinken/kakao.png" "Kakao" "☕" "#BBDEFB" "#1565C0"
create_svg "$ASSETS_DIR/communication/trinken/tee.png" "Tee" "🍵" "#BBDEFB" "#1565C0"

# Gefühle (pink) - #E91E63
create_svg "$ASSETS_DIR/communication/gefuehle/gluecklich.png" "Glücklich" "😊" "#F8BBD0" "#AD1457"
create_svg "$ASSETS_DIR/communication/gefuehle/traurig.png" "Traurig" "😢" "#F8BBD0" "#AD1457"
create_svg "$ASSETS_DIR/communication/gefuehle/wuetend.png" "Wütend" "😠" "#F8BBD0" "#AD1457"
create_svg "$ASSETS_DIR/communication/gefuehle/muede.png" "Müde" "😴" "#F8BBD0" "#AD1457"
create_svg "$ASSETS_DIR/communication/gefuehle/angst.png" "Ängstlich" "😨" "#F8BBD0" "#AD1457"
create_svg "$ASSETS_DIR/communication/gefuehle/langweilig.png" "Langweilig" "😐" "#F8BBD0" "#AD1457"

# Aktivitäten (lila) - #9C27B0
create_svg "$ASSETS_DIR/communication/aktivitaeten/spielen.png" "Spielen" "🎮" "#E1BEE7" "#6A1B9A"
create_svg "$ASSETS_DIR/communication/aktivitaeten/fernsehen.png" "Fernsehen" "📺" "#E1BEE7" "#6A1B9A"
create_svg "$ASSETS_DIR/communication/aktivitaeten/draussen.png" "Draußen" "🌳" "#E1BEE7" "#6A1B9A"
create_svg "$ASSETS_DIR/communication/aktivitaeten/schlafen.png" "Schlafen" "🛏️" "#E1BEE7" "#6A1B9A"
create_svg "$ASSETS_DIR/communication/aktivitaeten/kuscheln.png" "Kuscheln" "🤗" "#E1BEE7" "#6A1B9A"
create_svg "$ASSETS_DIR/communication/aktivitaeten/vorlesen.png" "Vorlesen" "📖" "#E1BEE7" "#6A1B9A"

# Toilette (cyan) - #00BCD4
create_svg "$ASSETS_DIR/communication/toilette/wc.png" "Toilette" "🚽" "#B2EBF2" "#00838F"
create_svg "$ASSETS_DIR/communication/toilette/haende.png" "Hände waschen" "🧼" "#B2EBF2" "#00838F"
create_svg "$ASSETS_DIR/communication/toilette/baden.png" "Baden" "🛁" "#B2EBF2" "#00838F"
create_svg "$ASSETS_DIR/communication/toilette/zaehne.png" "Zähne putzen" "🪥" "#B2EBF2" "#00838F"

# Hilfe (rot-orange) - #FF5722
create_svg "$ASSETS_DIR/communication/hilfe/hilfe.png" "Hilfe!" "🆘" "#FFCCBC" "#BF360C"
create_svg "$ASSETS_DIR/communication/hilfe/verstehe.png" "Verstehe nicht" "❓" "#FFCCBC" "#BF360C"
create_svg "$ASSETS_DIR/communication/hilfe/nochmal.png" "Nochmal" "🔄" "#FFCCBC" "#BF360C"

# Ja/Nein
create_svg "$ASSETS_DIR/communication/janein/ja.png" "Ja" "✅" "#C8E6C9" "#2E7D32"
create_svg "$ASSETS_DIR/communication/janein/nein.png" "Nein" "❌" "#FFCDD2" "#C62828"
create_svg "$ASSETS_DIR/communication/janein/vielleicht.png" "Vielleicht" "🤔" "#FFF9C4" "#F57F17"

# Menschen (braun) - #795548
create_svg "$ASSETS_DIR/communication/menschen/mama.png" "Mama" "👩" "#D7CCC8" "#4E342E"
create_svg "$ASSETS_DIR/communication/menschen/papa.png" "Papa" "👨" "#D7CCC8" "#4E342E"
create_svg "$ASSETS_DIR/communication/menschen/oma.png" "Oma" "👵" "#D7CCC8" "#4E342E"
create_svg "$ASSETS_DIR/communication/menschen/opa.png" "Opa" "👴" "#D7CCC8" "#4E342E"
create_svg "$ASSETS_DIR/communication/menschen/geschwister.png" "Geschwister" "👧👦" "#D7CCC8" "#4E342E"

# Orte (blau-grau) - #607D8B
create_svg "$ASSETS_DIR/communication/orte/zuhause.png" "Zuhause" "🏠" "#CFD8DC" "#37474F"
create_svg "$ASSETS_DIR/communication/orte/draussen.png" "Draußen" "🌲" "#CFD8DC" "#37474F"
create_svg "$ASSETS_DIR/communication/orte/spielplatz.png" "Spielplatz" "🎠" "#CFD8DC" "#37474F"
create_svg "$ASSETS_DIR/communication/orte/arzt.png" "Arzt" "🏥" "#CFD8DC" "#37474F"

# ==================== VOCABULARY ====================
echo ""
echo "📁 Vocabulary (54 Bilder)..."

# Tiere (grün) - #4CAF50
create_svg "$ASSETS_DIR/vocabulary/tiere/hund.png" "Hund" "🐕" "#C8E6C9" "#2E7D32"
create_svg "$ASSETS_DIR/vocabulary/tiere/katze.png" "Katze" "🐱" "#C8E6C9" "#2E7D32"
create_svg "$ASSETS_DIR/vocabulary/tiere/maus.png" "Maus" "🐭" "#C8E6C9" "#2E7D32"
create_svg "$ASSETS_DIR/vocabulary/tiere/vogel.png" "Vogel" "🐦" "#C8E6C9" "#2E7D32"
create_svg "$ASSETS_DIR/vocabulary/tiere/fisch.png" "Fisch" "🐟" "#C8E6C9" "#2E7D32"
create_svg "$ASSETS_DIR/vocabulary/tiere/pferd.png" "Pferd" "🐴" "#C8E6C9" "#2E7D32"
create_svg "$ASSETS_DIR/vocabulary/tiere/kuh.png" "Kuh" "🐄" "#C8E6C9" "#2E7D32"
create_svg "$ASSETS_DIR/vocabulary/tiere/schwein.png" "Schwein" "🐷" "#C8E6C9" "#2E7D32"
create_svg "$ASSETS_DIR/vocabulary/tiere/schaf.png" "Schaf" "🐑" "#C8E6C9" "#2E7D32"
create_svg "$ASSETS_DIR/vocabulary/tiere/huhn.png" "Huhn" "🐔" "#C8E6C9" "#2E7D32"

# Familie (pink) - #E91E63
create_svg "$ASSETS_DIR/vocabulary/familie/mama.png" "Mama" "👩" "#F8BBD0" "#AD1457"
create_svg "$ASSETS_DIR/vocabulary/familie/papa.png" "Papa" "👨" "#BBDEFB" "#1565C0"
create_svg "$ASSETS_DIR/vocabulary/familie/oma.png" "Oma" "👵" "#F8BBD0" "#AD1457"
create_svg "$ASSETS_DIR/vocabulary/familie/opa.png" "Opa" "👴" "#BBDEFB" "#1565C0"
create_svg "$ASSETS_DIR/vocabulary/familie/bruder.png" "Bruder" "👦" "#BBDEFB" "#1565C0"
create_svg "$ASSETS_DIR/vocabulary/familie/schwester.png" "Schwester" "👧" "#F8BBD0" "#AD1457"
create_svg "$ASSETS_DIR/vocabulary/familie/baby.png" "Baby" "👶" "#FFF9C4" "#F57F17"
create_svg "$ASSETS_DIR/vocabulary/familie/tante.png" "Tante" "👩" "#F8BBD0" "#AD1457"
create_svg "$ASSETS_DIR/vocabulary/familie/onkel.png" "Onkel" "👨" "#BBDEFB" "#1565C0"

# Essen (orange) - #FF9800
create_svg "$ASSETS_DIR/vocabulary/essen/apfel.png" "Apfel" "🍎" "#FFCDD2" "#C62828"
create_svg "$ASSETS_DIR/vocabulary/essen/banane.png" "Banane" "🍌" "#FFF9C4" "#F57F17"
create_svg "$ASSETS_DIR/vocabulary/essen/brot.png" "Brot" "🍞" "#FFE0B2" "#E65100"
create_svg "$ASSETS_DIR/vocabulary/essen/milch.png" "Milch" "🥛" "#ECEFF1" "#37474F"
create_svg "$ASSETS_DIR/vocabulary/essen/wasser.png" "Wasser" "💧" "#BBDEFB" "#1565C0"
create_svg "$ASSETS_DIR/vocabulary/essen/kaese.png" "Käse" "🧀" "#FFF9C4" "#F57F17"
create_svg "$ASSETS_DIR/vocabulary/essen/ei.png" "Ei" "🥚" "#ECEFF1" "#37474F"
create_svg "$ASSETS_DIR/vocabulary/essen/kuchen.png" "Kuchen" "🎂" "#F8BBD0" "#AD1457"

# Körper (blau) - #2196F3
create_svg "$ASSETS_DIR/vocabulary/koerper/hand.png" "Hand" "✋" "#FFE0B2" "#E65100"
create_svg "$ASSETS_DIR/vocabulary/koerper/fuss.png" "Fuß" "🦶" "#FFE0B2" "#E65100"
create_svg "$ASSETS_DIR/vocabulary/koerper/kopf.png" "Kopf" "🗣️" "#FFE0B2" "#E65100"
create_svg "$ASSETS_DIR/vocabulary/koerper/auge.png" "Auge" "👁️" "#BBDEFB" "#1565C0"
create_svg "$ASSETS_DIR/vocabulary/koerper/ohr.png" "Ohr" "👂" "#FFE0B2" "#E65100"
create_svg "$ASSETS_DIR/vocabulary/koerper/nase.png" "Nase" "👃" "#FFE0B2" "#E65100"
create_svg "$ASSETS_DIR/vocabulary/koerper/mund.png" "Mund" "👄" "#FFCDD2" "#C62828"
create_svg "$ASSETS_DIR/vocabulary/koerper/bauch.png" "Bauch" "🫃" "#FFE0B2" "#E65100"

# Farben - echte Farben als Hintergrund
create_svg "$ASSETS_DIR/vocabulary/farben/rot.png" "Rot" "❤️" "#EF5350" "#FFFFFF"
create_svg "$ASSETS_DIR/vocabulary/farben/blau.png" "Blau" "💙" "#42A5F5" "#FFFFFF"
create_svg "$ASSETS_DIR/vocabulary/farben/gruen.png" "Grün" "💚" "#66BB6A" "#FFFFFF"
create_svg "$ASSETS_DIR/vocabulary/farben/gelb.png" "Gelb" "💛" "#FFEE58" "#333333"
create_svg "$ASSETS_DIR/vocabulary/farben/orange.png" "Orange" "🧡" "#FFA726" "#FFFFFF"
create_svg "$ASSETS_DIR/vocabulary/farben/lila.png" "Lila" "💜" "#AB47BC" "#FFFFFF"
create_svg "$ASSETS_DIR/vocabulary/farben/rosa.png" "Rosa" "💗" "#F48FB1" "#FFFFFF"
create_svg "$ASSETS_DIR/vocabulary/farben/weiss.png" "Weiß" "🤍" "#FAFAFA" "#333333"
create_svg "$ASSETS_DIR/vocabulary/farben/schwarz.png" "Schwarz" "🖤" "#424242" "#FFFFFF"

# Zahlen (cyan) - #00BCD4
create_svg "$ASSETS_DIR/vocabulary/zahlen/1.png" "Eins" "1️⃣" "#B2EBF2" "#00838F"
create_svg "$ASSETS_DIR/vocabulary/zahlen/2.png" "Zwei" "2️⃣" "#B2EBF2" "#00838F"
create_svg "$ASSETS_DIR/vocabulary/zahlen/3.png" "Drei" "3️⃣" "#B2EBF2" "#00838F"
create_svg "$ASSETS_DIR/vocabulary/zahlen/4.png" "Vier" "4️⃣" "#B2EBF2" "#00838F"
create_svg "$ASSETS_DIR/vocabulary/zahlen/5.png" "Fünf" "5️⃣" "#B2EBF2" "#00838F"
create_svg "$ASSETS_DIR/vocabulary/zahlen/6.png" "Sechs" "6️⃣" "#B2EBF2" "#00838F"
create_svg "$ASSETS_DIR/vocabulary/zahlen/7.png" "Sieben" "7️⃣" "#B2EBF2" "#00838F"
create_svg "$ASSETS_DIR/vocabulary/zahlen/8.png" "Acht" "8️⃣" "#B2EBF2" "#00838F"
create_svg "$ASSETS_DIR/vocabulary/zahlen/9.png" "Neun" "9️⃣" "#B2EBF2" "#00838F"
create_svg "$ASSETS_DIR/vocabulary/zahlen/10.png" "Zehn" "🔟" "#B2EBF2" "#00838F"

# ==================== SYLLABLES ====================
echo ""
echo "📁 Syllables (34 Bilder)..."

# Leicht (1-2 Silben)
create_svg "$ASSETS_DIR/syllables/apfel.png" "Ap-fel" "🍎" "#C8E6C9" "#2E7D32"
create_svg "$ASSETS_DIR/syllables/hase.png" "Ha-se" "🐰" "#F8BBD0" "#AD1457"
create_svg "$ASSETS_DIR/syllables/sonne.png" "Son-ne" "☀️" "#FFF9C4" "#F57F17"
create_svg "$ASSETS_DIR/syllables/blume.png" "Blu-me" "🌸" "#F8BBD0" "#AD1457"
create_svg "$ASSETS_DIR/syllables/hunde.png" "Hun-de" "🐕" "#D7CCC8" "#4E342E"
create_svg "$ASSETS_DIR/syllables/katze.png" "Kat-ze" "🐱" "#FFE0B2" "#E65100"
create_svg "$ASSETS_DIR/syllables/mama.png" "Ma-ma" "👩" "#F8BBD0" "#AD1457"
create_svg "$ASSETS_DIR/syllables/papa.png" "Pa-pa" "👨" "#BBDEFB" "#1565C0"
create_svg "$ASSETS_DIR/syllables/oma.png" "O-ma" "👵" "#E1BEE7" "#6A1B9A"
create_svg "$ASSETS_DIR/syllables/opa.png" "O-pa" "👴" "#CFD8DC" "#37474F"
create_svg "$ASSETS_DIR/syllables/auto.png" "Au-to" "🚗" "#FFCDD2" "#C62828"
create_svg "$ASSETS_DIR/syllables/bett.png" "Bett" "🛏️" "#E1BEE7" "#6A1B9A"
create_svg "$ASSETS_DIR/syllables/ball.png" "Ball" "⚽" "#C8E6C9" "#2E7D32"

# Mittel (3 Silben)
create_svg "$ASSETS_DIR/syllables/banane.png" "Ba-na-ne" "🍌" "#FFF9C4" "#F57F17"
create_svg "$ASSETS_DIR/syllables/tomate.png" "To-ma-te" "🍅" "#FFCDD2" "#C62828"
create_svg "$ASSETS_DIR/syllables/elefant.png" "E-le-fant" "🐘" "#CFD8DC" "#37474F"
create_svg "$ASSETS_DIR/syllables/computer.png" "Com-pu-ter" "💻" "#BBDEFB" "#1565C0"
create_svg "$ASSETS_DIR/syllables/telefon.png" "Te-le-fon" "📱" "#B2EBF2" "#00838F"
create_svg "$ASSETS_DIR/syllables/rakete.png" "Ra-ke-te" "🚀" "#E1BEE7" "#6A1B9A"
create_svg "$ASSETS_DIR/syllables/erdbeere.png" "Erd-bee-re" "🍓" "#FFCDD2" "#C62828"
create_svg "$ASSETS_DIR/syllables/familie.png" "Fa-mi-lie" "👨‍👩‍👧" "#F8BBD0" "#AD1457"
create_svg "$ASSETS_DIR/syllables/schokolade.png" "Scho-ko-la-de" "🍫" "#D7CCC8" "#4E342E"

# Schwer (4+ Silben)
create_svg "$ASSETS_DIR/syllables/schmetterling.png" "Schmet-ter-ling" "🦋" "#E1BEE7" "#6A1B9A"
create_svg "$ASSETS_DIR/syllables/kindergarten.png" "Kin-der-gar-ten" "🏫" "#C8E6C9" "#2E7D32"
create_svg "$ASSETS_DIR/syllables/wassermelone.png" "Was-ser-me-lo-ne" "🍉" "#C8E6C9" "#2E7D32"
create_svg "$ASSETS_DIR/syllables/regenbogen.png" "Re-gen-bo-gen" "🌈" "#FFF9C4" "#F57F17"
create_svg "$ASSETS_DIR/syllables/geburtstag.png" "Ge-burts-tag" "🎂" "#F8BBD0" "#AD1457"
create_svg "$ASSETS_DIR/syllables/feuerwehr.png" "Feu-er-wehr" "🚒" "#FFCDD2" "#C62828"
create_svg "$ASSETS_DIR/syllables/hubschrauber.png" "Hub-schrau-ber" "🚁" "#BBDEFB" "#1565C0"

# Tiere (Silben)
create_svg "$ASSETS_DIR/syllables/giraffe.png" "Gi-raf-fe" "🦒" "#FFF9C4" "#F57F17"
create_svg "$ASSETS_DIR/syllables/krokodil.png" "Kro-ko-dil" "🐊" "#C8E6C9" "#2E7D32"
create_svg "$ASSETS_DIR/syllables/marienkaefer.png" "Ma-ri-en-kä-fer" "🐞" "#FFCDD2" "#C62828"
create_svg "$ASSETS_DIR/syllables/pinguin.png" "Pin-gu-in" "🐧" "#CFD8DC" "#37474F"
create_svg "$ASSETS_DIR/syllables/papagei.png" "Pa-pa-gei" "🦜" "#C8E6C9" "#2E7D32"

# ==================== STORIES ====================
echo ""
echo "📁 Stories (10 Bilder)..."

# Der kleine Hund
create_svg "$ASSETS_DIR/stories/der_kleine_hund/cover.png" "Der kleine Hund" "🐕" "#C8E6C9" "#2E7D32"
create_svg "$ASSETS_DIR/stories/der_kleine_hund/seite1.png" "Im Garten" "🌳" "#C8E6C9" "#2E7D32"
create_svg "$ASSETS_DIR/stories/der_kleine_hund/seite2.png" "Ein Ball!" "⚽" "#FFE0B2" "#E65100"
create_svg "$ASSETS_DIR/stories/der_kleine_hund/seite3.png" "Spielen" "🎾" "#FFF9C4" "#F57F17"
create_svg "$ASSETS_DIR/stories/der_kleine_hund/seite4.png" "Gute Nacht" "😴" "#E1BEE7" "#6A1B9A"

# Die bunte Katze
create_svg "$ASSETS_DIR/stories/die_bunte_katze/cover.png" "Die bunte Katze" "🐱" "#FFE0B2" "#E65100"
create_svg "$ASSETS_DIR/stories/die_bunte_katze/seite1.png" "Im Haus" "🏠" "#F8BBD0" "#AD1457"
create_svg "$ASSETS_DIR/stories/die_bunte_katze/seite2.png" "Ein Schmetterling!" "🦋" "#E1BEE7" "#6A1B9A"
create_svg "$ASSETS_DIR/stories/die_bunte_katze/seite3.png" "Fangen!" "🏃" "#FFE0B2" "#E65100"
create_svg "$ASSETS_DIR/stories/die_bunte_katze/seite4.png" "Beste Freunde" "❤️" "#FFCDD2" "#C62828"

echo ""
echo "✅ Fertig! 151 verbesserte Assets erstellt."
echo ""
echo "Verbesserungen:"
echo "  • Größere Emojis (180px)"
echo "  • Gradient-Hintergründe"
echo "  • Schatten-Effekte"
echo "  • Weißer Text-Hintergrund"
echo "  • Bessere Farben pro Kategorie"
