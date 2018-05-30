" Setting some decent VIM settings for programming
set ai                          " set auto-indenting on for programming
set showmatch                   " automatically show matching brackets. works like it does in bbedit.
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
set ruler                       " show the cursor position all the time
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set backspace=indent,eol,start  " make that backspace key work the way it should
set nocompatible                " vi compatible is LAME
set background=dark             " Use colours that work well on a dark background (Console is usually black)
set showmode                    " show the current mode
set clipboard=unnamed           " set clipboard to unnamed to access the system clipboard under windows
highlight ExtraWhitespace ctermbg=red
syntax on                       " turn syntax highlighting on by default

" Show EOL type and last modified timestamp, right after the filename
set statusline=%<%F%h%m%r\ [%{&ff}]\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P

"------------------------------------------------------------------------------
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    "Set UTF-8 as the default encoding for commit messages
    autocmd BufReadPre COMMIT_EDITMSG,git-rebase-todo setlocal fileencodings=utf-8

    "Remember the positions in files with some git-specific exceptions"
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$")
      \           && expand("%") !~ "COMMIT_EDITMSG"
      \           && expand("%") !~ "ADD_EDIT.patch"
      \           && expand("%") !~ "addp-hunk-edit.diff"
      \           && expand("%") !~ "git-rebase-todo" |
      \   exe "normal g`\"" |
      \ endif

      autocmd BufNewFile,BufRead *.patch set filetype=diff
      autocmd BufNewFile,BufRead *.diff set filetype=diff

      autocmd Syntax diff
      \ highlight WhiteSpaceEOL ctermbg=red |
      \ match WhiteSpaceEOL /\(^+.*\)\@<=\s\+$/

      autocmd Syntax gitcommit setlocal textwidth=74
endif " has("autocmd")




"------------------------------------"
"-----------MY PREFERENCES-----------"
"------------------------------------"

"------------------------------------"
"----------Vundle Plugins------------"
"------------------------------------"
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin('~/.vim/bundle/')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Bundle 'jistr/vim-nerdtree-tabs'
Plugin 'pangloss/vim-javascript'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'scrooloose/nerdtree'
"plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'flazz/vim-colorschemes'
Plugin 'ide'
Plugin 'tpope/vim-surround'
Plugin 'AlessandroYorba/Sierra'
Plugin 'vim-scripts/dbext.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-syntastic/syntastic'
Plugin 'mattn/goplayground-vim'
Plugin 'beigebrucewayne/min_solo'
Plugin 'ehamberg/vim-cute-python'

"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match /\s\+$/
au BufNewFile,BufRead *.py
      \ set tabstop=4 | 
      \ set softtabstop=4 | 
      \ set shiftwidth=4 | 
	  \ set expandtab | 
	  \ set autoindent | 
	  \ set fileformat=unix 

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap ; :





Plugin 'joshdick/onedark.vim'
call vundle#end() 

"------------------------------------"
"----------Built-In Settings---------"
"------------------------------------"
autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
set t_Co=256
set hlsearch 		"search highlight
set tabstop=4		"tab = 4 spaces
set cursorline  	"highlights current line
set number			"turns numbers on
let g:sierra_Twilight = 1
colorscheme onedark	"default color scheme
set splitright
set diffopt+=vertical
silent! set splitvertical
if v:errmsg != ''
  cabbrev split vert split
  cabbrev hsplit split
  cabbrev help vert help
  noremap <C-w>] :vert botright wincmd ]<CR>
  noremap <C-w><C-]> :vert botright wincmd ]<CR>
else
  cabbrev hsplit hor split
endif
"------------------------------------"
"--------------VIM Macros------------"
"------------------------------------"
nnoremap <F3> :set hlsearch!<CR>
"------------------------------------"
"----------Javascript Macros---------"
"------------------------------------"
map <leader>af i$scope. = function(){}<esc>i<CR><CR><esc>kkwwli
map <leader>ac i.controller('', function($scope){}<esc>i<CR><CR><esc>kki
map <leader>am ivar = angular.module('', ['ngRoute'])<CR><Tab>.config(function($routeProvider){}<esc>i<CR><CR><Tab><Tab><esc>ki<Tab><Tab>$routeProvider.when('/', {})<esc>hi<CR><Tab><Tab>templateURL: '//home',<CR>controller: '//nameYourController'<CR><esc>5k04li
		
map <leader>func ifunction (){}<esc>i<CR><CR><esc>kkwi
map <leader>v i<Tab>var  = ;<esc>bi
"this is a not a change
map <leader>f i<Tab>for (var i = 0; i < .length; i++) {}<esc>i<CR><CR><esc><esc>2k10wi

	
"------------------------------------"
"----------Javascript Folding--------"
"------------------------------------"
function! JSfold()
	let line = getline(v:lnum)
	if match(line,'^\s*function') > -1
		return ">1"
	elseif match(line, '^\s*\$scope.*function') > -1
		return ">1"
	else
		return"="
	endif
	return 1
endfunction
autocmd FileType text setlocal foldmethod=manual
autocmd FileType javascript setlocal foldmethod=expr foldexpr=JSfold()

hi link pyNiceOperator Operator

set conceallevel=1
set concealcursor=ni

autocmd Syntax * syn keyword lispFunc lambda conceal cchar=λ
autocmd Syntax * syn keyword Operator def conceal cchar=ƒ
autocmd Syntax * syn match Operator "=\@<!==\@!" conceal cchar=←
autocmd Syntax * syn match Operator "!=" conceal cchar=≠

autocmd Syntax * syn match Operator ":\n" conceal cchar=→

autocmd Syntax * syn keyword Operator return conceal cchar=◀
autocmd Syntax * syn keyword Operator for conceal cchar=∀
autocmd Syntax * syn keyword Operator range conceal cchar=ι

autocmd Syntax * syn keyword Operator if conceal cchar=»
autocmd Syntax * syn keyword Operator elif conceal cchar=›
autocmd Syntax * syn keyword Operator else conceal cchar=◇

autocmd Syntax * syn keyword Operator None conceal cchar=ø


autocmd Syntax * syn match Keyword "\<x\>" conceal cchar=𝒳
autocmd Syntax * syn match Keyword "\<y\>" conceal cchar=𝒴
autocmd Syntax * syn match Keyword "\<z\>" conceal cchar=𝒵

autocmd Syntax * syn keyword Operator self conceal cchar=♀
autocmd Syntax * syn keyword Operator this conceal cchar=♀

autocmd Syntax * syn keyword Statement True conceal cchar=Ṫ
autocmd Syntax * syn keyword Statement False conceal cchar=Ḟ

autocmd Syntax * syn keyword Statement len conceal cchar=#
autocmd Syntax * syn keyword Statement print conceal cchar=ρ












