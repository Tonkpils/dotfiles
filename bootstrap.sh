#!/usr/bin/env bash

WORKDIR=$(dirname "${BASH_SOURCE}");
cd $WORKDIR;

## Install homebrew
if  test ! $(which brew); then
  echo "=== Installing Homebrew ==="
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

./$WORKDIR/brew.sh

# git pull origin master;

if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My ZSH found at ~/.oh-my-zsh"
else
  echo "=== Installing Oh My Zsh ==="
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

## Install Symlinks
echo "- Installing symlinks"
for src in $(find -H $WORKDIR -maxdepth 2 -name '*.symlink'); do
  dst="$HOME/.$(basename "${src%.*}")"
  ln -s "$src" "$dst"
  echo "success linking $src to $dst"
done

## Setup vim
echo "- Installing vim stuffs...."
ln -sf "$WORKDIR/vim/vimrc" "$HOME/.vimrc"
ln -sfh "$WORKDIR/vim" "$HOME/.vimrc"

