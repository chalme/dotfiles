#!/usr/bin/env bash

# mkdir -p ~/.config
# ln -sfn $PWD/zed ~/.config/
#
# judge mackup is installed
if [ ! -x "$(command -v mackup)" ]; then
  echo "mackup is not installed"
  exit 1
fi

# link .mackup.cfg to home directory
ln -sfn $PWD/.mackup.cfg ~/

mackup restore
