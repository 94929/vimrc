" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-sensible'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" INDENT
set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
"set softtabstop=4

autocmd FileType sh setlocal shiftwidth=2 tabstop=2

" VIEW
set number
set ruler
set title
set wrap
set linebreak
set showmatch

" SEARCH
set incsearch
set hlsearch

" BACKUP
set backupdir=./.backup,.,/tmp
set directory=.,./.backup,/tmp

" COLOR
set colorcolumn=80

syntax on
syntax enable

colorscheme desert

