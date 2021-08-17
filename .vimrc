set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4

set softtabstop=4   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces

set mouse=a "allow to scrooll in vim using tmux"
syntax enable
set autoindent
set showmatch
set shell=/bin/bash

set number
set relativenumber


map <F3> :set invpaste paste?<CR>:%s/\s\+$//g<CR>
map <C-d> :w !git diff % -<CR>
map <C-b> :NERDTreeToggle<CR>

cmap w!! w !sudo tee > /dev/null %

filetype off

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Folder / file tree
Plug 'preservim/nerdtree'
" Git tools
Plug 'tpope/vim-fugitive'
" Theme
Plug 'joshdick/onedark.vim', { 'branch': 'main' }
" quoting / parenthesizing made simple
Plug 'tpope/vim-surround'
" Syntax checking hacks for vim
Plug 'scrooloose/syntastic'
" Rust
Plug 'rust-lang/rust.vim'
" Python
Plug 'davidhalter/jedi-vim'
Plug 'nvie/vim-flake8'
Plug 'psf/black', { 'branch': 'main' }

" Generic
Plug 'valloric/youcompleteme'
Plug 'ervandew/supertab'
Plug 'w0rp/ale'

call plug#end()

syntax enable
filetype plugin indent on
colorscheme onedark

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

