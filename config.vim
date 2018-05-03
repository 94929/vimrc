" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" PLUGIN
"" NERDTree
let NERDTreeAutoDeleteBuffer=1
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

""" Open a NERDTree automatically when vim starts up if no files were specified.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

""" Close vim if the only window left open is a NERDTree.
autocmd bufenter * 
    \ if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) 
    \ | q | endif

" KEY MAPPING
map <C-n> :NERDTreeToggle<CR>

" INDENT
set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

autocmd FileType sh setlocal shiftwidth=2 tabstop=2 softtabstop=4

" VIEW
set number
set ruler
set title
set wrap
set linebreak
set showmatch
set showcmd

" SEARCH
set incsearch
set hlsearch

" BACKUP
set noswapfile

set backupdir=./.backup,.,/tmp
set directory=.,./.backup,/tmp

" COLOR
set colorcolumn=80

syntax on
syntax enable

colorscheme desert

