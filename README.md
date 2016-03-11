# Dotfiles

Some useful configurations for my development workflow

## Install

```sh
$ git clone --recursive https://github.com/Tonkpils/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ ./bootstrap.sh
```

If certain files are already in place it will ask to overwrite or back them up. Any file with extension `.symlink` will be linked to `$HOME` during the bootstrap process.

## Reminders

### Adding Vim Plugins

Plugins are managed through Vundle. The list of plugins can be found in `vim/vimrc`.

# TODO

- Setup SSH keys and add to Github and Heroku
- Install stuff
  - See for requirements https://github.com/suan/vim-instant-markdown
      - sudo chmod ugo-x /usr/libexec/path_helper
  - brew install git
      - sudo mv /usr/bin/git /usr/bin/git-apple

- mkdir -p ~/code/tonkpils
- Ensure custom themes are installed after oh-my-zsh
- Install RVM
  1. \curl -sSL https://get.rvm.io | bash -s -- --autolibs=read-fail
  2. rvm autolibs enable
  3. rvm get stable
  4. rvm install ruby --disable-binary

