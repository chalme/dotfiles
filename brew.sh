#!/usr/bin/env bash

#judge brew command is installed
if command -v brew >/dev/null 2>&1; then
  echo "brew is installed"
else
  echo "brew is not installed"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update

# tool
brew install --cask alt-tab
brew install --cask hammerspoon
brew install --cask raycast
brew install --cask betterdisplay
brew install --cask hiddenbar
brew install --cask snipaste
brew install --cask iina
brew install --cask stats


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
brew install --cask logseq

# download
brew install --cask motrix

# music spotify
bash <(curl -sSL https://spotx-official.github.io/run.sh) -B --installmac

# chatgpt
brew tap lencx/chatgpt https://github.com/lencx/ChatGPT.git
brew install --cask chatgpt --no-quarantine



echo "install finished!"
