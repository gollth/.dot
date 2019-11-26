#!/usr/bin/env bash

DIR="$(dirname "$(readlink -f "$0")")"
source $DIR/.functions

# Install ZSH and OH-MY-ZSH
ensure-installed git
ensure-installed wget
ensure-installed zsh
ensure-installed cmake
ensure-installed python3-dev
ensure-installed powerline
ensure-installed inotify-tools

[[ ! -d ~/.oh-my-zsh ]] && sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Create symlinks for
cd ~
ln -s -f $DIR/.zshrc      ~/.zshrc
ln -s -f $DIR/.functions  ~/.functions
ln -s -f $DIR/.aliases    ~/.aliases
ln -s -f $DIR/catkin/01-clang-aliases.yaml ~/.config/catkin/verb_aliases/01-clang-aliases.yaml

# Install Fuzzy finding
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

zsh  # Restart ZSH with new config
