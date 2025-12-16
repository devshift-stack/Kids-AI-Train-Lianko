#!/bin/bash

# Asset Generator für Lianko App
# Erstellt einfache SVG-Platzhalter für alle benötigten Bilder

ASSETS_DIR="/Users/dsselmanovic/devshift-stack/Kids-AI-Train-Lianko/assets"

# Funktion zum Erstellen eines SVG
create_svg() {
    local path="$1"
    local text="$2"
    local emoji="$3"
    local bg_color="$4"
    local text_color="${5:-#333333}"

    cat > "$path" << EOF
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
  <rect width="512" height="512" rx="40" fill="$bg_color"/>
  <text x="256" y="200" font-size="120" text-anchor="middle">$emoji</text>
  <text x="256" y="380" font-size="48" font-family="Arial, sans-serif" font-weight="bold" text-anchor="middle" fill="$text_color">$text</text>
</svg>
EOF
    echo "✓ $path"
}

echo "🎨 Erstelle Assets für Lianko..."
echo ""

# ==================== COMMUNICATION ====================
echo "📁 Communication (47 Bilder)..."

# Schmerzen (rot)
create_svg "$ASSETS_DIR/communication/schmerzen/kopf.png" "Kopf" "🤕" "#FFCDD2"
create_svg "$ASSETS_DIR/communication/schmerzen/bauch.png" "Bauch" "🤢" "#FFCDD2"
create_svg "$ASSETS_DIR/communication/schmerzen/hals.png" "Hals" "😷" "#FFCDD2"
create_svg "$ASSETS_DIR/communication/schmerzen/ohr.png" "Ohr" "👂" "#FFCDD2"
create_svg "$ASSETS_DIR/communication/schmerzen/zahn.png" "Zahn" "🦷" "#FFCDD2"
create_svg "$ASSETS_DIR/communication/schmerzen/bein.png" "Bein" "🦵" "#FFCDD2"
create_svg "$ASSETS_DIR/communication/schmerzen/arm.png" "Arm" "💪" "#FFCDD2"

# Essen (orange)
create_svg "$ASSETS_DIR/communication/essen/fruehstueck.png" "Frühstück" "🍳" "#FFE0B2"
create_svg "$ASSETS_DIR/communication/essen/muesli.png" "Müsli" "🥣" "#FFE0B2"
create_svg "$ASSETS_DIR/communication/essen/brot.png" "Brot" "🍞" "#FFE0B2"
create_svg "$ASSETS_DIR/communication/essen/ei.png" "Ei" "🥚" "#FFE0B2"
create_svg "$ASSETS_DIR/communication/essen/mittag.png" "Mittag" "🍽️" "#FFE0B2"
create_svg "$ASSETS_DIR/communication/essen/snack.png" "Snack" "🍪" "#FFE0B2"
create_svg "$ASSETS_DIR/communication/essen/obst.png" "Obst" "🍎" "#FFE0B2"
create_svg "$ASSETS_DIR/communication/essen/kekse.png" "Kekse" "🍪" "#FFE0B2"
create_svg "$ASSETS_DIR/communication/essen/suess.png" "Süß" "🍬" "#FFE0B2"
create_svg "$ASSETS_DIR/communication/essen/abend.png" "Abend" "🌙" "#FFE0B2"

# Trinken (blau)
create_svg "$ASSETS_DIR/communication/trinken/wasser.png" "Wasser" "💧" "#BBDEFB"
create_svg "$ASSETS_DIR/communication/trinken/saft.png" "Saft" "🧃" "#BBDEFB"
create_svg "$ASSETS_DIR/communication/trinken/milch.png" "Milch" "🥛" "#BBDEFB"
create_svg "$ASSETS_DIR/communication/trinken/kakao.png" "Kakao" "☕" "#BBDEFB"
create_svg "$ASSETS_DIR/communication/trinken/tee.png" "Tee" "🍵" "#BBDEFB"

# Gefühle (pink)
create_svg "$ASSETS_DIR/communication/gefuehle/gluecklich.png" "Glücklich" "😊" "#F8BBD9"
create_svg "$ASSETS_DIR/communication/gefuehle/traurig.png" "Traurig" "😢" "#F8BBD9"
create_svg "$ASSETS_DIR/communication/gefuehle/wuetend.png" "Wütend" "😠" "#F8BBD9"
create_svg "$ASSETS_DIR/communication/gefuehle/muede.png" "Müde" "😴" "#F8BBD9"
create_svg "$ASSETS_DIR/communication/gefuehle/angst.png" "Angst" "😨" "#F8BBD9"
create_svg "$ASSETS_DIR/communication/gefuehle/langweilig.png" "Langweilig" "😐" "#F8BBD9"

