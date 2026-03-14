# Contributing to devtools

Thanks for contributing. This document contains maintainer-facing guidance for the GUI apps and fonts layer.

## Development Principles

- Keep `README.md` user-facing. CI behavior and platform-specific maintenance notes belong here.
- Keep this repository focused on GUI apps and fonts only.
- Prefer vendor-supported installation methods on Linux and Homebrew Cask on macOS.
- Keep curl mode and clone mode behavior aligned.

## Source of Truth

- `platform/macos/Brewfile` defines macOS app and font installation.
- `platform/linux/extras.sh` defines Linux app and font installation.
- `install.sh` is the entry point and fetches the platform files in curl mode.

## How to Make Changes

- Add macOS apps and fonts through `platform/macos/Brewfile`.
- Add Linux app and font logic to `platform/linux/extras.sh`.
- Keep the desktop layer separate from CLI tooling and shell/editor configuration.
- If a change affects the full setup flow, consider whether [dev-setup](https://github.com/tafuru/dev-setup) documentation should also change.

## Validation

Recommended checks before merging:

```bash
bash install.sh
```

```bash
shellcheck install.sh platform/linux/extras.sh
```

Helpful platform-specific verification includes checking the expected app binaries or application bundles and confirming that HackGen Nerd Font is installed.

## CI Overview

CI currently validates the following:

- `shellcheck` on `install.sh` and `platform/linux/extras.sh`
- clone mode and curl mode on macOS and Ubuntu runners
- expected applications and fonts after installation
- downstream notification to [dev-setup](https://github.com/tafuru/dev-setup) after successful pushes to `main`

## Repo-Specific Notes

- When running through `curl`, `install.sh` fetches platform files from GitHub based on `DEVTOOLS_BRANCH`.
- Keep GUI app logic here rather than in [cmdtools](https://github.com/tafuru/cmdtools).
- When Linux installation logic becomes complex, prefer extracting helper functions inside `platform/linux/extras.sh` rather than expanding `install.sh`.
