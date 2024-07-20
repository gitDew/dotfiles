#!/bin/bash
dotfilesDir=$(pwd)

ln -s ${dotfilesDir}/.vimrc "${HOME}/.vimrc"
mkdir -p ${HOME}/.config/nvim/ && ln -s ${dotfilesDir}/.vimrc "${HOME}/.config/nvim/init.vim"
ln -s ${dotfilesDir}/.tmux.conf "${HOME}/.tmux.conf"
nvim +PlugInstall +qall
