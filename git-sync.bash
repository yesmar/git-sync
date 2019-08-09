#!/bin/bash

# git-sync -- recursively update git repos in directory hierarchies
# Fri May 11 10:39:42 PDT 2018 yesmar@gmail.com

# Copyright © 2018 Ramsey Dow. All rights reserved.
# SPDX-License-Identifier: GPL-3.0

# shellcheck disable=SC2103,SC2154,SC2164

usage() {
  cat >&2 <<FOO

Usage: $script [-h] [path] …

  -h display this help text
  -n disable color output

git-sync Copyright © 2018 Ramsey Dow.

This program comes with ABSOLUTELY NO WARRANTY. This is
free software, and you are welcome to redistribute it
under certain conditions.

See https://www.gnu.org/licenses/gpl-3.0.en.html for details.

FOO
}

recurse() {
  for dir in "$@"; do
    [[ ! -d "$dir" ]] && continue # Skip anything that isn't a directory.
      cd -- "$dir"
      for f in *; do
        [[ ! -d "$f" ]] && continue
        if [[ -d "$f"/.git ]] && [[ ! -f "$f"/.skip ]]; then
          cd -- "$f"
          printf "%s%s%s ▶︎ " "$magenta" "$f" "$normal"
          git fetch &> /dev/null
          status=$?
          if ((status == 0)); then
            git merge
          else
            printf "%serror %s%s\\n" "$red" "$status" "$normal"
            ((errors++))
          fi
          cd ..
        else
          [[ ! -f "$f"/.skip ]] && recurse "$f"
        fi
      done
      cd ..
  done
}

script=$(basename "$0")
errors=0

while getopts ":hn" arg; do
  case "$arg" in
    h) # Display help text.
       usage
       exit 1
       ;;
    n) # Disable color output.
       colors=false
       shift
       ;;
    \?) # Invalid argument.
       printf >&2 "%s: invalid argument: -%s" "$script" "$OPTARG"
       exit 1
       ;;
  esac
done

# shellcheck source=/dev/null
[[ -z ${colors+x} ]] && [[ -f ~/.local/etc/colors ]] && . ~/.local/etc/colors

targets=("${@:-.}")
for path in "${targets[@]}"; do
  recurse "$path"
done

exit $errors
