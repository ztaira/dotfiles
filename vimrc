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
" NerdTree
nnoremap <leader>nt :NERDTreeToggle<cr>
" Quit
nnoremap <leader>q :wq<cr>
" QuitQuit
nnoremap <leader>qq :q!<cr>
" Number-relativeNumber
nnoremap <leader>nn :call NumberToggle()<cr>
" VIm preferences
nnoremap <leader>vi :vsplit $MYVIMRC<cr>
" Buffer Close
nnoremap <leader>bc :bd<cr>
" Next Window
nnoremap <leader>nw <C-w><C-w>
" Python Comment
nnoremap <leader>pc :execute "normal! 0c$# \ep\r"<cr>
" C Comment
nnoremap <leader>cc :execute "normal! 0c$// \ep\r"<cr>
" Easier colon
nnoremap ; :
" Save File
nnoremap <leader>sf :w<cr>
" Buffers
nnoremap <leader>b :b
" Show All Buffers
nnoremap <leader>bf :buffers<cr>
" Move Line Down
nnoremap <leader>ld :execute "normal! 0\"ac$\ej0\"bc$\ek0\"bpj0\"ap0"<cr>
" Move Line Up
nnoremap <leader>lu :execute "normal! 0\"ac$\ek0\"bc$\ej0\"bpk0\"ap0"<cr>
" Insert newline above
nnoremap <leader>O :execute "normal! O\ej"<cr>
" Insert newline below
nnoremap <leader>o :execute "normal! o\ek"<cr>
" Show registers
nnoremap <leader>rg :registers<cr>
" Change to file directory
nnoremap <leader>cd :cd %:p:h
" Change current window to file directory
nnoremap <leader>lcd :lcd %:p:h
" Print current directory
nnoremap <leader>pwd :pwd
" Run current file
nnoremap <leader>rf :!%:p
" Access the command line?
nnoremap <leader>cl :!
" Move word to the next line
nnoremap <leader>wd :execute "normal! $bc$\e\rhpa\ek0"
" Move word to the previous line

" INSERT MAPS
" Easier escape
inoremap ueht <esc>

" VISUAL MAPS
" Easier escape
vnoremap ueht <esc> 

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
