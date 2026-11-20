#!/usr/bin/env bash
# Copy the live https://mybctv.com/ads.txt into app-ads.txt.
# Run from anywhere; writes next to this repo's root.
set -euo pipefail
root="$(cd "$(dirname "$0")/.." && pwd)"
tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

curl -fsSL --max-time 30 https://mybctv.com/ads.txt -o "$tmp"

# Refuse to write something that isn't an ads.txt (e.g. a Wix HTML error page).
if grep -qi '<html' "$tmp" || ! grep -qE '^[a-z0-9.-]+\.[a-z]+, *[^,]+, *(DIRECT|RESELLER)' "$tmp"; then
  echo "Fetched ads.txt doesn't look valid; app-ads.txt left unchanged." >&2
  exit 1
fi

mv "$tmp" "$root/app-ads.txt"
trap - EXIT
echo "app-ads.txt updated ($(wc -l < "$root/app-ads.txt" | tr -d ' ') lines)."
git -C "$root" status --short app-ads.txt 2>/dev/null || true
