#!/bin/bash

RESET='\033[0m'
BLUE='\033[34m'

"$ZSH/tools/upgrade.sh"
printf "\n${BLUE}Updating dot files${RESET}\n"
git -C $HOME/dotfiles pull origin main --ff-only
printf "\n${BLUE}Running paru${RESET}\n"
paru
printf "\n${BLUE}Updating NPM packages${RESET}\n"
npm -g update
printf "\n${BLUE}Updating uv${RESET}\n"
uv self update
printf "\n${BLUE}Updating uv tool packages${RESET}\n"
uv tool upgrade --all
printf "\n${BLUE}Updating rust${RESET}\n"
rustup update
printf "\n${BLUE}Updating cargo packages${RESET}\n"
cargo install-update -a
printf "\n${BLUE}Updating pyenv${RESET}\n"
git -C $HOME/.pyenv pull
