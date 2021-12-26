" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/seoul256.vim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" THEME
if (has("termguicolors"))
  set termguicolors
endif

" PLUGINS
let NERDTreeAutoDeleteBuffer=1
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeWinSize=32

""" Open NERDTree automatically when vim starts up if no files were specified.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc()==0 && !exists("s:std_in") | NERDTree | endif

""" Close vim if the only window left open is a NERDTree.
autocmd BufEnter * 
    \ if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) 
    \ | q | endif

"" 'airline'
set laststatus=2

"" Syntastic - python3
let g:syntastic_python_checkers = ['python3']

" KEY MAPPING
let mapleader=','

nnoremap <Leader>c :sp<CR>
nnoremap <Leader>v :vsp<CR>
nnoremap <Leader>l :noh<CR>
nnoremap <Leader>g :Goyo<CR>
nnoremap <Leader>n :NERDTreeToggle<CR>

" SPLIT OPTIONS
set splitbelow
set splitright

nmap j gj
nmap k gk

" INDENT
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
set smarttab
set autoindent

autocmd FileTYpe make setlocal noexpandtab

" VIEW
set number
set relativenumber
set ruler
set title
set wrap
set linebreak
set showmatch
set showcmd

" PERFORMANCE
set lazyredraw

" SEARCH
set hlsearch
set incsearch
set ignorecase
set smartcase

" BACKUP
set directory=~/.vim/swap//
set backupdir=~/.vim/backup//

" COLOR
syntax on
syntax enable

set t_Co=256
set colorcolumn=79

colorscheme seoul256

" AUTO-SET PASTE MODE
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" Enable backspace as a delete key
set backspace=indent,eol,start
