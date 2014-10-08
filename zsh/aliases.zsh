alias reload!='. ~/.zshrc'

# Easier nav
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Shortcuts
alias dcld="cd ~/work/cloud"
alias tonkpils="cd ~/code/tonkpils"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias mydotfiles="cd ~/.dotfiles"
alias gocode="cd $GOPATH/src"

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update!='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm update npm -g; npm update -g'
