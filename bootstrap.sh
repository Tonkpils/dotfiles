#!/usr/bin/env bash

cd $(dirname "${BASH_SOURCE}");

if [ ! -f $HOME/.env_vars ]; then
  echo "=== Creating ~/.env_vars ==="
  echo "# Exported environment variables in this file will be automatically loaded" >> $HOME/.env_vars
fi

## Install homebrew
if  test ! $(which brew); then
  echo "=== Installing Homebrew ==="
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


echo "=== Checking brew bundle ==="
brew bundle check &> /dev/null
if [ -z $? ]
then
  echo "=== Brews already installed ==="
else
  echo "=== Installing brew bundle ==="
  brew bundle install
fi

WORKDIR=$(pwd)

git pull origin master;

## Install Symlinks
echo "- Installing symlinks"
for src in $(find -H "$WORKDIR" -maxdepth 2 -name '*.symlink'); do
  echo $src
  dst="$HOME/.$(basename "${src%.*}")"
  ln -s "$src" "$dst"
  echo "success linking $src to $dst"
done

## Setup vim
echo "- Installing vim stuffs...."
echo "$WORKDIR/vim/vimrc"
ln -sf "$WORKDIR/vim/vimrc" "$HOME/.vimrc"
echo "- Linking vim directory"
ln -sfh "$WORKDIR/vim/" "$HOME/.vim"

## Setup Tmux
mkdir -p $HOME/.tmux/plugins/
rm -rf $HOME/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My ZSH found at ~/.oh-my-zsh"
else
  echo "=== Installing Oh My Zsh ==="
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

mkdir -p "$HOME/.oh-my-zsh/custom/themes"
ln -s "$WORKDIR/oh-my-zsh/custom/tonkpils.zsh-theme" "$HOME/.oh-my-zsh/custom/themes"
