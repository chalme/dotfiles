#!/bin/bash

# 更新 Homebrew 仓库和公式
brew update

# 安装软件列表
apps=(
  google-chrome
  intellij-idea
  visual-studio-code
  iterm2
  calibre
  telegram
  alt-tab
  hammerspoon
  karabiner-elements
  snipaste
  iina
  logseq
  stats
  warp
)

for app in "${apps[@]}"; do
  brew install --cask "$app"
done

echo "install finished!"

# 安装 oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 安装 zsh-autosuggestions


mkdir -p ~/.config
ln -sfn $PWD/zed ~/.config/

#judge brew command is installed
if command -v brew >/dev/null 2>&1; then
  echo "brew is installed"
else
  echo "brew is not installed"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
