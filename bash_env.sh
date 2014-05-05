#!/bin/bash
MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Set up the prompt the way I like.
PROMPT_FMT="\u@\h \w"
if [ $(type -P "git") ]; then
  # Include git-aware stuff, if git is available
  export GITAWAREPROMPT=$MYDIR/git-aware-prompt
  source $GITAWAREPROMPT/main.sh
  PROMPT_FMT="$PROMPT_FMT \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]"
fi
export PS1="$PROMPT_FMT\$ "
