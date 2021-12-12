# Dotfiles

## How to use

Clone the repository to your home directory

```sh
cd ~
git clone git@github.com:sanders41/dotfiles.git
```

Change to the dotfiles directory and run the provided shell script to symlink the files/directories.
If you already have dot files present they will be backed up before creating the symlinks.

```sh
cd dotfiles
sh symlink.sh
```

## For the neovim setup the following needs to be installed

### NPM packages:

```sh
npm i -g @tailwindcss/language-server@0.0.5 diagnostic-languageserver@1.14.1 pyright@1.1.195 typescript-language-server@0.8.1 typescript@4.5.3 vls@0.7.6
```

### rust-analyzer

Manjaro/Arch

```sh
sudo pacman -S rust-analyzer
```

macOS

```sh
brew install rust-analyzer
```

Ubuntu

```sh
curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer
```

For Ubuntu make sure ~/.local/bin is on the path

### Install packer

```sh
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
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

  macOS

  ```sh
  brew install pyenv
  ```

  Linux

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
pipx install weather-command
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
