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
ensure-installed silversearcher-ag
ensure-installed entr
ensure-installed jq
ensure-installed autotrash
ensure-installed googler
ensure-installed curl

# Update PIP if required
pip install --upgrade pip
pip3 install --upgrade pip

# Install ipython CLI
pip install --user ipython
pip3 install --user ipython

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

	if ! command -v googler &>/dev/null; then
		sudo googler -u # upgrade to 4.2.3
	fi

fi

if [[ $OS == "macOS" ]]; then
	ensure-installed ip iproute2mac # for IP utils
	ensure-installed watch
	ensure-installed fd
	ensure-installed coreutils # for GNU ls
	ensure-installed exa
	ensure-installed trash

	# Install XCode tools
	xcode-select --install
fi

# Create ~/.bin folder if not yet present
mkdir -p ~/.bin

# Install Fira Code Font
if ! fc-list | grep -q firacode; then
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip -O /tmp/fira-code-symbols.zip
	sudo unzip -o /tmp/fira-code-symbols.zip -d /usr/share/fonts/opentype/
	sudo fc-cache -f -v # Refresh the font cache
fi

# Install OH MY ZSH & powerlevel10k
echo "Installing OH MY ZSH now. If asked to start ZSH now, say 'No' to continue with installation!"
[[ ! -f ~/.oh-my-zsh/oh-my-zsh.sh ]] && rm -rf ~/.oh-my-zsh/ # remove potentially corrupt folder
[[ ! -d ~/.oh-my-zsh ]] && sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
[[ ! -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]] && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install translate CLI
[[ ! -f ~/.bin/trans ]] && cd ~/.bin && wget git.io/trans && chmod +x ~/.bin/trans

# Install HTTP Status Code CLI Utility
! command -v hs &>/dev/null && npm install http-status-identifier-cli -g

# Install SCP/SFTP TUI
curl --proto '=https' --tlsv1.2 -sSLf "https://git.io/JBhDb" | sh

# Create symlinks
cd ~
ln -s -f $DIR/.zshrc ~/.zshrc
ln -s -f $DIR/p10k.$OS.zsh ~/.p10k.zsh
ln -s -f $DIR/.functions ~/.functions
ln -s -f $DIR/.aliases ~/.aliases
ln -s -f $DIR/ips.py ~/.bin/ips
ln -s -f $DIR/zellij ~/.config/zellij
ln -s -f $DIR/plotjuggler.sh ~/.bin/plotjuggler
ln -s -f $DIR/disk-cleanup.bash ~/.bin/disk-cleanup
[[ -e ~/.config/catkin/verb_aliases/ ]] && ln -sf $DIR/catkin/01-clang-aliases.yaml ~/.config/catkin/verb_aliases/01-clang-aliases.yaml
mkdir -p ~/.config/lazygit/ && ln -sf $DIR/lazygit.yaml ~/.config/lazygit/config.yml

# Install Fuzzy finding
if [[ ! -d ~/.fzf ]]; then
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install --no-update-rc --key-bindings --completion
fi

zsh # Restart ZSH with new config
