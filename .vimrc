set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'preservim/nerdtree'
call vundle#end()            
filetype plugin indent on   

" Put your non-Plugin stuff after this line

set shell=/bin/bash
inoremap jk <ESC>
syntax on
set number
set tabstop=2
set shiftwidth=2
set expandtab
set ai
set ruler
set noswapfile
set hlsearch
set ignorecase
set incsearch
colorscheme peachpuff
highlight comment ctermfg=green

" NERDTree specifics
nnoremap Q :NERDTreeToggle<cr>

