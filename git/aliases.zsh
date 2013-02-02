# use `hub` as our git wrapper:
# http://defunkt.github.com/hub/
hub_path=$(which hub)
if [[ -f $hub_path ]]
then
  alias git=$hub_path
fi


# Git aliases
alias gb='git branch'
alias gd='git diff'
alias gc='git commit'
alias gca='git commit -a'
alias gk='gitk --all 2> /dev/null &'
