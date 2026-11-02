#!/usr/bin/env bash
# Smoke-test the book's live GitHub Pages site.
#
#   ./verify-live.sh                                      # intended clean URL (after the repo rename)
#   ./verify-live.sh https://ykidus053-create.github.io/-the-hidden-and-the-manifest-/   # live today
#   CHECK_METADATA=0 ./verify-live.sh http://127.0.0.1:8080/   # local preview: skip URL metadata
#
# Run this from a machine with unrestricted internet: this sandbox blocks curl to *.github.io.
# Every path below is one the brief requires to answer 200. The script exits 1 on any failure.

set -u
BASE="${1:-https://ykidus053-create.github.io/the-hidden-and-the-manifest/}"
BASE="${BASE%/}"
CHECK_METADATA="${CHECK_METADATA:-1}"

PATHS=(
  "/"
  "/read/"
  "/the-hidden-and-the-manifest.pdf"
  "/the-hidden-and-the-manifest.epub"
  "/cover.jpg"
  "/social/og-card.png"
  "/sitemap.xml"
  "/triage-card.pdf"
  "/robots.txt"
)

echo "Checking $BASE"
fails=0
for p in "${PATHS[@]}"; do
  code=$(curl -sL --max-time 25 -o /dev/null -w '%{http_code}' "$BASE$p" 2>/dev/null)
  if [ "$code" = "200" ]; then
    printf '  PASS  %-42s 200\n' "$p"
  else
    printf '  FAIL  %-42s %s\n' "$p" "${code:-no-response}"
    fails=$((fails + 1))
  fi
done

echo
if [ "$CHECK_METADATA" = "0" ]; then
  echo "Metadata checks skipped (CHECK_METADATA=0)."
else
  echo "Metadata checks"
  html=$(curl -sL --max-time 25 "$BASE/" 2>/dev/null)
  canonical=$(printf '%s' "$html" | grep -o 'rel="canonical" href="[^"]*"' | head -1 | sed 's/.*href="//;s/"$//' || true)
  ogurl=$(printf '%s' "$html" | grep -o 'property="og:url" content="[^"]*"' | head -1 | sed 's/.*content="//;s/"$//' || true)
  for pair in "canonical|$canonical" "og-url|$ogurl"; do
    label=${pair%%|*}; value=${pair#*|}
    if [ "$value" = "$BASE/" ]; then
      printf '  PASS  %-12s %s\n' "$label" "$value"
    else
      printf '  WARN  %-12s %s (expected %s/)\n' "$label" "${value:-missing}" "$BASE"
      fails=$((fails + 1))
    fi
  done

  download=$(printf '%s' "$html" | grep -o 'href="[^"]*the-hidden-and-the-manifest.pdf?download"[^>]*' | head -1 || true)
  if printf '%s' "$download" | grep -q 'download='; then
    printf '  PASS  %-12s download attribute present\n' 'download'
  else
    printf '  WARN  %-12s PDF button missing its download attribute\n' 'download'
    fails=$((fails + 1))
  fi

  sitemap=$(curl -sL --max-time 25 "$BASE/sitemap.xml" 2>/dev/null)
  if printf '%s' "$sitemap" | grep -q "$BASE/"; then
    printf '  PASS  %-12s sitemap names %s/\n' 'sitemap' "$BASE"
  else
    printf '  WARN  %-12s sitemap does not name %s/\n' 'sitemap' "$BASE"
    fails=$((fails + 1))
  fi
fi

echo
if [ "$fails" -gt 0 ]; then
  echo "$fails check(s) failed. If the clean URL 404s, the repo still needs renaming in Settings → Repository name."
  exit 1
fi
echo "All checks passed."
