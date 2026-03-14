# devtools

[![CI](https://github.com/tafuru/devtools/actions/workflows/ci.yml/badge.svg)](https://github.com/tafuru/devtools/actions/workflows/ci.yml)

Install GUI apps and fonts for macOS and Ubuntu/Debian. This repository provides the optional desktop layer for the broader setup, separate from CLI tools and shell configuration.

## Quick Start

Without cloning:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/tafuru/devtools/main/install.sh)"
```

Or clone and run locally:

```bash
git clone https://github.com/tafuru/devtools.git
cd devtools
bash install.sh
```

## When to Use This Repository

- Use this repository when you want GUI apps and fonts on top of your CLI setup.
- Use `dev-setup --devtools` if you want this layer as part of the full machine bootstrap.
- Run this repository directly if your CLI tools and dotfiles are already in place.

## What It Installs

| App or font | Purpose |
|---|---|
| [Visual Studio Code](https://code.visualstudio.com) | General-purpose code editor |
| [Docker](https://www.docker.com) | Container tooling and local container runtime |
| [Ghostty](https://ghostty.org) | Terminal emulator |
| [1Password](https://1password.com) | Password manager and SSH agent integration |
| [HackGen Nerd Font](https://github.com/yuru7/HackGen) | Programming font with Nerd Font icons |

## Platform Notes

- On macOS, apps and fonts are installed through Homebrew Cask.
- On Ubuntu/Debian, apps are installed from vendor-supported sources where practical, and HackGen Nerd Font is installed from GitHub Releases.
- CLI tools and shell/editor configuration remain separate in [cmdtools](https://github.com/tafuru/cmdtools) and [dotfiles](https://github.com/tafuru/dotfiles).

## Related Repositories

| Repository | Responsibility |
|---|---|
| [dev-setup](https://github.com/tafuru/dev-setup) | Full machine setup and orchestration |
| [cmdtools](https://github.com/tafuru/cmdtools) | CLI tool installation |
| [dotfiles](https://github.com/tafuru/dotfiles) | Shell, editor, prompt, and terminal configuration |

## Contributing

README stays focused on what this repository installs and when to use it. For platform-specific implementation notes, validation commands, and CI details, see [CONTRIBUTING.md](CONTRIBUTING.md).

## License

This repository is licensed under the MIT License. See [LICENSE](LICENSE) for details.
