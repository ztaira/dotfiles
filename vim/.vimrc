" note: ibm version
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
" Set Shell
set shellcmdflag+=lic
" Color scheme
set t_Co=256
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
" Continuous update of current song makes vim laggy
" Therefore, that's only done on save
set laststatus=2
set statusline=
            \%-20.20F
            \%-20.20([b%n]%y%m%)
            \%-20.20([%l,\ %c]%)
autocmd BufWritePost * :call UpdateStatusline()
" Wrap
set nowrap
" Automatically open start.txt in a new window
" autocmd VimEnter * :badd ~/start.txt
" autocmd VimEnter * :vertical belowright sb start.txt
"
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
    " plugin for gitgutter
    Plug 'airblade/vim-gitgutter'
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
nnoremap <leader>O :execute "normal! O\e"<cr>
" Insert newline below
nnoremap <leader>o :execute "normal! o\ek"<cr>
" Move word to the next line (Could use refining)
nnoremap <leader>wd :execute "normal! $b\"acE\e\r\"bc$\e\"apa \e\"bpk0"<cr>
" Move word to the previous line (Could use refining)
nnoremap <leader>wu :execute "normal! k\r\"acE\exk$a \e\"apj0"<cr>
" Copy line to clipboard
nnoremap <C-c> :.!pbcopy

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
" Change current window to file directory
nnoremap <leader>cd :lcd %:p:h<cr>
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
" Next Buffer
nnoremap <leader>bn :bnext<cr>
" Previous Buffer
nnoremap <leader>nb :bprevious<cr>
" Show registers
nnoremap <leader>rg :registers<cr>
" Run through pylint
nnoremap <leader>pl :!pylint %:t<cr>
" Run through pep8
nnoremap <leader>p8 :!pep8 %:t<cr>
" Save to my vim folder
nnoremap <leader>svim :w! /Users/ztiara/Desktop/ResilientIBM/Code/dotfiles/vim/%:t<cr>
" Save to my bash folder
nnoremap <leader>sbash :w! /Users/ztiara/Desktop/ResilientIBM/Code/dotfiles/bash/%:t<cr>

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
nnoremap <leader>vs :vertical botright sbn<cr>
" Display invisible characters
nnoremap <leader>li :set list! listchars=eol:$,tab:\<bar>\<space>,trail:~
" Set expandtab
nnoremap <leader>et :set expandtab!

" Git Mappings
" (mappings that help with version control)
" Git Commit
nnoremap <leader>gc :!git commit -m
" Git Push
nnoremap <leader>gp :!git push
" Git Diff
nnoremap <leader>gd :!git diff
" Git Add
nnoremap <leader>ga :!git add

" VISUAL MAPS
" Move variable amount of lines down and reselect in visual mode
vnoremap <leader>ld : <bar> call VMoveLinesDown()<cr><cr>
" Move variable amount of lines up and reselect in visual mode
vnoremap <leader>lu : <bar> call VMoveLinesUp()<cr><cr>

" INSERT MAPS
" Make exiting insert mode easier and less strenuous
inoremap ii <Esc>
inoremap <Esc> don't press that key
" Add the ability to save from inside insert mode
inoremap <leader>sf <Esc>:w<cr>l

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

" Function to get current song playing on Spotify
function! GetCurrentSong()
    " Get the current song title and trim the \n
    let l:cname=system("osascript -e 'tell Application \"System Events\"\n
                \ if application process \"Spotify\" exists then\n
                \ tell application \"Spotify\" to name of 
                \ current track as string\n
                \ end if\n
                \ end tell'")
    let l:cname = l:cname[:-2] 
    " Get the current song's artist and trim the \n
    let l:cartist=system("osascript -e 'tell Application \"System Events\"\n
                \ if application process \"Spotify\" exists then\n
                \ tell application \"Spotify\" to artist of 
                \ current track as string\n
                \ end if\n
                \ end tell'")
    let l:cartist = l:cartist[:-2]
    " If there's no song, string=None. Else, string=Name-Artist
    if strlen(l:cname)==?0
        let l:cname="None"
    else
        let l:cname=l:cname . "-" . l:cartist
    endif
    return l:cname
endfunction

" function to update statusline
function! UpdateStatusline()
    let g:song=GetCurrentSong()
    set statusline=
                \%-20.20F
                \%-20.20([b%n]%y%m%)
                \%-20.20([%l,\ %c]%)
                \%-20.20{g:song}
endfunction

