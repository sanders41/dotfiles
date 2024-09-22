#!/bin/zsh

# Make a backup of the .zshrc file if it exists then symlink it to dotfiles
ZSHRC="$HOME/.zshrc"

if test -f "$ZSHRC"; then
  mv "$ZSHRC" "$ZSHRC.backup"
fi

ln -s "$HOME/dotfiles/zsh/zshrc" "$ZSHRC"

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

# Make a backup of the kitty theme if it exists then symlink it to dotfiles
KITTY_THEME=current-theme.conf

if test -f "$KITTY_THEME"; then
  mv "$KITTY_THEME" "$KITTY_THEME.backup"
fi

ln -s "$HOME/dotfiles/kitty/current-theme.conf" "$KITTY_THEME"

# Link alacritty config
ALACRITTY="$HOME/.config/alacritty/alacritty.toml"

if test -f "$ALACRITTY"; then
  mv "$ALACRITTY" "$ALACRITTY.backup"
fi

ln -s "$HOME/dotfiles/alacritty/alacritty.toml" "$ALACRITTY"

# Link zellij config
ZELLIJ="$HOME/.config/zellij/config.kdl"

if test -f "$ZELLIJ"; then
  mv "$ZELLIJ" "$ZELLIJ.backup"
fi

ln -s "$HOME/dotfiles/zellij/config.kdl" "$ZELLIJ"

# Link pip config

PIP=$HOME/.config/pip/pip.conf

if test -f "$PIP"; then
  mv "$PIP" "$PIP.backup"
fi

ln -s "$HOME/dotfiles/pip/pip.conf" "$PIP"

# Make a backup of the .starship.toml file if it exists then symlink it to dotfiles
STARSHIP="$HOME/.config/starship.toml"

if test -f "$STARSHIP"; then
  mv "$STARSHIP" "$STARSHIP.backup"
fi

ln -s "$HOME/dotfiles/starship/starship.toml" "$STARSHIP"

# Wezterm

WEZTERM=$HOME/.wezterm.lua

if test -f "$WEZTERM"; then
  mv "$WEZTERM" "$WEZTERM.backup"
fi

ln -s "$HOME/dotfiles/wezterm/wezterm.lua" "$WEZTERM"
