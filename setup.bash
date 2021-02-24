#!/usr/bin/env bash

DIR=$(dirname $(readlink -e $0))
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
ensure-installed python-pip
ensure-installed python3-pip
ensure-installed python-argcomplete
ensure-installed jq

# Update PIP if required
pip  install --upgrade pip
pip3 install --upgrade pip

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

    # Install XCode tools
    xcode-select --install
fi


# Create ~/.bin folder if not yet present
mkdir -p ~/.bin

# Install Emacs26
if ! command -v emacs26 &> /dev/null ; then
  echo "Emacs NOT installed"
  sudo add-apt-repository ppa:kelleyk/emacs
  ensure-installed emacs26
fi

# Install Spacemacs
[[ ! -d ~/.emacs.d ]]     && git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d --branch develop
[[ ! -d ~/.spacemacs.d ]] && git clone https://github.com/gollth/.spacemacs.d ~/.spacemacs.d --recursive
[[ ! -f ~/.spacemacs ]]   && ln -sf ~/.spacemacs.d/.spacemacs ~/.spacemacs

# Install NVM & NPM
[[ ! -d ~/.nvm ]] && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install v14.16.0

# Install Stack Haskell
! command -v stack &> /dev/null && curl -sSL https://get.haskellstack.org/ | sh

# Install Haskell Language Server & Wrapper
RELEASE=$(curl -sX GET https://api.github.com/repos/haskell/haskell-language-server/git/refs/tags | jq ".[-1].ref" | sed 's/"refs\/tags\/\(.*\)"/\1/')
if [ ! -f ~/.bin/haskell-language-server ] ; then
    HASKELL_LSP_VERSION=8.6.5
    echo "Downloading Haskell Language Server Version $HASKELL_LSP_VERSION (Release $RELEASE) from Github for $OS"
    curl -#SL --output /tmp/haskell-language-server.gz https://github.com/haskell/haskell-language-server/releases/download/$RELEASE/haskell-language-server-$OS-$HASKELL_LSP_VERSION.gz
    gunzip /tmp/haskell-language-server.gz
    rm /tmp/haskekll-language-server.gz
    mv /tmp/haskell-language-server ~/.bin/
    chmod +x ~/.bin/haskell-language-server
fi

# Install Haskell Language Server Wrapper
if [ ! -f ~/.bin/haskell-language-server-wrapper ] ; then
    echo "Downllading Haskell Language Server Wrapper (Release $RELEASE) from Github for $OS"
    curl -#SL --output /tmp/haskell-language-server-wrapper.gz https://github.com/haskell/haskell-language-server/releases/download/$RELEASE/haskell-language-server-wrapper-$OS.gz
    gunzip /tmp/haskell-language-server-wrapper.gz
    mv /tmp/haskell-language-server-wrapper ~/.bin/
    chmod +x ~/.bin/haskell-language-server-wrapper
fi


# Install OH MY ZSH & powerlevel10k
echo "Installing OH MY ZSH now. If asked to start ZSH now, say 'No' to continue with installation!"
[[ ! -f ~/.oh-my-zsh/oh-my-zsh.sh ]] && rm -rf ~/.oh-my-zsh/  # remove potentially corrupt folder
[[ ! -d ~/.oh-my-zsh ]] && sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
[[ ! -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]] && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install translate CLI
[[ ! -f ~/.bin/trans ]] && cd ~/.bin && wget git.io/trans && chmod +x ~/.bin/trans

# Install HTTP Status Code CLI Utility
! command -v hs &> /dev/null && npm install http-status-identifier-cli -g

# Create symlinks
cd ~
ln -s -f $DIR/.zshrc      ~/.zshrc
ln -s -f $DIR/p10k.$OS.zsh ~/.p10k.zsh
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
