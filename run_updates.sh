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

printf "\n${BLUE}Check for Python updates${RESET}\n"
current_version=$(uv run python -V 2>&1 | rg -o '\d+\.\d+\.\d+')
new_version=$(uv python install 3.14 --reinstall 2>&1 | rg -o '\d+\.\d+\.\d+' | head -n1)
if [[ "$current_version" == "$new_version" ]] ; then
  printf "\n${BLUE}No new Python version, updating uv tool packages${RESET}\n"
  uv tool upgrade --all
else
  printf "\n${BLUE}New Python version, reinstalling uv tool packages${RESET}\n"
  uv tool upgrade --all --reinstall
fi

printf "\n${BLUE}Updating rust${RESET}\n"
rustup update
printf "\n${BLUE}Updating cargo packages${RESET}\n"
cargo install-update -a
# printf "\n${BLUE}Updating pyenv${RESET}\n"
# git -C $HOME/.pyenv pull
