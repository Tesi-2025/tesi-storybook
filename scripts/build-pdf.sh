#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# build-pdf.sh — render STORYBOOK.md to storybook.pdf via pandoc.
#
# Usage:
#   ./scripts/build-pdf.sh              # writes ./storybook.pdf
#   ./scripts/build-pdf.sh out.pdf      # writes ./out.pdf
#
# Requires pandoc + a LaTeX engine (xelatex preferred, pdflatex fallback).
# On macOS:   brew install pandoc && brew install --cask basictex
# On Debian:  sudo apt install pandoc texlive-xetex texlive-fonts-recommended
# ---------------------------------------------------------------------------

set -euo pipefail

# Move to the repo root regardless of where the script is invoked from.
cd "$(dirname "$0")/.."

OUT="${1:-storybook.pdf}"
SRC="STORYBOOK.md"

# --- pre-flight: pandoc present? ------------------------------------------
if ! command -v pandoc >/dev/null 2>&1; then
  cat <<'EOF' >&2

  ⚠  pandoc is not installed.

  To build the PDF you'll need pandoc plus a LaTeX engine.

    macOS:   brew install pandoc && brew install --cask basictex
    Debian:  sudo apt install pandoc texlive-xetex texlive-fonts-recommended

  Then re-run: ./scripts/build-pdf.sh

EOF
  exit 1
fi

# --- pre-flight: source file present? -------------------------------------
if [[ ! -f "$SRC" ]]; then
  echo "error: $SRC not found (are you in the repo root?)" >&2
  exit 1
fi

# --- pick the best available LaTeX engine ---------------------------------
if command -v xelatex >/dev/null 2>&1; then
  ENGINE="xelatex"
elif command -v pdflatex >/dev/null 2>&1; then
  ENGINE="pdflatex"
else
  cat <<'EOF' >&2

  ⚠  no LaTeX engine found (need xelatex or pdflatex).

    macOS:   brew install --cask basictex
    Debian:  sudo apt install texlive-xetex

EOF
  exit 1
fi

echo "▶ building $OUT with pandoc (engine: $ENGINE)…"

# --- the actual render -----------------------------------------------------
# Emoji + smart-quotes friendly settings. Falls back gracefully if the
# LaTeX distribution can't render a glyph — pandoc will warn, not fail.
pandoc "$SRC" \
  -o "$OUT" \
  --pdf-engine="$ENGINE" \
  --metadata title="Tesi and the Great Merge Conflict" \
  --metadata author="Tesi 🦜 (with dictation help from Mummy 🦒)" \
  --metadata date="$(date +%Y-%m-%d)" \
  --toc \
  --toc-depth=1 \
  -V geometry:margin=1in \
  -V mainfont="Georgia" \
  -V documentclass=book \
  || {
    echo
    echo "⚠  render failed with default fonts; retrying without --mainfont…" >&2
    pandoc "$SRC" \
      -o "$OUT" \
      --pdf-engine="$ENGINE" \
      --metadata title="Tesi and the Great Merge Conflict" \
      --metadata author="Tesi" \
      --toc \
      --toc-depth=1 \
      -V geometry:margin=1in \
      -V documentclass=book
  }

echo "✓ wrote $OUT ($(du -h "$OUT" | cut -f1))"
echo "  🦜 ciao Mamma"