# Aktivitäten (lila)
create_svg "$ASSETS_DIR/communication/aktivitaeten/spielen.png" "Spielen" "🎮" "#E1BEE7"
create_svg "$ASSETS_DIR/communication/aktivitaeten/fernsehen.png" "TV" "📺" "#E1BEE7"
create_svg "$ASSETS_DIR/communication/aktivitaeten/draussen.png" "Draußen" "🌳" "#E1BEE7"
create_svg "$ASSETS_DIR/communication/aktivitaeten/schlafen.png" "Schlafen" "🛏️" "#E1BEE7"
create_svg "$ASSETS_DIR/communication/aktivitaeten/kuscheln.png" "Kuscheln" "🤗" "#E1BEE7"
create_svg "$ASSETS_DIR/communication/aktivitaeten/vorlesen.png" "Vorlesen" "📖" "#E1BEE7"

# Toilette (cyan)
create_svg "$ASSETS_DIR/communication/toilette/wc.png" "Toilette" "🚽" "#B2EBF2"
create_svg "$ASSETS_DIR/communication/toilette/haende.png" "Hände" "🧼" "#B2EBF2"
create_svg "$ASSETS_DIR/communication/toilette/baden.png" "Baden" "🛁" "#B2EBF2"
create_svg "$ASSETS_DIR/communication/toilette/zaehne.png" "Zähne" "🦷" "#B2EBF2"

# Hilfe (rot-orange)
create_svg "$ASSETS_DIR/communication/hilfe/hilfe.png" "Hilfe" "🆘" "#FFCCBC"
create_svg "$ASSETS_DIR/communication/hilfe/verstehe.png" "Verstehe?" "❓" "#FFCCBC"
create_svg "$ASSETS_DIR/communication/hilfe/nochmal.png" "Nochmal" "🔄" "#FFCCBC"

# Ja/Nein (grün/rot/gelb)
create_svg "$ASSETS_DIR/communication/janein/ja.png" "Ja" "✅" "#C8E6C9"
create_svg "$ASSETS_DIR/communication/janein/nein.png" "Nein" "❌" "#FFCDD2"
create_svg "$ASSETS_DIR/communication/janein/vielleicht.png" "Vielleicht" "🤔" "#FFF9C4"

# Menschen (braun)
create_svg "$ASSETS_DIR/communication/menschen/mama.png" "Mama" "👩" "#D7CCC8"
create_svg "$ASSETS_DIR/communication/menschen/papa.png" "Papa" "👨" "#D7CCC8"
create_svg "$ASSETS_DIR/communication/menschen/oma.png" "Oma" "👵" "#D7CCC8"
create_svg "$ASSETS_DIR/communication/menschen/opa.png" "Opa" "👴" "#D7CCC8"
create_svg "$ASSETS_DIR/communication/menschen/geschwister.png" "Geschwister" "👧👦" "#D7CCC8"

# Orte (grau-blau)
create_svg "$ASSETS_DIR/communication/orte/zuhause.png" "Zuhause" "🏠" "#CFD8DC"
create_svg "$ASSETS_DIR/communication/orte/draussen.png" "Draußen" "🌲" "#CFD8DC"
create_svg "$ASSETS_DIR/communication/orte/spielplatz.png" "Spielplatz" "🎠" "#CFD8DC"
create_svg "$ASSETS_DIR/communication/orte/arzt.png" "Arzt" "🏥" "#CFD8DC"

# ==================== VOCABULARY ====================
echo ""
echo "📁 Vocabulary (54 Bilder)..."

