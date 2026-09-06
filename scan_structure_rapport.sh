#!/usr/bin/env bash
# ============================================================
# scan_structure_raport.sh
# A executer depuis la racine du projet (rapport-stage/).
#
# Objectif : generer un instantane textuel complet du rapport
# (arborescence + contenu des fichiers source) pour transmettre
# le contexte a une nouvelle session IA, sans surcharger le
# contexte avec les fichiers de build ou binaires.
#
# Sortie : scan_structure_rapport.txt (cree ou remplace a la racine)
#
# NOTE DE NOMMAGE : le fichier de sortie est genere sous le nom
# "scan_structure_rapport.txt" (sans le point superflu present
# dans la demande initiale, probable coquille). Modifiable via
# la variable OUTPUT_FILE ci-dessous si besoin.
# ============================================================

set -euo pipefail

# --- Configuration ---
OUTPUT_FILE="scan_structure_rapport.txt"
SELF_NAME="$(basename "$0")"

# Dossiers a ignorer completement (nom exact, a n'importe quel niveau)
EXCLUDE_DIRS=(
  "build"
  ".git"
  ".vscode"
  ".idea"
  "node_modules"
)

# Extensions de fichiers dont le CONTENU doit etre inclus dans le scan
CONTENT_EXTENSIONS=(
  "tex" "bib" "md" "cls" "sty" "bst"
)

# Extensions considerees comme images (mentionnees mais contenu non inclus)
IMAGE_EXTENSIONS=(
  "png" "jpg" "jpeg" "gif" "svg" "eps" "webp" "bmp" "tiff"
)

# Fichiers/patterns systematiquement ignores (artefacts de compilation,
# fichiers systeme, ce script et sa propre sortie)
EXCLUDE_FILE_PATTERNS=(
  "*.pdf" "*.aux" "*.log" "*.toc" "*.lof" "*.lot" "*.out"
  "*.bbl" "*.bcf" "*.blg" "*.run.xml" "*.glo" "*.gls" "*.glg"
  "*.ist" "*.acn" "*.acr" "*.alg" "*.fls" "*.fdb_latexmk"
  "*.synctex.gz" ".DS_Store"
  "${SELF_NAME}"
  "${OUTPUT_FILE}"
)

# --- Verifications preliminaires ---
if [[ ! -f "main.tex" ]]; then
  echo "ERREUR : main.tex introuvable dans le repertoire courant." >&2
  echo "Ce script doit etre execute depuis la racine du projet rapport-stage/." >&2
  exit 1
fi

# --- Construction du tableau de prune (dossiers exclus) ---
# Construit : ( -name "build" -o -name ".git" -o ... )
build_prune_args() {
  local -n out_array=$1
  out_array=()
  local first=true
  for d in "${EXCLUDE_DIRS[@]}"; do
    if $first; then
      out_array+=( -name "$d" )
      first=false
    else
      out_array+=( -o -name "$d" )
    fi
  done
}

# --- Construction du tableau de filtre par extension ---
# Construit : ( -iname "*.tex" -o -iname "*.bib" -o ... )
build_ext_args() {
  local -n out_array=$1
  shift
  out_array=()
  local first=true
  for ext in "$@"; do
    if $first; then
      out_array+=( -iname "*.${ext}" )
      first=false
    else
      out_array+=( -o -iname "*.${ext}" )
    fi
  done
}

# --- Verifie si un fichier doit etre exclu (patterns) ---
is_excluded_file() {
  local filename
  filename="$(basename "$1")"
  for pattern in "${EXCLUDE_FILE_PATTERNS[@]}"; do
    if [[ "$filename" == $pattern ]]; then
      return 0
    fi
  done
  return 1
}

# --- Initialisation du fichier de sortie ---
{
  echo "============================================================"
  echo "SCAN DE STRUCTURE - RAPPORT DE STAGE AGT INFRA"
  echo "Genere le : $(date '+%Y-%m-%d %H:%M:%S')"
  echo "Racine scannee : $(pwd)"
  echo "============================================================"
  echo
} > "$OUTPUT_FILE"

# --- 1. Arborescence generale (dossiers exclus retires) ---
{
  echo "------------------------------------------------------------"
  echo "1. ARBORESCENCE DU PROJET"
  echo "------------------------------------------------------------"
} >> "$OUTPUT_FILE"

if command -v tree >/dev/null 2>&1; then
  IGNORE_PATTERN=$(IFS='|'; echo "${EXCLUDE_DIRS[*]}")
  tree -a -I "${IGNORE_PATTERN}" --dirsfirst >> "$OUTPUT_FILE"
else
  prune_args=()
  build_prune_args prune_args
  find . \( "${prune_args[@]}" \) -prune -o -print | sort >> "$OUTPUT_FILE"
fi
echo >> "$OUTPUT_FILE"

# --- 2. Inventaire des images (emplacement uniquement, pas de contenu) ---
{
  echo "------------------------------------------------------------"
  echo "2. IMAGES DETECTEES (emplacement uniquement)"
  echo "------------------------------------------------------------"
} >> "$OUTPUT_FILE"

prune_args=()
build_prune_args prune_args
image_ext_args=()
build_ext_args image_ext_args "${IMAGE_EXTENSIONS[@]}"

image_count=0
while IFS= read -r -d '' img; do
  if is_excluded_file "$img"; then
    continue
  fi
  size=$(du -h "$img" 2>/dev/null | cut -f1)
  echo "  - ${img#./} (taille : ${size:-inconnue})" >> "$OUTPUT_FILE"
  image_count=$((image_count + 1))
done < <(find . \( "${prune_args[@]}" \) -prune -o -type f \( "${image_ext_args[@]}" \) -print0)

if [[ "$image_count" -eq 0 ]]; then
  echo "  (aucune image trouvee)" >> "$OUTPUT_FILE"
fi
echo >> "$OUTPUT_FILE"

# --- 3. Contenu integral des fichiers source (.tex, .bib, .md, .cls, .sty, .bst) ---
{
  echo "------------------------------------------------------------"
  echo "3. CONTENU DES FICHIERS SOURCE"
  echo "------------------------------------------------------------"
} >> "$OUTPUT_FILE"

prune_args=()
build_prune_args prune_args
content_ext_args=()
build_ext_args content_ext_args "${CONTENT_EXTENSIONS[@]}"

file_count=0
while IFS= read -r -d '' f; do
  if is_excluded_file "$f"; then
    continue
  fi
  {
    echo
    echo "=== FICHIER : ${f#./} ==="
    if [[ ! -s "$f" ]]; then
      echo "(fichier vide)"
    else
      cat "$f"
    fi
    echo "=== FIN FICHIER : ${f#./} ==="
  } >> "$OUTPUT_FILE"
  file_count=$((file_count + 1))
done < <(find . \( "${prune_args[@]}" \) -prune -o -type f \( "${content_ext_args[@]}" \) -print0 | sort -z)

echo >> "$OUTPUT_FILE"
echo "============================================================" >> "$OUTPUT_FILE"
echo "FIN DU SCAN" >> "$OUTPUT_FILE"
echo "============================================================" >> "$OUTPUT_FILE"

echo "Scan termine : ${OUTPUT_FILE} genere a la racine (${file_count} fichier(s) source, ${image_count} image(s))."