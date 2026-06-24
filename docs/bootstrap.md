# Bootstrap Guide

## Purpose

This repository is not a one-click universal installer yet. It is a review-first bootstrap kit for setting up a familiar personal development environment on a new machine.

The current design goal is:

- keep each setup step separate
- make scripts easy to inspect
- avoid hiding machine-specific behavior inside a single opaque entrypoint

## Recommended Order

1. Install Homebrew and core packages with [`../brew.sh`](../brew.sh).
2. Run [`../link.sh`](../link.sh) to symlink the baseline dotfiles into `$HOME`.
3. Ensure `mackup` is installed and cloud-backed config is available.
4. Run [`../install.sh`](../install.sh) to restore managed dotfiles.
5. Run [`../dev.sh`](../dev.sh) if you want SDKMAN-managed Java environments.
6. Review personal add-ons such as [`../config`](../config) and [`../idea.sh`](../idea.sh) manually before use.

## Script Roles

### `brew.sh`

Primary macOS package bootstrap script.

What it currently does:

- installs Homebrew if missing
- updates and upgrades installed packages
- installs selected CLI tools
- installs personal desktop applications with `brew --cask`
- runs additional personal app installation steps

What to know before running:

- it is macOS-specific
- it includes personal application choices, not just baseline development tools
- it uses network access and remote install commands
- it should be reviewed whenever the machine profile changes

### `link.sh`

Baseline symlink bootstrap script.

What it currently does:

- links selected repository files into `$HOME`
- manages an explicit manifest instead of auto-discovering dotfiles
- skips links that already point to the expected repository file
- backs up existing files before replacing them with symlinks

This is the safest first-run entrypoint in the repository because it only manages a small, explicit set of baseline files.

### `install.sh`

Dotfile restore entrypoint.

What it currently does:

- checks whether `mackup` is installed
- links [`.mackup.cfg`](../.mackup.cfg) into `$HOME`
- runs `mackup restore`

This script is the closest thing to the repo's current "dotfiles restore" entrypoint.

### `dev.sh`

Language runtime bootstrap helper.

What it currently does:

- installs SDKMAN
- initializes SDKMAN in the current shell

This is currently focused on Java-oriented development setup.

### `config`

External configuration bootstrap helper.

What it currently does:

- clones a keyboard configuration repository into `~/.keyboard`
- runs that repo's setup script

Because it reaches into another repository, it should be treated as an explicit personal extension rather than a default-safe baseline step.

### `idea.sh`

Personal IDE customization script.

This script is intentionally not part of the recommended default bootstrap flow. It changes local IntelliJ configuration and should be manually audited, rewritten, or replaced with a safer documented setup before relying on it as shared baseline automation.

## Suggested Long-Term Structure

As this project grows, a good separation is:

- baseline machine setup
- dotfiles restore
- language/runtime setup
- personal desktop apps
- machine-specific overrides

That keeps the repo usable as both a personal toolkit and a reusable initialization reference.
