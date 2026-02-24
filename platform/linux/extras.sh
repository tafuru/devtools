#!/usr/bin/env bash
# Install GUI apps and fonts on Linux.
set -euo pipefail

info()    { echo "[devtools] $*"; }
success() { echo "[devtools] ✓ $*"; }
skip()    { echo "[devtools] - $* already installed — skipping"; }

# Fetch the latest release tag from GitHub (returns e.g. "v1.2.3")
gh_latest() {
  curl -sSfL "https://api.github.com/repos/$1/releases/latest" \
    | grep '"tag_name"' | head -1 | sed 's/.*"tag_name": *"\(.*\)".*/\1/'
}

# VSCode — https://code.visualstudio.com
install_vscode() {
  command -v code &>/dev/null && { skip "vscode"; return; }
  info "Installing VSCode"
  curl -sSfL "https://packages.microsoft.com/keys/microsoft.asc" \
    | gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
    | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
  sudo apt-get update -q
  sudo apt-get install -y code
  success "VSCode installed"
}

# Docker — https://docs.docker.com/engine/install/ubuntu/
install_docker() {
  command -v docker &>/dev/null && { skip docker; return; }
  info "Installing Docker"
  curl -sSfL "https://download.docker.com/linux/ubuntu/gpg" \
    | gpg --dearmor | sudo tee /etc/apt/keyrings/docker.gpg > /dev/null
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update -q
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo usermod -aG docker "$USER" || true
  success "Docker installed"
  warn "Docker group applied — log out and back in to run docker without sudo"
}

# Ghostty — https://ghostty.org
install_ghostty() {
  command -v ghostty &>/dev/null && { skip ghostty; return; }
  info "Installing Ghostty"
  if command -v snap &>/dev/null; then
    sudo snap install ghostty --classic
  else
    warn "snap not available — skipping Ghostty (install manually: https://ghostty.org/download)"
    return
  fi
  success "Ghostty installed"
}

# 1Password — https://support.1password.com/install-linux/
install_1password() {
  command -v 1password &>/dev/null && { skip "1password"; return; }
  local arch; arch=$(dpkg --print-architecture)
  info "Installing 1Password"
  if [ "$arch" = "amd64" ]; then
    curl -sSfL "https://downloads.1password.com/linux/keys/1password.asc" \
      | gpg --dearmor | sudo tee /etc/apt/keyrings/1password-archive-keyring.gpg > /dev/null
    echo "deb [arch=${arch} signed-by=/etc/apt/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/${arch} stable main" \
      | sudo tee /etc/apt/sources.list.d/1password.list > /dev/null
    sudo apt-get update -q
    sudo apt-get install -y 1password
  else
    local tmp; tmp=$(mktemp -d)
    curl -sSfL "https://downloads.1password.com/linux/tar/stable/${arch}/1password-latest.tar.gz" \
      -o "$tmp/1password.tar.gz"
    tar -xzf "$tmp/1password.tar.gz" -C "$tmp"
    local src; src=$(find "$tmp" -maxdepth 1 -mindepth 1 -type d | head -1)
    sudo mkdir -p /opt/1password
    sudo cp -r "$src/." /opt/1password/
    sudo /opt/1password/after-install.sh
    rm -rf "$tmp"
  fi
  success "1Password installed"
}

# HackGen Nerd Font — https://github.com/yuru7/HackGen
install_hackgen_nerd() {
  local font_dir="${HOME}/.local/share/fonts"
  if ls "$font_dir"/HackGen*.ttf &>/dev/null 2>&1; then
    skip "HackGen Nerd Font"
    return
  fi
  info "Installing HackGen Nerd Font"
  local tag; tag=$(gh_latest yuru7/HackGen)
  local tmp; tmp=$(mktemp -d)
  curl -sSfL "https://github.com/yuru7/HackGen/releases/download/${tag}/HackGen_NF_${tag}.zip" \
    -o "$tmp/hackgen.zip"
  unzip -q "$tmp/hackgen.zip" -d "$tmp"
  mkdir -p "$font_dir"
  find "$tmp" -name "*.ttf" -exec cp {} "$font_dir/" \;
  fc-cache -f "$font_dir"
  rm -rf "$tmp"
  success "HackGen Nerd Font installed"
}

install_vscode
install_docker
install_ghostty
install_1password
install_hackgen_nerd

success "All extras installed"
