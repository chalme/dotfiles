# dotfiles

Personal bootstrap repository for initializing a new machine with a stable, low-maintenance baseline.

This repo is organized as a lightweight system setup project:

- `README.md` is the homepage and index.
- root-level scripts handle setup tasks in small pieces.
- detailed operating notes live under [`docs/`](docs/).
- `.vimrc` acts as a server-friendly editing baseline rather than a terminal IDE.

## Project Positioning

This repository is best understood as a practical machine bootstrap kit for daily development:

- restore personal config with low ceremony
- keep tools and scripts easy to audit
- prefer stable, portable defaults over clever automation
- split reusable baseline setup from personal or machine-specific tweaks

## Quick Start

Review scripts before running them. The current repo is intentionally small and personal, so the safest flow is selective execution instead of one giant bootstrap command.

1. Read the setup notes in [`docs/bootstrap.md`](docs/bootstrap.md).
2. Link baseline dotfiles into `$HOME` with [`link.sh`](link.sh).
3. Review the package list in [`brew.sh`](brew.sh).
4. Restore managed dotfiles with [`install.sh`](install.sh) after `mackup` is available.
5. Install language tooling with [`dev.sh`](dev.sh) if needed.

## Repository Map

| Path | Role |
| --- | --- |
| [`README.md`](README.md) | Homepage, usage entrypoint, and document index |
| [`link.sh`](link.sh) | Manifest-driven symlink bootstrap for selected dotfiles in `$HOME` |
| [`.vimrc`](.vimrc) | Lightweight Vim baseline for SSH, config editing, grep, and quickfix workflows |
| [`.mackup.cfg`](.mackup.cfg) | Mackup restore configuration |
| [`install.sh`](install.sh) | Links `.mackup.cfg` into `$HOME` and runs `mackup restore` |
| [`brew.sh`](brew.sh) | Installs Homebrew packages and personal desktop applications |
| [`dev.sh`](dev.sh) | Installs SDKMAN for Java toolchain management |
| [`config`](config) | Pulls in external keyboard configuration |
| [`idea.sh`](idea.sh) | Personal IntelliJ local customization script; review manually before any use |

## What Matters Most

### Bootstrap Principles

- keep initialization scripts small and readable
- favor repeatable steps over opaque magic
- separate baseline setup from personal extras
- document the intent of each script before expanding automation

### Vim Baseline Summary

The `.vimrc` in this repo is a backend/server editing baseline:

- no plugin dependency
- friendly to SSH and remote servers
- optimized for config files, Java touch-ups, grep, and quickfix jumps
- stable enough to keep for a long time without constant maintenance

High-value capabilities:

| Area | What it gives you |
| --- | --- |
| Save and quit | Fast daily actions with `<Space>w`, `<Space>q`, `<Space>Q` |
| Search | Better in-file search with smart case, highlight, and centered jumps |
| Project grep | `rg`-first project search with quickfix navigation |
| Split and buffer control | Lightweight multi-file editing without plugins |
| Invisible character display | Safer editing for YAML, `.env`, Docker, and other config files |
| Large-file protection | Fewer UI features in big files to keep Vim responsive |

Full details live in [`docs/vimrc.md`](docs/vimrc.md).

## Documentation Index

- [`docs/bootstrap.md`](docs/bootstrap.md): script roles, setup order, and what should be reviewed before running
- [`docs/vimrc.md`](docs/vimrc.md): detailed `.vimrc` breakdown, keymaps, trade-offs, and suitable use cases

## Suggested Next Step

As this repo evolves into a fuller bootstrap project, the next useful improvement is to keep expanding documentation first, then tighten scripts around those documented flows.
