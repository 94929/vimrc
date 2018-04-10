" VUNDLE
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" custom plugins
Plugin 'vim-airline/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdtree'
Plugin 'chrisbra/csv.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'

call vundle#end()            " required
filetype plugin indent on    " required

" INDENT
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4

" VIEW
set number
set ruler
set title
set wrap
set linebreak
set showmatch

" SEARCH
set nowrapscan
set hlsearch
set ignorecase
set incsearch

" EDIT

" COLOR
syntax on
syntax enable