# Tiere (grün)
create_svg "$ASSETS_DIR/vocabulary/tiere/hund.png" "Hund" "🐕" "#C8E6C9"
create_svg "$ASSETS_DIR/vocabulary/tiere/katze.png" "Katze" "🐱" "#C8E6C9"
create_svg "$ASSETS_DIR/vocabulary/tiere/maus.png" "Maus" "🐭" "#C8E6C9"
create_svg "$ASSETS_DIR/vocabulary/tiere/vogel.png" "Vogel" "🐦" "#C8E6C9"
create_svg "$ASSETS_DIR/vocabulary/tiere/fisch.png" "Fisch" "🐟" "#C8E6C9"
create_svg "$ASSETS_DIR/vocabulary/tiere/pferd.png" "Pferd" "🐴" "#C8E6C9"
create_svg "$ASSETS_DIR/vocabulary/tiere/kuh.png" "Kuh" "🐄" "#C8E6C9"
create_svg "$ASSETS_DIR/vocabulary/tiere/schwein.png" "Schwein" "🐷" "#C8E6C9"
create_svg "$ASSETS_DIR/vocabulary/tiere/schaf.png" "Schaf" "🐑" "#C8E6C9"
create_svg "$ASSETS_DIR/vocabulary/tiere/huhn.png" "Huhn" "🐔" "#C8E6C9"

# Familie (pink)
create_svg "$ASSETS_DIR/vocabulary/familie/mama.png" "Mama" "👩" "#F8BBD9"
create_svg "$ASSETS_DIR/vocabulary/familie/papa.png" "Papa" "👨" "#F8BBD9"
create_svg "$ASSETS_DIR/vocabulary/familie/oma.png" "Oma" "👵" "#F8BBD9"
create_svg "$ASSETS_DIR/vocabulary/familie/opa.png" "Opa" "👴" "#F8BBD9"
create_svg "$ASSETS_DIR/vocabulary/familie/bruder.png" "Bruder" "👦" "#F8BBD9"
create_svg "$ASSETS_DIR/vocabulary/familie/schwester.png" "Schwester" "👧" "#F8BBD9"
create_svg "$ASSETS_DIR/vocabulary/familie/baby.png" "Baby" "👶" "#F8BBD9"
create_svg "$ASSETS_DIR/vocabulary/familie/tante.png" "Tante" "👩" "#F8BBD9"
create_svg "$ASSETS_DIR/vocabulary/familie/onkel.png" "Onkel" "👨" "#F8BBD9"

# Essen (orange)
create_svg "$ASSETS_DIR/vocabulary/essen/apfel.png" "Apfel" "🍎" "#FFE0B2"
create_svg "$ASSETS_DIR/vocabulary/essen/banane.png" "Banane" "🍌" "#FFE0B2"
create_svg "$ASSETS_DIR/vocabulary/essen/brot.png" "Brot" "🍞" "#FFE0B2"
create_svg "$ASSETS_DIR/vocabulary/essen/milch.png" "Milch" "🥛" "#FFE0B2"
create_svg "$ASSETS_DIR/vocabulary/essen/wasser.png" "Wasser" "💧" "#FFE0B2"
create_svg "$ASSETS_DIR/vocabulary/essen/kaese.png" "Käse" "🧀" "#FFE0B2"
create_svg "$ASSETS_DIR/vocabulary/essen/ei.png" "Ei" "🥚" "#FFE0B2"
create_svg "$ASSETS_DIR/vocabulary/essen/kuchen.png" "Kuchen" "🎂" "#FFE0B2"

# Körper (blau)
create_svg "$ASSETS_DIR/vocabulary/koerper/hand.png" "Hand" "✋" "#BBDEFB"
create_svg "$ASSETS_DIR/vocabulary/koerper/fuss.png" "Fuß" "🦶" "#BBDEFB"
create_svg "$ASSETS_DIR/vocabulary/koerper/kopf.png" "Kopf" "🗣️" "#BBDEFB"
create_svg "$ASSETS_DIR/vocabulary/koerper/auge.png" "Auge" "👁️" "#BBDEFB"
create_svg "$ASSETS_DIR/vocabulary/koerper/ohr.png" "Ohr" "👂" "#BBDEFB"
create_svg "$ASSETS_DIR/vocabulary/koerper/nase.png" "Nase" "👃" "#BBDEFB"
create_svg "$ASSETS_DIR/vocabulary/koerper/mund.png" "Mund" "👄" "#BBDEFB"
create_svg "$ASSETS_DIR/vocabulary/koerper/bauch.png" "Bauch" "🫃" "#BBDEFB"

