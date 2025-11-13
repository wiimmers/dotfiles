_title() {
  emulate -L zsh
  local root rel
  rel=${PWD##*/}
  [[ -z $rel ]] && rel="/"
  print -r -- "$rel"
}

_set_title() {
  emulate -L zsh
  local t="$(_title)"
  print -Pn $'\e]0;'"$t"$'\a'              # OSC 0: set icon+window title
}

precmd() { _set_title }                    # before each prompt

preexec() {                                # while a command runs
  emulate -L zsh
  local cmd=${1%% *}
  if [[ $cmd == zsh || -z $cmd ]]; then
    _set_title
  else
    print -Pn $'\e]0;'"${1} $(_title)"$'\a'
  fi
}
