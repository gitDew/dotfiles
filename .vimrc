set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'preservim/nerdtree'
Plugin 'jiangmiao/auto-pairs'
Plugin 'joshdick/onedark.vim'
call vundle#end()            
filetype plugin indent on   

" Put your non-Plugin stuff after this line

if (has("termguicolors"))
  set termguicolors
endif
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

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
set splitright
set splitbelow
colorscheme onedark
hi Normal guibg=NONE ctermbg=NONE
set nowrap " do not automatically wrap on load
set formatoptions-=t " do not automatically wrap text when typing
highlight comment ctermfg=green

" NERDTree specifics
nnoremap Q :NERDTreeToggle<cr>
let NERDTreeMapOpenVSplit='v'
let NERDTreeMapOpenSplit='s'

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" CTRLP specifics
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'


