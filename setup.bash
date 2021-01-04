#!/usr/bin/env bash

DIR="$HOME/$(dirname "$0")"
source $DIR/.functions

if [[ $(uname -s) == "Linux" ]]; then
    OS=Linux
elif [[ $(uname -s) == "Darwin" ]]; then
    OS=macOS
else
    echo "Unsupported OS $(uname -s)"
    exit 1
fi

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

if [[ $OS == "Linux" ]]; then
    ensure-installed python3-dev
    ensure-installed powerline
fi

if [[ $OS == "macOS" ]]; then
    ensure-installed ip iproute2mac # for IP utils
    ensure-installed watch
    ensure-installed jq
fi


# Create ~/.bin folder if not yet present
mkdir -p ~/.bin

# Install NVM
[[ ! -d ~/.nvm ]] && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash

# Install Stack Haskell
! command -v stack &> /dev/null && curl -sSL https://get.haskellstack.org/ | sh

# Install Haskell Language Server & Wrapper
RELEASE=$(curl -sX GET https://api.github.com/repos/haskell/haskell-language-server/git/refs/tags | jq ".[-1].ref" | sed 's/"refs\/tags\/\(.*\)"/\1/')
if ! command -v haskell-language-server &> /dev/null; then
    HASKELL_LSP_VERSION=8.6.5
    echo "Downloading Haskell Language Server Version $HASKELL_LSP_VERSION (Release $RELEASE) from Github for $OS"
    curl -#SL --output /tmp/haskell-language-server.gz https://github.com/haskell/haskell-language-server/releases/download/$RELEASE/haskell-language-server-$OS-$HASKELL_LSP_VERSION.gz
    gunzip /tmp/haskell-language-server.gz
    rm /tmp/haskekll-language-server.gz
    mv /tmp/haskell-language-server ~/.bin/
    chmod +x ~/.bin/haskell-language-server
fi

# Install Haskell Language Server Wrapper
if ! command -v haskell-language-server-wrapper &> /dev/null; then
    echo "Downllading Haskell Language Server Wrapper (Release $RELEASE) from Github for $OS"
    curl -#SL --output /tmp/haskell-language-server-wrapper.gz https://github.com/haskell/haskell-language-server/releases/download/$RELEASE/haskell-language-server-wrapper-$OS.gz
    gunzip /tmp/haskell-language-server-wrapper.gz
    mv /tmp/haskell-language-server-wrapper ~/.bin/
    chmod +x ~/.bin/haskell-language-server-wrapper
fi


# Install OH MY ZSH
[[ ! -d ~/.oh-my-zsh ]] && sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install translate CLI
[[ ! -f ~/.bin/trans ]] && cd ~/.bin && wget git.io/trans && chmod +x ~/.bin/trans

# Install HTTP Status Code CLI Utility
! command -v hs &> /dev/null && npm install http-status-identifier-cli -g

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
