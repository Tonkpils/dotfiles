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

# Check if Neovim is already installed
if command -v nvim &> /dev/null; then
  echo "Neovim is already installed. Skipping installation."
else
  echo "Installing Neovim..."
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod u+x nvim.appimage
  ./nvim.appimage --appimage-extract
  ./squashfs-root/AppRun --version
  sudo mv squashfs-root /
  sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
  rm nvim.appimage
fi

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

mkdir -p "$HOME/.oh-my-zsh/custom/themes"
ln -s "$WORKDIR/oh-my-zsh/custom/tonkpils.zsh-theme" "$HOME/.oh-my-zsh/custom/themes"

git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm

sudo chsh -s "$(which zsh)" "$(whoami)"

source $HOME/.zshrc
nvim --headless -c 'call minpac#clean()' -c 'call minpac#update("", {"do": "quit"})' +qall

if [[ ! -z "$CODESPACES" ]]
then
  git config --file $HOME/.gitconfig --unset gpg.program
fi

# git clone https://github.com/powerline/fonts.git --depth=1
# cd fonts
# ./install.sh
# cd ..
# rm -rf fonts
