_activate_venv() {
  local d possible_venv
  possible_venv=(.venv venv)
  d=$PWD
  while [[ $d = *[!/]* ]]; do
    for f in ${possible_venv}; do
      if [[ -f $d/$f/bin/activate ]]; then
        source $d/$f/bin/activate
        return
      fi
    done
    d="$(dirname "$d")"
  done
}

_auto_venv() {
    if [[ $VIRTUAL_ENV && "$PWD" != "$(dirname $VIRTUAL_ENV)"* ]] ; then
        deactivate
    fi
    if [[ -z $VIRTUAL_ENV ]]; then
        _activate_venv
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd _auto_venv
_auto_venv
