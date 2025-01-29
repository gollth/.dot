#!/usr/bin/env bash

DIR=~/.dot

if [[ $(uname -s) == "Linux" ]]; then
  OS=Linux
elif [[ $(uname -s) == "Darwin" ]]; then
  OS=macOS
else
  echo "Unsupported OS $(uname -s)"
  exit 1
fi

# Install ZSH and OH-MY-ZSH
# Update PIP if required
pip3 install --upgrade pip

# Rust
if ! command cargo &>/dev/null; then
  echo "Installing Rust & Cargo now"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if [[ $OS == "Linux" ]]; then
  ensure-installed python3-dev
  ensure-installed powerline
  ensure-installed trash-cli

  # Install find-fd
  if ! command -v fd &>/dev/null; then
    cargo install fd-find
  fi

  if ! command -v exa &>/dev/null; then
    cargo install exa
  fi
  if ! command -v irust &>/dev/null; then
    cargo install irust
  fi
  if ! command -v systemctl-tui &>/dev/null; then
    cargo install systemctl-tui
    sudo ln -s ~/.cargo/bin/systemctl-tui /usr/bin/systemctl-tui
  fi

  # Uni
  if ! command -v unipicker &>/dev/null; then
    wget -O- https://github.com/arp242/uni/releases/download/v2.5.1/uni-v2.5.1-linux-amd64.gz -O /tmp/uni.gz
    gunzip -dvc /tmp/uni.gz >~/.bin/uni
    chmod +x ~/.bin/uni
  fi

fi

if [[ $OS == "macOS" ]]; then
  # ensure-installed ip iproute2mac # for IP utils
  # ensure-installed watch
  # ensure-installed fd
  # ensure-installed coreutils # for GNU ls
  # ensure-installed exa
  # ensure-installed trash
  # ensure-installed uni

  if ! command http &>/dev/null; then
    brew install --cask httpie
  fi

  if ! command btop &>/dev/null; then
    brew install btop
  fi

  # Install XCode tools
  xcode-select --install
fi

# Create ~/.bin folder if not yet present
mkdir -p ~/.bin

# Install OH MY ZSH & powerlevel10k
echo "Installing OH MY ZSH now. If asked to start ZSH now, say 'No' to continue with installation!"
[[ ! -f ~/.oh-my-zsh/oh-my-zsh.sh ]] && rm -rf ~/.oh-my-zsh/ # remove potentially corrupt folder
[[ ! -d ~/.oh-my-zsh ]] && sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
[[ ! -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]] && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install translate CLI
[[ ! -f ~/.bin/trans ]] && cd ~/.bin && wget git.io/trans && chmod +x ~/.bin/trans

# Create symlinks
cd ~
ln -s -f $DIR/.zshrc ~/.zshrc
ln -s -f $DIR/p10k.$OS.zsh ~/.p10k.zsh
ln -s -f $DIR/.functions ~/.functions
ln -s -f $DIR/.aliases ~/.aliases
ln -s -f $DIR/ips.py ~/.bin/ips
ln -s -f $DIR/zellij ~/.config/zellij
ln -s -f $DIR/kitty.conf ~/.config/kitty/kitty.conf
ln -s -f $DIR/kitty-macos-launch-services-cmdline ~/.config/kitty/macos-launch-services-cmdline
ln -s -f $DIR/disk-cleanup.bash ~/.bin/disk-cleanup
mkdir -p ~/.config/lazygit/ && ln -sf $DIR/lazygit.yaml ~/.config/lazygit/config.yml
mkdir -p ~/.config/lazydocker/ && ln -sf $DIR/lazydocker.yaml ~/.config/lazydocker/config.yml
ln -s -f $DIR/btop.conf ~/.config/btop/btop.conf

# ~/Library/Application Support/jesseduffield/lazydocker/config.yml

# Install Fuzzy finding
if [[ ! -d ~/.fzf ]]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --no-update-rc --key-bindings --completion
fi

# QMK
if ! command -v qmk &>/dev/null; then
  brew install qmk
  qmk setup -H ~/.qmk
  qmk config user.keyboard=beekeep/piantor
  qmk config user.keymap=gollth
  mkdir -p ~/.qmk/keyboards/beekeeb/piantor/keymaps/gollth
  ln -sf ~/.qmk/keyboards/beekeeb/piantor/keymaps/gollth/keymap.c $DIR/keymap.c
fi
