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

# TODO
Make this more agnostic to me...

- Install docker toolbox
- Install brew-cask
  1. brew install caskroom/cask/brew-cask
- Install google-chrome
  1. brew cask install google-chrome
- Install boot2docker
  1. brew install boot2docker
  2. brew cask install virtualbox
  3. boot2docker init
- Install stuff
  - See for requirements https://github.com/suan/vim-instant-markdown
      - sudo chmod ugo-x /usr/libexec/path_helper
  - brew install git
      - sudo mv /usr/bin/git /usr/bin/git-apple
  - brew install gh
  - brew install mercurial
  - brew install redis
  - brew install postgres
  - brew install mongo
  - brew install elixir
  - brew install rust
  - brew install go
  - brew install erlang
  - brew install imagemagick

- mkdir -p ~/code/tonkpils
- mkdir -p ~/work/cloud
- Ensure custom themes are installed after oh-my-zsh
- Only load .env_vars if the file exists
  1. Maybe create .env_vars with instructions?
- Install RVM
  1. \curl -sSL https://get.rvm.io | bash -s -- --autolibs=read-fail
  2. rvm autolibs enable
  3. rvm get stable
  4. rvm install ruby --disable-binary

