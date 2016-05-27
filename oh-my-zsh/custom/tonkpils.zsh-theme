if [ "$(whoami)" = "root" ]; then CARETCOLOR="red"; else CARETCOLOR="magenta"; fi

local return_code="%(?..%{$fg_bold[red]%}[%?]%{$reset_color%}"

PROMPT='%{$fg_bold[cyan]%}%n%{$reset_color%}%{$fg[magenta]%}👾 %{${fg_bold[green]}%}%~%{$reset_color%} $(git_prompt_info) %{${fg[$CARETCOLOR]}%}%# %{${reset_color}%}'
MODE_INDICATOR="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/} ${return_code}"
}

RPS1='$(vi_mode_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="[%{$fg_bold[magenta]%}%{$reset_color%}%{$fg_bold[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}]"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%} 💩 "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} 👻 "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[red]%} 🚀 "
