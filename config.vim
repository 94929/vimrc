" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'scrooloose/nerdtree'
Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" PLUGIN
"" NERDTree
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

"" Powerline
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
set laststatus=2
set t_Co=256

" KEY MAPPING
nmap <silent> <C-N> :NERDTreeToggle<CR>

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

