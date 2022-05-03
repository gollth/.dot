# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Enable command auto-correction.
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    fzf
    nvm
)

source $ZSH/oh-my-zsh.sh
[[ -f ~/.zprofile ]] && source ~/.zprofile

# User configuration

[ -d "$HOME/.bin" ]       && PATH="$HOME/.bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.cargo/bin" ] && PATH="$HOME/.cargo/bin:$PATH"
[ -d "$HOME/.cabal/bin" ] && PATH="$HOME/.cabal/bin:$PATH"
[ -d "$HOME/.ghcup/bin" ] && PATH="$HOME/.ghcup/bin:$PATH"
[ -d /usr/share/autojump ] && source /usr/share/autojump/autojump.sh

if [[ -d "$HOME/Library/Python" ]] ; then
    # Add python local libraries to Path (OSX)
    PATH="$HOME/Library/Python/$(ls $HOME/Library/Python | tail -n 1)/bin:$PATH"
fi

export LANG=en_US.UTF-8
export EDITOR='emacs26 -nw'
export TERM=xterm-256color
export ROSCONSOLE_FORMAT='▏${severity}▕ ${node} ⟩ ${function}() ⟩ L${line} ⟫ ${message}'

command -v rustc > /dev/null && export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"


source ~/.aliases
source ~/.functions

# ROS Setup
[ -d /opt/ros ]       && source $(ls -d /opt/ros/* | tail -n 1)/setup.zsh
[ -f $HOME/.roshost ] && source $HOME/.roshost;
[ -f $HOME/.rosws ]   && source $HOME/$(cat $HOME/.rosws)/devel/setup.zsh;

# NVM Setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## Autocompletion Setup
autoload -U bashcompinit
bashcompinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
