#!/bin/bash
RCDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function linkit {
  SRC=$1
  DEST=$2

  LNEXTRA=""
  if [ "$FORCE_INSTALL" != "" ]; then
    LNEXTRA="-f"
  fi

  LNCMD="ln $LNEXTRA -ns $SRC $DEST"

  bash -xc "$LNCMD"

  if [ $? -ne 0 ]; then
    echo "link failed! ($LNCMD): $?"
    return
  fi
}

linkit $RCDIR/.irbrc ~/.irbrc
linkit $RCDIR/.screenrc ~/.screenrc
linkit $RCDIR/.vim ~/.vim
linkit $RCDIR/.vimrc ~/.vimrc
linkit $RCDIR/.gvimrc ~/.gvimrc

if [ $(uname) = 'Darwin' ]; then
  linkit $RCDIR/.tmux-osx.conf ~/.tmux.conf
  linkit $RCDIR/.tmux.conf ~/.tmux-common.conf
else 
  linkit $RCDIR/.tmux.conf ~/.tmux.conf
fi

if ! grep -qe "^source $RCDIR/bash_env.sh$" ~/.bashrc; then
    echo "source $RCDIR/bash_env.sh" >> ~/.bashrc
fi
