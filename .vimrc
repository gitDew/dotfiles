set nocompatible
filetype off

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" Plugins go here
Plug 'ctrlpvim/ctrlp.vim'
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'alfredodeza/pytest.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'rose-pine/neovim', { 'as': 'rose-pine' }
call plug#end()


" Put your non-Plugin stuff after this line

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

set shell=/bin/bash
inoremap jk <ESC>

map <Space> <Leader>

" Make Y behave like C and D
nnoremap Y y$ 

" Moving text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap K :m .-2<CR>==
nnoremap J :m .+1<CR>==


" Move to window
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" Old J and K get remapped here 
nnoremap <C-j> J
nnoremap <C-k> K

" Bind Ctrl-V to Space + V to avoid confusion with pasting
nnoremap <leader>v <C-v>


"This unsets the 'last search pattern' register by hitting return
nnoremap <CR> :noh<CR>

" Navigate snake_case easier
set iskeyword-=_

" highlight the visual selection after pressing enter.
xnoremap <silent> <cr> "*y:silent! let searchTerm = '\V'.substitute(escape(@*, '\/'), "\n", '\\n', "g") <bar> let @/ = searchTerm <bar> echo '/'.@/ <bar> call histadd("search", searchTerm) <bar> set hls<cr>

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
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_open_new_file = 'r'

" pytest.vim specifics
nnoremap <leader>t <Esc>:Pytest project verbose<CR>
noremap <leader>f <Esc>:Pytest file verbose<CR>

" markdown syntax highlighting for files without an extension
au BufNewFile,BufRead * if &syntax == '' | set syntax=markdown | endif

" highlight TODO and FIXME
augroup myTodo
  autocmd!
  autocmd Syntax * syntax match myTodo /\v\_.<(TODO|FIXME).*/hs=s+1 containedin=.*Comment
augroup END

highlight link myTodo Todo

colorscheme rose-pine

" Disable spaces being added before the closing bracket
let g:AutoPairsMapSpace = 0


