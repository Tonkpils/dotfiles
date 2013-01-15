alias reload!='. ~/.zshrc'

# Easier nav
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Shortcuts
alias dcloud="cd ~/work/cloud"
alias dplatform="cd ~/work/cloud/platform-auth"
alias ddeveloper="cd ~/work/cloud/developer"
alias tonkpils="cd ~/code/tonkpils"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias mydotfiles="cd ~/.dotfiles"
alias unboxed="cd ~/unboxedlabs"
alias soshial="cd ~/soshial"

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm update npm -g; npm update -g; sudo gem update'
