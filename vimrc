set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

set clipboard=unnamedplus
set expandtab
set mouse=n
set ttymouse=xterm2
set swapfile
set dir=~/Limbo
set pastetoggle=<F2>

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Mappings
" Remap control-w-j moves to control-j
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

let python_highlight_all=1
syntax on

set nu


" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" Plugin 'vim-syntastic/syntastic'
Plugin 'jnurmine/Zenburn'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'ajmwagar/vim-deus'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-unimpaired'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-obsession'
Plugin 'mattn/emmet-vim'
Plugin 'jcherven/jummidark.vim'
Plugin 'vim-airline/vim-airline-themes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1 
let g:syntastic_check_on_wq = 1
let g:syntastic_python_pylint_args = '--load-plugins pylint_django'
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['python']

set runtimepath+=~/vim-airline
let g:airline_theme = 'cobalt2'
let g:airline_powerline_fonts = 1

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=120 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

au BufNewFile,BufRead *.sh
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=200 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

syntax enable
colorscheme jummidark
