#!/bin/zsh

# Make a backup of the .zshrc file if it exists then symlink it to dotfiles
ZSHRC="$HOME/.zshrc"

if test -f "$ZSHRC"; then
  mv "$ZSHRC" "$ZSHRC.backup"
fi

ln -s "$HOME/dotfiles/zsh/.zshrc" "$ZSHRC"

# Make a backup of the neovim config if it exists then symlink it to dotfiles
NVIM_DIR="$HOME/.config/nvim"
if [ -d "$NVIM_DIR" ]; then
  mv "$NVIM_DIR" "${NVIM_DIR}_backup"
fi

ln -s "$HOME/dotfiles/nvim" "$NVIM_DIR"

# Make a backup of .p10k.zsh if it exists then symlink it to dotfiles
P10K="$HOME/.p10k.zsh"
if test -f "$P10K"; then
  mv "$P10K" "$P10k.backup"
fi

ln -s "$HOME/dotfiles/powerlevel10k/.p10k.zsh" "$P10K"

# Make a backup of the kitty config if it exists then symlink it to dotfiles
KITTY="$HOME/.config/kitty/kitty.conf"

if test -f "$KITTY"; then
  mv "$KITTY" "$KITTY.backup"
fi

ln -s "$HOME/dotfiles/kitty/kitty.conf" "$KITTY"
