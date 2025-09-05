#!/usr/bin/env bash

set -Eeuo pipefail

usage() {
  cat <<'USAGE'
Build Android .apk for this Flutter app.

Usage:
  bash build_mobile.sh [options]

Options:
  -c, --clean                 Run `flutter clean` before building
      --build-number <num>    Override build number
      --build-name <name>     Override build name (e.g. 1.2.3)
  -v, --verbose               Verbose Flutter output
  -h, --help                  Show this help and exit

Examples:
  bash build_mobile.sh
  bash build_mobile.sh --clean --build-number 42 --build-name 1.2.3
USAGE
}

# Defaults
RUN_CLEAN=0
BUILD_NUMBER=""
BUILD_NAME=""
VERBOSE=0

# Parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    -c|--clean)
      RUN_CLEAN=1
      shift
      ;;
    --build-number)
      BUILD_NUMBER="${2:-}"
      shift 2
      ;;
    --build-name)
      BUILD_NAME="${2:-}"
      shift 2
      ;;
    -v|--verbose)
      VERBOSE=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage
      exit 1
      ;;
  esac
done

# Move to repo root (script's directory)
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() { echo -e "\033[1m$*\033[0m"; }
check_cmd() { command -v "$1" >/dev/null 2>&1 || { echo "Missing required command: $1" >&2; exit 127; }; }

ensure_flutter() {
  check_cmd flutter
  if [[ $VERBOSE -eq 1 ]]; then flutter --version; fi
}

flutter_pub_get_once() {
  ensure_flutter
  log "Resolving Dart/Flutter dependencies (flutter pub get)..."
  flutter pub get ${VERBOSE:+-v}
}

build_android_apk() {
  log "Building Android APK..."
  ensure_flutter
  [[ $RUN_CLEAN -eq 1 ]] && flutter clean

  local args=(build apk --release)
  [[ -n "$BUILD_NUMBER" ]] && args+=(--build-number "$BUILD_NUMBER")
  [[ -n "$BUILD_NAME" ]] && args+=(--build-name "$BUILD_NAME")
  [[ $VERBOSE -eq 1 ]] && args+=(-v)

  log "> flutter ${args[*]}"
  flutter "${args[@]}"

  log "Android APK artifacts:"
  shopt -s nullglob
  for f in build/app/outputs/flutter-apk/*.apk; do
    echo "  - $f"
  done
  shopt -u nullglob
}

# Do the work
flutter_pub_get_once
build_android_apk

log "Done."

