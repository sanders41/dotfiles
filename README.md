# Dotfiles

## How to use

Clone the repository to your home directory

```sh
git clone --depth 1 git@github.com:sanders41/dotfiles.git ~/dotfiles
```

Change to the dotfiles directory and run the provided shell script to symlink the files/directories.
If you already have dot files present they will be backed up before creating the symlinks.

```sh
cd dotfiles
sh symlink.sh
```

## For the neovim setup the following needs to be installed

### mason

[mason](https://github.com/williamboman/mason.nvim) is included in order to
manager lsp servers. `:Mason` will open a list of both available and installed servers.

### Telescope

For Telescope `live_view` to work ripgrep needs to be installed.

Mac

```sh
brew install ripgrep
```

Arch

```sh
sudo pacman -S ripgrep
```

### Install luajit

Mac

```sh
brew install luajit
```

Arch

```sh
sudo pacman -S luajit
```

### Lua language server

Mac

```sh
brew install lua-language-server
```

Arch

```sh
sudo pacman -S lua-language-server
```

### Luarocks

Mac

```sh
brew install Luarocks
```

Arch

```sh
sudo pacman -S Luarocks
```

### Install plugins for neovim

Open neovim

```sh
nvim
```

## ZSH

- Install zsh-autosuggestions:

```sh
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

- Install zsh-syntax-highlighting

```sh
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

- Install zsh-you-should-use

```sh
git clone --depth=1 https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
```

## pip

Configure pip to require a virtual environment

## just treesitter

Open vim and run `TSInstall just`

## Ruff LSP

Install the LSP servers

```sh
pipx isntall ruff-lsp
```

## McFly

Mac

```sh
brew install mcfly
```

Arch

```sh
sudo pacman -S mcfly
```
