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

syntax enable
filetype plugin indent on

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

