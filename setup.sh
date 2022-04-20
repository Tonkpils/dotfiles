#!/usr/bin/env zsh

# Run this script to setup in a ubuntu machine / codespaces

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

git pull origin master
git submodule update --init --recursive --remote --merge

sudo apt-get update -y
sudo apt-get -y install zsh
sudo apt-get -y install hub

# Install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mv squashfs-root /
ln -s /squashfs-root/AppRun /usr/bin/nvim

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

mkdir -p "$HOME/.dotfiles"
ln -sfn "$WORKDIR/zsh" "$HOME/.dotfiles/zsh"
ln -sfn "$WORKDIR/git" "$HOME/.dotfiles/git"
ln -sfn "$WORKDIR/go" "$HOME/.dotfiles/go"
ln -sfn "$WORKDIR/javascript" "$HOME/.dotfiles/javascript"
ln -sfn "$WORKDIR/nvim" "$HOME/.dotfiles/nvim"

echo "- Installing symlinks"
for src in $(find -H "$WORKDIR" -maxdepth 2 -name '*.symlink'); do
  dst="$HOME/.$(basename "${src%.*}")"
  ln -s "$src" "$dst"
  echo "success linking $src to $dst"
done

## Setup vim
echo "- Configuring editors (vim/neovim)"
echo "$WORKDIR/vim/vimrc"
ln -sf "$WORKDIR/vim/vimrc" "$HOME/.vimrc"
echo "-- Setting up vim"
ln -sfn "$WORKDIR/vim/" "$HOME/.vim"
echo "-- Setting up nvim"
mkdir -p "$HOME/.config"
ln -sfn "$WORKDIR/nvim/"  "$HOME/.config/"
echo "--- Installing python3 support"
pip3 install --user --upgrade neovim

if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My ZSH found at ~/.oh-my-zsh"
else
  echo "=== Installing Oh My Zsh ==="
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

sudo chsh -s "$(which zsh)" "$(whoami)"

source $HOME/.zshrc
vim +PackUpdate +qall

mkdir -p "$HOME/.oh-my-zsh/custom/themes"
ln -s "$WORKDIR/oh-my-zsh/custom/tonkpils.zsh-theme" "$HOME/.oh-my-zsh/custom/themes"

# git clone https://github.com/powerline/fonts.git --depth=1
# cd fonts
# ./install.sh
# cd ..
# rm -rf fonts
