# Dothory

Some useful configurations for my development workflow

## Install

```sh
$ git clone --recursive https://github.com/Tonkpils/dothory.git ~/.dotfiles
$ cd ~/.dotfiles
$ script/install
```

This will install homebrew, zsh, grc, as well as coreutils. If certain files are already in place it will ask to overwrite or back them up. Any file with extension `.symlink` will be linked to the `$HOME` path when running `rake install`.

## Reminders

### Adding Vim Plugins

Vim plugins are managed through pathogen. Any plugins will be stored under `vim/bundle`

```sh
$ cd ~/.dotfiles/vim/bundle
$ git submodule add my-awesome-plugin-repo.git
```

Plugins will be automatically loaded when vim starts.
