# devtools

[![CI](https://github.com/tafuru/devtools/actions/workflows/ci.yml/badge.svg)](https://github.com/tafuru/devtools/actions/workflows/ci.yml)

GUI apps and fonts installer for macOS and Linux.

## Apps & Fonts

| Tool | Description |
|---|---|
| [Visual Studio Code](https://code.visualstudio.com) | Code editor |
| [Docker](https://www.docker.com) | Container platform |
| [Ghostty](https://ghostty.org) | Terminal emulator |
| [1Password](https://1password.com) | Password manager |
| [HackGen Nerd Font](https://github.com/yuru7/HackGen) | Japanese programming font with Nerd Font icons |

## Installation

Without cloning (recommended):

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/tafuru/devtools/main/install.sh)"
```

Or clone and run:

```bash
git clone https://github.com/tafuru/devtools.git
cd devtools
bash install.sh
```

On macOS, apps and fonts are installed via Homebrew Cask. On Linux, apps are installed from their official apt repositories; HackGen Nerd Font is fetched from GitHub Releases and installed to `~/.local/share/fonts/`.

## Design Principles

- Installs GUI apps and fonts only — configuration lives in [dotfiles](https://github.com/tafuru/dotfiles)
- Separate from [cmdtools](https://github.com/tafuru/cmdtools) — CLI tools and GUI apps have different lifecycles
- Linux uses official vendor apt repositories for apps; no Linuxbrew

## Related

For a full machine setup, see [dev-setup](https://github.com/tafuru/dev-setup).

## License

This repository is licensed under the MIT License. See [LICENSE](LICENSE) for details.
