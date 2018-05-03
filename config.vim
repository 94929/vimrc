" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
"Plug 'valloric/youcompleteme'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" PLUGIN
"" 'nerdtree'
let NERDTreeAutoDeleteBuffer=1
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

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

" KEY MAPPING
let mapleader=','

map <C-n> :NERDTreeToggle<CR>

" INDENT
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

autocmd FileType sh setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileTYpe make setlocal noexpandtab

" VIEW
set number
set ruler
set title
set wrap
set linebreak
set showmatch
set showcmd

" SEARCH
set hlsearch
set incsearch
set ignorecase

" BACKUP
set noswapfile

set backupdir=./.backup,.,/tmp
set directory=.,./.backup,/tmp

" COLOR
set colorcolumn=80

syntax on
syntax enable

colorscheme desert

