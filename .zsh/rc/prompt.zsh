#
# ZSHELL prompt
#

# Turns on command substitution in the prompt (and parameter expansion and arithmetic expansion).
setopt prompt_subst

# RedHat prompt theme
#autoload -U promptinit && promptinit
#prompt redhat

# load the colors
autoload -U colors && colors

# Git stuff
function prompt_char {
  git branch >/dev/null 2>/dev/null && echo '±' && return
  hg root >/dev/null 2>/dev/null && echo '☿' && return
  echo '$'
}

function git_branch {
  BRANCH="$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)"
  if ! test -z $BRANCH; then
    COL="%{$fg[green]%}" # Everything's fine
    [[ $(git log origin/master..HEAD 2> /dev/null ) != "" ]] && COL="%{$fg[red]%}" # We have changes to push
    [[ $(git status --porcelain 2> /dev/null) != "" ]] && COL="%{$fg[yellow]%}" # We have uncommited changes
    echo "%{$fg[green]%}(%{$fg[cyan]%}$(prompt_char) $COL$BRANCH%{$fg[green]%})"
  fi
}

PROMPT='$(git_branch)%{$fg[green]%}(%~)%{$reset_color%}%# '
RPROMPT="%(?,%{$fg[green]%}:%),%{$fg[yellow]%}%? %{$fg[red]%}:()%f"
SPROMPT="Correct %{$fg[red]%}%R to %{$fg[green]%}%r?%{$reset_color%} ([%{$fg[green]%}Y%{$reset_color%}]es/[%{$fg[red]%}N%{$reset_color%}]o/[%{$fg[yellow]%}E%{$reset_color%}]dit/[%{$fg[red]%}A%{$reset_color%}]bort) "
