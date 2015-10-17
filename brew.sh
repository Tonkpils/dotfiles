#!/usr/bin/env bash

sudo -v

# while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "- Installing cask"
brew install caskroom/cask/brew-cask

brew update && brew cask update

brew cask install java
brew cask install slack
brew cask install iterm2
brew cask install google-chrome
# TODO: install dockertoolbox and setup
brew cask install dockertoolbox

## Upgrade any already-installed formulae.
brew upgrade --all

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
# Install Bash 4.
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash
brew tap homebrew/versions
brew install bash-completion2

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/screen

# Install some CTF tools; see https://github.com/ctfs/write-ups.
# requires Java
brew install aircrack-ng
brew install bfg
brew install binutils
brew install binwalk
brew install cifer
brew install dex2jar
brew install dns2tcp
brew install fcrackzip
brew install foremost
brew install hashpump
brew install hydra
brew install john
brew install knock
brew install netpbm
brew install nmap
brew install pngcheck
brew install socat
brew install sqlmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace
brew install ucspi-tcp # `tcpserver` etc.
brew install xz

# Install other useful binaries.
brew install ack
brew install git
brew install git-lfs
brew install imagemagick --with-webp
brew install pv
brew install speedtest_cli
brew install ssh-copy-id
brew install tree
brew install webkit2png
brew install hub
brew install mercurial

# Development languages
brew install lua
brew install rust
brew install go
brew install node

# Development utilities
brew install redis
brew install postgres
brew install elasticsearch

# Remote pairing
brew tap nviennot/tmate && brew install tmate

# Remove outdated versions from the cellar.
brew cleanup
