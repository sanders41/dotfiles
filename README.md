# Dotfiles

## How to use

Clone the repository to your home directory

```sh
cd ~
git clone git@github.com:sanders41/dotfiles.git
```

Change to the dotfiles directory and run the provided shell script to symlink the files/directories

```sh
cd dotfiles
sh symlink.sh
```

## For the neovim setup the following needs to be installed

### NPM packages:

```sh
npm i -g @tailwindcss/language-server@0.0.5 diagnostic-languageserver@1.14.1 pyright@1.1.195 typescript-language-server@0.8.1 typescript@4.5.3 vls@0.7.6
```

### rust-analyzer:

Manjaro/Arch:

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

### Install plugins for neovim

Open neovim

```sh
nvim
```

Then install plugins with Packer

```sh
:PackerInstall
```
