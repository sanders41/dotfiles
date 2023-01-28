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

[mson](https://github.com/williamboman/mason.nvim) is included in order to
manager lsp servers. `:Mason` will open a list of both available and installed servers.

### Telescope

For Telescope `live_view` to work ripgrep needs to be installed.

Mac

```sh
brew install ripgrep
```

Manjaro/Arch

```sh
sudo pacman -S ripgrep
```

### Install packer

```sh
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

### Install luajit

Mac

```sh
brew install luajit
```

Manjaro/Arch

```sh
sudo pacman -S luajit
```

### Lua language server

Mac

```sh
brew install lua-language-server
```

Manjaro/Arch

```sh
sudo pacman -S lua-language-server
```

### Luarocks

Mac

```sh
brew install Luarocks
```

Manjaro/Arch

```sh
sudo pacman -S Luarocks
```

### Install plugins for neovim

Open neovim

```sh
nvim
```

Then install plugins with Packer

```sh
:PackerInstall
```


## ZSH

- Install powerlevel10k

  ```sh
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  ```

- Install pyenv

  ```sh
   git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  ```

- Install pipx with instructions [here](https://github.com/pypa/pipx)
- Install poetry

  ```sh
  curl -sSL https://install.python-poetry.org/install-poetry.py | python3 -
  ```

## Weather

Install weather-command.

```sh
pipx install weather-command[uvloop]
```

Then update the zip in the `we`, `weh`, `wed` commands to match the desired zip, or change
to using the city name. Example:

```sh
alias we="weather-command city seattle -i --am-pm"
```

To get metric units and 24 hour time remove the `-i` and `--am-pm`.

## Cookiecutter

Install cookiecutter

```sh
pipx install cookiecutter
```

Then create the file `~/.cookiecutters/defaults.yaml` file with your desired defaults. An example
can be found [here](https://cookiecutter.readthedocs.io/en/1.7.0/advanced/user_config.html)
