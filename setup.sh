#!/usr/bin/env zsh

# Run this script to setup in a ubuntu machine / codespaces

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

sudo apt-get update -y
sudo apt-get -y install neovim
sudo apt-get -y install python-neovim
sudo apt-get -y install python3-neovim


WORKDIR=$(pwd)

## Install Symlinks
echo "- Installing symlinks"
for src in $(find -H "$WORKDIR" -maxdepth 2 -name '*.symlink'); do
  echo $src
  dst="$HOME/.$(basename "${src%.*}")"
  ln -sf "$src" "$dst"
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
