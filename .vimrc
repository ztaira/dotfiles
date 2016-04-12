"
" $$$$$$$$\      $$\    $$\ $$\ 
" \____$$  |     $$ |   $$ |\__|              
"     $$  /      $$ |   $$ |$$\ $$$$$$\$$$$\  
"    $$  /$$$$$$\\$$\  $$  |$$ |$$  _$$  _$$\ 
"   $$  / \______|\$$\$$  / $$ |$$ / $$ / $$ |
"  $$  /           \$$$  /  $$ |$$ | $$ | $$ |
" $$$$$$$$\         \$  /   $$ |$$ | $$ | $$ |
" \________|         \_/    \__|\__| \__| \__| by Zach Taira
"
" ============================================================================
" INDEX 
" ============================================================================
" 0) Index
" 1) Default Settings
" 2) Plugins
" 3) Mappings
" 4) Useful Functions

" ============================================================================
" DEFAULT SETTINGS
" ============================================================================
" Color scheme
colo zachscheme
syntax on
" Set the cursor lines to be on
set cursorline cursorcolumn colorcolumn=80
set list lcs=tab:\|\ 
" Set line numbers on
set number
" Set search options
set incsearch ignorecase smartcase
" Fix compatilility issues
set nocompatible
" Mouse
set mouse=a
" Tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" Status Line
set laststatus=2
set statusline=%-15.F\ %-15.([b%n]%y%m%)[%l,\ %c]

" ============================================================================
" PLUGINS
" ============================================================================
" plugins - call :source % then :PlugInstall to update
call plug#begin('~/.vim/plugged')
	" file directory plugin
	Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
	" plugin for managing brackets
	Plug 'tpope/vim-surround'
	" plugin for spacing
	Plug 'godlygeek/tabular'
call plug#end()

" ============================================================================
" MAPPINGS - normal maps, insert maps, and visual maps
" ============================================================================
let mapleader = ' '
" NORMAL MAPS
"
" Plugin mappings - for making plugins easier
" NerdTree
nnoremap <leader>nt :NERDTreeToggle<cr>

" Text manipulation mappings - for manipulating text
" Python Comment
nnoremap <leader>pc :execute "normal! ^c$# \ep\r"<cr>
" C Comment
nnoremap <leader>cc :execute "normal! ^c$// \ep\r"<cr>
" Move Line Down
nnoremap <leader>ld :call MoveLinesDown(1)<cr>
" Move Line Up
nnoremap <leader>lu :call MoveLinesUp(1)<cr>
" Move 2 lines down
nnoremap <leader>2ld :call MoveLinesDown(2)<cr>
" Move 2 lines up
nnoremap <leader>2lu :call MoveLinesUp(2)<cr>
" Insert newline above
nnoremap <leader>O :execute "normal! O\ej"<cr>
" Insert newline below
nnoremap <leader>o :execute "normal! o\ek"<cr>
" Move word to the next line (Could use refining)
nnoremap <leader>wd :execute "normal! $b\"acE\e\r\"bc$\e\"apa \e\"bpk0"<cr>
" Move word to the previous line (Could use refining)
nnoremap <leader>wu :execute "normal! k\r\"acE\exk$a \e\"apj0"<cr>

" File Manipulation mappings 
" (for opening, closing, saving, compiling, and running files) 
" Open New File
nnoremap <leader>nf :vert new file.txt
" Save File
nnoremap <leader>sf :w<cr>
" Quit and write to file
nnoremap <leader>q :wq<cr>
" Quit but don't write to file
nnoremap <leader>qq :q!<cr>
" Print current directory
nnoremap <leader>pwd :pwd<cr>
" Change to file directory
nnoremap <leader>cd :cd %:p:h<cr>
" Change current window to file directory
nnoremap <leader>lcd :lcd %:p:h<cr>
" Compile C File
nnoremap <leader>cf :!gcc -o output %:t
" Run executable 
nnoremap <leader>re :!./output
" Run Python File
nnoremap <leader>rp :!python %:p<cr>
" Show All Buffers
nnoremap <leader>bf :buffers<cr>
" Add Buffer
nnoremap <leader>ba :badd
" Buffer Close
nnoremap <leader>bc :bd<cr>
" Save to my vim folder
nnoremap <leader>svim :w! /Users/zacharytaira/Desktop/10.4.15/School/2016S/Vim/%:t<cr>
" Show registers
nnoremap <leader>rg :registers<cr>

" Vim Mappings
" (mappings that help alter the current vim session)
" Number-relativeNumber
nnoremap <leader>nn :call NumberToggle()<cr>
" VIm preferences
nnoremap <leader>vi :vsplit $MYVIMRC<cr>
" Next Window
nnoremap <leader>nw <C-w><C-w>
" Easier colon
nnoremap ; :
" Access the command line?
nnoremap <leader>cl :!
" Make a new visual split with the next buffer
nnoremap <leader>vs :vertical botright sb<cr>
" Display invisible characters
nnoremap <leader>li :set list! listchars=eol:$,tab:\<bar>\<space>,trail:~
" Set expandtab
nnoremap <leader>et :set expandtab!

" VISUAL MAPS
" Move variable amount of lines down and reselect in visual mode
vnoremap <leader>ld : <bar> call VMoveLinesDown()<cr><cr>
" Move variable amount of lines up and reselect in visual mode
vnoremap <leader>lu : <bar> call VMoveLinesUp()<cr><cr>

" INSERT MAPS
" (none)

" ============================================================================
" USEFUL FUNCTIONS
" ============================================================================
" function to toggle :set number and :set relativenumber
function! NumberToggle()
	if &number
		set relativenumber
	else
		set number
	endif
endfunction

" Function to move a variable amount of lines down 1 line
function! MoveLinesDown(lines)
	execute "normal! \"a" . a:lines . "dddd\"aPPj" 
endfunction

" Function to move a variable amount of lines up 1 line
function! MoveLinesUp(lines)
	execute "normal! \"a" . a:lines . "ddkP"
endfunction

" Function to move multiple lines down in visual mode
function! VMoveLinesDown()
	let front = line("'<")
	let back = line("'>")
	execute "normal! " . back . "Gjdd" . front . "GPgv"
endfunction

" Function to move multiple lines up in visual mode
function! VMoveLinesUp()
	let front = line("'<")
	let back = line("'>")
	execute "normal! " . front . "Gkdd" . back . "GPgv"
endfunction
