#!/usr/bin/env zsh
thisdir="$( cd "$( dirname "$0" )" && pwd )"
ln -sf $thisdir/tmux.conf ~/.tmux.conf
ln -sf $thisdir/vim ~/.vim
ln -sf $thisdir/vimrc ~/.vimrc
ln -sf $thisdir/zshenv ~/.zshenv
ln -sf $thisdir/zshrc ~/.zshrc
ln -sf $thisdir/oh-my-zsh ~/.oh-my-zsh
ln -sf $thisdir/emacs.d ~/.emacs.d
ln -sf $thisdir/fortmux ~/.fortmux

