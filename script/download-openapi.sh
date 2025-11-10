#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_FILE="$ROOT_DIR/../openapi.yaml"
SOURCE_URL="http://localhost:3000/openapi"

TMP_FILE="$(mktemp)"

if command -v curl >/dev/null 2>&1; then
  curl --fail --silent --show-error --location "$SOURCE_URL" -o "$TMP_FILE"
elif command -v wget >/dev/null 2>&1; then
  wget -qO "$TMP_FILE" "$SOURCE_URL"
else
  echo "Error: neither curl nor wget is available" >&2
  exit 1
fi

if command -v jq >/dev/null 2>&1; then
  jq . "$TMP_FILE" > "$OUTPUT_FILE"
else
  echo "Error: jq is required for pretty printing JSON" >&2
  rm -f "$TMP_FILE"
  exit 1
fi

rm -f "$TMP_FILE"

echo "Saved pretty-printed OpenAPI spec to $OUTPUT_FILE"
