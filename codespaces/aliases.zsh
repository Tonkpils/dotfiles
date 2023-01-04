cs() {
  if [[ $@ == "tmux" ]]; then
    command gh cs ssh -- -t 'tmux -CC new -A -s main'
  else
    command gh cs "$@"
  fi
}
