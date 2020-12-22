#!/usr/bin/env bash

DIR="$HOME/$(dirname "$0")"
source $DIR/.functions

# Install ZSH and OH-MY-ZSH
ensure-installed git
ensure-installed wget
ensure-installed zsh
ensure-installed cmake
ensure-installed python3

# Update PIP if required
pip install --upgrade pip
pip install --upgrade pip

# Install ipython CLI
pip install --user ipython
pip3 install --user ipython

if [[ $(uname -s) == "Linux" ]]; then
    ensure-installed python3-dev
    ensure-installed powerline
fi

if [[ $(uname -s) == "Darwin" ]]; then
    ensure-installed ip iproute2mac # for IP utils
    ensure-installed watch
fi


# Create ~/.bin folder if not yet present
mkdir -p ~/.bin

# Install NVM
[[ ! -d ~/.nvm ]] && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash

# Install OH MY ZSH
[[ ! -d ~/.oh-my-zsh ]] && sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install translate CLI
[[ ! -f ~/.bin/trans ]] && cd ~/.bin && wget git.io/trans && chmod +x ~/.bin/trans

# Create symlinks
cd ~
ln -s -f $DIR/.zshrc      ~/.zshrc
ln -s -f $DIR/.functions  ~/.functions
ln -s -f $DIR/.aliases    ~/.aliases
ln -s -f $DIR/ips.py      ~/.bin/ips
ln -s -f $DIR/disk-cleanup.bash ~/.bin/disk-cleanup

# Install Fuzzy finding
if [[ ! -d ~/.fzf ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --no-update-rc --key-bindings --completion
fi

zsh  # Restart ZSH with new config
