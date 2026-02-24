#!/usr/bin/env bash
# Install GUI apps and fonts for development.
# macOS: Homebrew Cask  Linux: apt repos + GitHub Releases
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OS="$(uname -s)"
TMPDIR_CLEANUP=false

info()    { echo "[devtools] $*"; }
success() { echo "[devtools] ✓ $*"; }
warn()    { echo "[devtools] ! $*" >&2; }
fatal()   { echo "[devtools] ✗ $*" >&2; exit 1; }

if [ "${1:-}" = "--help" ]; then
  echo "Usage: install.sh [--help]"
  echo ""
  echo "Installs GUI apps and fonts for macOS (Homebrew Cask) or Linux (apt + GitHub Releases)."
  echo "No options required — run directly."
  exit 0
fi

case "$OS" in
  Darwin) PLATFORM_FILE="$SCRIPT_DIR/platform/macos/Brewfile" ;;
  Linux)  PLATFORM_FILE="$SCRIPT_DIR/platform/linux/extras.sh" ;;
  *)      fatal "Unsupported OS: $OS" ;;
esac

# When run via curl (platform file not present), fetch from GitHub
if [ ! -f "$PLATFORM_FILE" ]; then
  info "No local repository detected — fetching platform files"
  SCRIPT_DIR=$(mktemp -d)
  BRANCH="${DEVTOOLS_BRANCH:-main}"
  BASE="https://raw.githubusercontent.com/tafuru/devtools/${BRANCH}"
  case "$OS" in
    Darwin)
      mkdir -p "$SCRIPT_DIR/platform/macos"
      curl -sSfL "$BASE/platform/macos/Brewfile" -o "$SCRIPT_DIR/platform/macos/Brewfile"
      ;;
    Linux)
      mkdir -p "$SCRIPT_DIR/platform/linux"
      curl -sSfL "$BASE/platform/linux/extras.sh" -o "$SCRIPT_DIR/platform/linux/extras.sh"
      ;;
  esac
  TMPDIR_CLEANUP=true
fi

case "$OS" in
  Darwin)
    info "Detected macOS — installing via Homebrew Cask"
    if ! command -v brew &>/dev/null; then
      info "Homebrew not found — installing"
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew bundle --file "$SCRIPT_DIR/platform/macos/Brewfile"
    success "All apps installed"
    ;;
  Linux)
    info "Detected Linux — installing apps and fonts"
    bash "$SCRIPT_DIR/platform/linux/extras.sh"
    ;;
  *)
    fatal "Unsupported OS: $OS"
    ;;
esac

if [ "$TMPDIR_CLEANUP" = true ]; then
  rm -rf "$SCRIPT_DIR"
fi
