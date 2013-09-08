# Dothory

My awesome configuration for my Mac.

## Requirements

`curl`

## Install

```sh 
git clone --recursive https://github.com/Tonkpils/dothory.git ~/.dotfiles
cd ~/.dotfiles
script/install
```

This will install homebrew, zsh, grc, as well as coreutils. If certain files are already in place it will ask to overwrite or back them up. Any file with extension `.symlink` will be linked to the `$HOME` path when running `rake install`. 