# Farben
create_svg "$ASSETS_DIR/vocabulary/farben/rot.png" "Rot" "🔴" "#FF0000" "#FFFFFF"
create_svg "$ASSETS_DIR/vocabulary/farben/blau.png" "Blau" "🔵" "#0000FF" "#FFFFFF"
create_svg "$ASSETS_DIR/vocabulary/farben/gruen.png" "Grün" "🟢" "#00AA00" "#FFFFFF"
create_svg "$ASSETS_DIR/vocabulary/farben/gelb.png" "Gelb" "🟡" "#FFFF00" "#333333"
create_svg "$ASSETS_DIR/vocabulary/farben/orange.png" "Orange" "🟠" "#FFA500" "#FFFFFF"
create_svg "$ASSETS_DIR/vocabulary/farben/lila.png" "Lila" "🟣" "#800080" "#FFFFFF"
create_svg "$ASSETS_DIR/vocabulary/farben/rosa.png" "Rosa" "💗" "#FFC0CB" "#333333"
create_svg "$ASSETS_DIR/vocabulary/farben/weiss.png" "Weiß" "⚪" "#FFFFFF" "#333333"
create_svg "$ASSETS_DIR/vocabulary/farben/schwarz.png" "Schwarz" "⚫" "#333333" "#FFFFFF"

# Zahlen (cyan)
create_svg "$ASSETS_DIR/vocabulary/zahlen/1.png" "Eins" "1️⃣" "#B2EBF2"
create_svg "$ASSETS_DIR/vocabulary/zahlen/2.png" "Zwei" "2️⃣" "#B2EBF2"
create_svg "$ASSETS_DIR/vocabulary/zahlen/3.png" "Drei" "3️⃣" "#B2EBF2"
create_svg "$ASSETS_DIR/vocabulary/zahlen/4.png" "Vier" "4️⃣" "#B2EBF2"
create_svg "$ASSETS_DIR/vocabulary/zahlen/5.png" "Fünf" "5️⃣" "#B2EBF2"
create_svg "$ASSETS_DIR/vocabulary/zahlen/6.png" "Sechs" "6️⃣" "#B2EBF2"
create_svg "$ASSETS_DIR/vocabulary/zahlen/7.png" "Sieben" "7️⃣" "#B2EBF2"
create_svg "$ASSETS_DIR/vocabulary/zahlen/8.png" "Acht" "8️⃣" "#B2EBF2"
create_svg "$ASSETS_DIR/vocabulary/zahlen/9.png" "Neun" "9️⃣" "#B2EBF2"
create_svg "$ASSETS_DIR/vocabulary/zahlen/10.png" "Zehn" "🔟" "#B2EBF2"

# ==================== SYLLABLES ====================
echo ""
echo "📁 Syllables (34 Bilder)..."

# Leicht
create_svg "$ASSETS_DIR/syllables/apfel.png" "Ap-fel" "🍎" "#C8E6C9"
create_svg "$ASSETS_DIR/syllables/hase.png" "Ha-se" "🐰" "#C8E6C9"
create_svg "$ASSETS_DIR/syllables/sonne.png" "Son-ne" "☀️" "#FFF9C4"
create_svg "$ASSETS_DIR/syllables/blume.png" "Blu-me" "🌸" "#F8BBD9"
create_svg "$ASSETS_DIR/syllables/hunde.png" "Hun-de" "🐕" "#C8E6C9"
create_svg "$ASSETS_DIR/syllables/katze.png" "Kat-ze" "🐱" "#C8E6C9"
create_svg "$ASSETS_DIR/syllables/mama.png" "Ma-ma" "👩" "#F8BBD9"
create_svg "$ASSETS_DIR/syllables/papa.png" "Pa-pa" "👨" "#BBDEFB"
create_svg "$ASSETS_DIR/syllables/oma.png" "O-ma" "👵" "#F8BBD9"
create_svg "$ASSETS_DIR/syllables/opa.png" "O-pa" "👴" "#BBDEFB"
create_svg "$ASSETS_DIR/syllables/auto.png" "Au-to" "🚗" "#FFCDD2"
create_svg "$ASSETS_DIR/syllables/bett.png" "Bett" "🛏️" "#E1BEE7"
create_svg "$ASSETS_DIR/syllables/ball.png" "Ball" "⚽" "#FFE0B2"

