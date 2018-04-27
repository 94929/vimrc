"INDENT
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4

"VIEW
set number
set ruler
set title
set wrap
set linebreak
set showmatch

"COLOR
syntax on
syntax enable

colorscheme desert

if exists('+colorcolumn')
	set colorcolumn=80
else
	au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

