" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-syntastic/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/goyo.vim'
Plug 'joshdick/onedark.vim'

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
let g:airline_theme='onedark'
set laststatus=2

"" Syntastic - python3
let g:syntastic_python_checkers = ['python3']

" KEY MAPPING
let mapleader=','

nnoremap <Leader>l :noh<CR>
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

set t_Co=256
set colorcolumn=80

colorscheme onedark

" AUTO-SET PASTE MODE
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

