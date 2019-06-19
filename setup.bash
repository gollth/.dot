#!/usr/bin/env bash

DIR="$(dirname "$(readlink -f "$0")")"
source $DIR/.functions

# Install ZSH and OH-MY-ZSH
ensure-installed git
ensure-installed wget
ensure-installed zsh
ensure-installed cmake
ensure-installed python3-dev

[[ ! -d ~/.oh-my-zsh ]] && sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Create symlinks for
cd ~
ln -s -f $DIR/.zshrc
ln -s -f $DIR/.functions
ln -s -f $DIR/.aliases