# Mittel
create_svg "$ASSETS_DIR/syllables/banane.png" "Ba-na-ne" "🍌" "#FFF9C4"
create_svg "$ASSETS_DIR/syllables/tomate.png" "To-ma-te" "🍅" "#FFCDD2"
create_svg "$ASSETS_DIR/syllables/elefant.png" "E-le-fant" "🐘" "#CFD8DC"
create_svg "$ASSETS_DIR/syllables/computer.png" "Com-pu-ter" "💻" "#BBDEFB"
create_svg "$ASSETS_DIR/syllables/telefon.png" "Te-le-fon" "📱" "#B2EBF2"
create_svg "$ASSETS_DIR/syllables/rakete.png" "Ra-ke-te" "🚀" "#E1BEE7"
create_svg "$ASSETS_DIR/syllables/erdbeere.png" "Erd-bee-re" "🍓" "#FFCDD2"
create_svg "$ASSETS_DIR/syllables/familie.png" "Fa-mi-lie" "👨‍👩‍👧" "#F8BBD9"
create_svg "$ASSETS_DIR/syllables/schokolade.png" "Scho-ko-la-de" "🍫" "#D7CCC8"

# Schwer
create_svg "$ASSETS_DIR/syllables/schmetterling.png" "Schmet-ter-ling" "🦋" "#E1BEE7"
create_svg "$ASSETS_DIR/syllables/kindergarten.png" "Kin-der-gar-ten" "🏫" "#C8E6C9"
create_svg "$ASSETS_DIR/syllables/wassermelone.png" "Was-ser-me-lo-ne" "🍉" "#C8E6C9"
create_svg "$ASSETS_DIR/syllables/regenbogen.png" "Re-gen-bo-gen" "🌈" "#FFF9C4"
create_svg "$ASSETS_DIR/syllables/geburtstag.png" "Ge-burts-tag" "🎂" "#F8BBD9"
create_svg "$ASSETS_DIR/syllables/feuerwehr.png" "Feu-er-wehr" "🚒" "#FFCDD2"
create_svg "$ASSETS_DIR/syllables/hubschrauber.png" "Hub-schrau-ber" "🚁" "#BBDEFB"

# Tiere
create_svg "$ASSETS_DIR/syllables/giraffe.png" "Gi-raf-fe" "🦒" "#FFF9C4"
create_svg "$ASSETS_DIR/syllables/krokodil.png" "Kro-ko-dil" "🐊" "#C8E6C9"
create_svg "$ASSETS_DIR/syllables/marienkaefer.png" "Ma-ri-en-kä-fer" "🐞" "#FFCDD2"
create_svg "$ASSETS_DIR/syllables/pinguin.png" "Pin-gu-in" "🐧" "#CFD8DC"
create_svg "$ASSETS_DIR/syllables/papagei.png" "Pa-pa-gei" "🦜" "#C8E6C9"

# ==================== STORIES ====================
echo ""
echo "📁 Stories (10 Bilder)..."

# Der kleine Hund
create_svg "$ASSETS_DIR/stories/der_kleine_hund/cover.png" "Der kleine Hund" "🐕" "#C8E6C9"
create_svg "$ASSETS_DIR/stories/der_kleine_hund/seite1.png" "Im Garten" "🌳" "#C8E6C9"
create_svg "$ASSETS_DIR/stories/der_kleine_hund/seite2.png" "Ein Ball!" "⚽" "#FFE0B2"
create_svg "$ASSETS_DIR/stories/der_kleine_hund/seite3.png" "Spielen" "🎾" "#FFF9C4"
create_svg "$ASSETS_DIR/stories/der_kleine_hund/seite4.png" "Müde" "😴" "#E1BEE7"

# Die bunte Katze
create_svg "$ASSETS_DIR/stories/die_bunte_katze/cover.png" "Die bunte Katze" "🐱" "#F8BBD9"
create_svg "$ASSETS_DIR/stories/die_bunte_katze/seite1.png" "Im Haus" "🏠" "#F8BBD9"
create_svg "$ASSETS_DIR/stories/die_bunte_katze/seite2.png" "Schmetterling!" "🦋" "#E1BEE7"
create_svg "$ASSETS_DIR/stories/die_bunte_katze/seite3.png" "Jagen" "🏃" "#FFE0B2"
create_svg "$ASSETS_DIR/stories/die_bunte_katze/seite4.png" "Freunde" "❤️" "#FFCDD2"

echo ""
echo "✅ Fertig! 145 Assets erstellt."
