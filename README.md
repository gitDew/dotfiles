This repository contains my currently used tmux and vim configuration files and a short script for quick setup on a new machine.

## How To Install
Clone from GitHub:

    git clone https://github.com/gitDew/dotfiles.git ~/dotfiles

### Linux

Run setup.sh:

    cd ~/dotfiles
    ./setup.sh

### Windows

Start Powershell as Admin:

To setup NeoVim:

    cd ~\AppData\Local\
    mkdir nvim
    cd nvim
    New-Item -Path init.vim -ItemType SymbolicLink -Value ~\dotfiles\.vimrc

To setup IdeaVim:

    cd ~
    New-Item -Path .ideavimrc -ItemType SymbolicLink -Value ~\dotfiles\.ideavimrc

Done!
