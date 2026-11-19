#!/usr/bin/env bash
# Download one artifact from a release and verify it against SHA256SUMS.
#
#   ./scripts/fetch.sh v1.0.0 ep
#
# Artifacts stay in ./out unless OUT is set.
set -euo pipefail

TAG="${1:?usage: fetch.sh <tag> <ep|jz|jcb>}"
NAME="${2:?usage: fetch.sh <tag> <ep|jz|jcb>}"

REPO="${REPO:-WangHongSen391/pk-wallet-kit}"
OUT="${OUT:-out}"
BASE="https://github.com/${REPO}/releases/download/${TAG}"

case "$NAME" in
  ep|jz|jcb) ;;
  *) echo "unknown artifact: $NAME" >&2; exit 2 ;;
esac

mkdir -p "$OUT"
cd "$OUT"

curl -fL --retry 3 --retry-delay 2 -o "${NAME}.apk" "${BASE}/${NAME}.apk"
curl -fL --retry 3 --retry-delay 2 -o SHA256SUMS   "${BASE}/SHA256SUMS"

expected="$(awk -v f="${NAME}.apk" '$2 == f { print $1 }' SHA256SUMS)"
[ -n "$expected" ] || { echo "no checksum for ${NAME}.apk" >&2; exit 1; }

echo "${expected}  ${NAME}.apk" | shasum -a 256 -c -

echo "ok: ${OUT}/${NAME}.apk"
