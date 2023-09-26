# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vi-mode zsh-syntax-highlighting zsh-autosuggestions web-search you-should-use)

source $ZSH/oh-my-zsh.sh

# Make cursor change with different vim modes
_fix_cursor() {
   echo -ne '\e[5 q'
}

precmd_functions+=(_fix_cursor)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Aliases

alias vim="nvim"
alias venv="virtualenv .venv && . .venv/bin/activate && pip install -U pip"
alias activate=". .venv/bin/activate && pip install -U pip"
alias erd="erd -I --sort name"
alias gm="git checkout main"
alias gs="git status"
alias gd="git diff"
alias gb="git blame"
alias gpom="git pull origin main --ff-only"
alias gpum="git pull upstream main --ff-only"
alias gcam="git commit -am"
alias gcb="git checkout -b"
alias gc="git checkout"
alias gbd="git branch -d"
alias gbm="git branch -m"
alias gph="git push origin HEAD"
alias pl10ku="git -C ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k pull"
alias pyenvu="git -C $HOME/.pyenv pull"  # Only works if pyenv installed from github
alias dotfilesu="git -C $HOME/dotfiles pull origin main --ff-only"
alias we="weather zip 27455 --country-code usa"
alias wed="weather zip 27455 -f daily --country-code usa"
alias weh="weather zip 27455 -p -f hourly --country-code usa"
alias ls="lsd"
alias ll="lsd -l"
alias ds="docker stop \$(docker ps -q)"
alias dsp="docker system prune -f"
alias dspv="docker system prune -f --all --volumes"
alias gti="git"  # Because I constantly typo this
cdp() {
  cd "$HOME/development/python/$1"
}
cdr() {
  cd "$HOME/development/rust/$1"
}
cdw() {
  cd "$HOME/development/web/$1"
}

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export PATH="$HOME/.npm-global/bin:$PATH"
export COOKIECUTTER_CONFIG="$HOME/.cookiecutters/defaults.yaml"
export PATH="$PATH:/home/paul/.local/bin"

# Kitty ssh
if [[ "${TERM}" == "xterm-kitty" ]]; then
  alias ssh="kitty +kitten ssh"
  alias icat="kitty +kitten icat"  # view images in the terminal
fi

# OS Specific settings

if [[ `uname` == "Linux" ]]; then
  export EDITOR="/usr/bin/nvim"
  export VISUAL="/usr/bin/nvim"
fi

# Arch/Manjaro
if command -v pacman > /dev/null; then
  alias pm="sudo pacman -Syyu"
fi

if [[ `uname` == "Darwin" ]]; then
  export EDITOR="/opt/homebrew/bin/nvim"
  export VISUAL="/opt/homebrew/bin/nvim"
fi

# homebrew
if command -v brew > /dev/null; then
  alias bu="brew update && brew upgrade"
fi

if command -v apt > /dev/null; then
  alias au="sudo apt update && sudo apt upgrade"
fi

eval "$(starship init zsh)"
eval "$(mcfly init zsh)"
