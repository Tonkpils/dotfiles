# Tonkpils dotfiles

## dotfiles

My own dotfiles

## Requirements

I prefer using curl to get the current version of zsh and let the automatic installer do it's thing. So pretty much the only requirement is `curl` for now.

## Install

```sh 
git clone https://github.com/Tonkpils/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will install homebrew, zsh, grc, as well as coreutils. If certain files are already in place it will ask to overwrite or back them up. Any file with extension `.symlink` will be linked to the `$HOME` path when running `rake install`. 
