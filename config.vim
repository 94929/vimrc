" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/seoul256.vim'
Plug 'valloric/youcompleteme'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" PLUGIN
"" 'nerdtree'
let NERDTreeAutoDeleteBuffer=1
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeWinSize=16

""" Open NERDTree automatically when vim starts up if no files were specified.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc()==0 && !exists("s:std_in") | NERDTree | endif

""" Close vim if the only window left open is a NERDTree.
autocmd BufEnter * 
    \ if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) 
    \ | q | endif

"" 'syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"" 'airline'
let g:airline_theme='hybrid'
set laststatus=2

"" 'youcompleteme'
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

" KEY MAPPING
let mapleader=','

nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>g :Goyo<CR>

" INDENT
filetype plugin indent on

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

autocmd FileTYpe make setlocal noexpandtab

" VIEW
set number
set ruler
set title
set wrap
set linebreak
set cursorline
set showmatch
set showcmd

" PERFORMANCE
set lazyredraw

" SEARCH
set hlsearch
set incsearch
set ignorecase

" BACKUP
set directory=~/.vim/swap//
set backupdir=~/.vim/backup//

" COLOR
syntax on
syntax enable

set colorcolumn=80

silent! colorscheme seoul256

