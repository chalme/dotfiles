#!/usr/bin/env bash

#judge brew command is installed
if command -v brew >/dev/null 2>&1; then
  echo "brew is installed"
else
  echo "brew is not installed"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update
brew upgrade

# cli
## search file
brew install fzf;
## HTTP benchmarking tool
brew install wrk;

## container
brew install colima
brew install docker

## mackup
# brew install mackup


## test


# tool
# brew install --cask alt-tab
brew install --cask hammerspoon
brew install --cask raycast
# brew install --cask betterdisplay
brew install jordanbaird-ice
brew install --cask pixpin
brew install --cask iina
brew install --cask stats
brew install --cask google-drive

# browser
brew install --cask google-chrome

# communication
brew install --cask telegram

# development
brew install --cask intellij-idea
brew install --cask zed
brew install --cask iterm2

# rss
brew install --cask netnewswire

# book
brew install --cask calibre

# note
# brew install --cask octarine
# https://octarine.app/

# download
brew install --cask motrix

# music spotify
bash <(curl -sSL https://spotx-official.github.io/run.sh) -B --installmac

# chatgpt
brew install --cask chatgpt

# image uploader
brew install --cask piclist



echo "install finished!"
