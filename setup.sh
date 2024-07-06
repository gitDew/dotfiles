#!/bin/bash
dotfilesDir=$(pwd)

sudo apt install curl
sudo apt install neovim

mkdir -p ~/.config/nvim/
ln -s ${dotfilesDir}/.vimrc ~/.config/nvim/init.vim

nvim +PlugInstall +qall
