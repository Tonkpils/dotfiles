#!/usr/bin/env zsh

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

cd $(dirname "${BASH_SOURCE}");

echo "- Fetching latest dotfiles"
git pull origin master;

echo "- Updating submodules"
git submodule update --init --recursive --remote --merge;

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
if [ $? -eq 0 ]
then
  echo "=== Brews already installed ==="
else
  echo "=== Installing brew bundle ==="
  echo "  Changing ownership of $(brew --prefix) to $(whoami)"
  sudo chown -R $(whoami) $(brew --prefix)/*
  echo "  Running brew bundle install"
  brew bundle install
fi

WORKDIR=$(pwd)

## Install Symlinks
echo "- Installing symlinks"
for src in $(find -H "$WORKDIR" -maxdepth 2 -name '*.symlink'); do
  echo $src
  dst="$HOME/.$(basename "${src%.*}")"
  ln -s "$src" "$dst"
  echo "success linking $src to $dst"
done

## Setup vim
echo "- Configuring editors (vim/neovim)"
echo "$WORKDIR/vim/vimrc"
ln -sf "$WORKDIR/vim/vimrc" "$HOME/.vimrc"
echo "-- Setting up vim"
ln -sfh "$WORKDIR/vim/" "$HOME/.vim"
echo "-- Setting up nvim"
mkdir -p "$HOME/.config"
ln -sfh "$WORKDIR/nvim/"  "$HOME/.config/"
echo "--- Installing python3 support"
pip3 install --user --upgrade neovim
echo "--- Installing ruby support"
gem install "neovim"

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

source $HOME/.zshrc
vim +PackUpdate +qall

mkdir -p "$HOME/.oh-my-zsh/custom/themes"
ln -s "$WORKDIR/oh-my-zsh/custom/tonkpils.zsh-theme" "$HOME/.oh-my-zsh/custom/themes"

git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

## Setup nvm for node management

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
