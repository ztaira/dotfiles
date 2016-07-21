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
set mouse=
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
set noswapfile
set cryptmethod=blowfish
set nobackup
"
" Vim folding autocommands
autocmd VimEnter zman.md :source ~/.vim/syntax/zman.vim
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
nnoremap <leader>pc :call EasyLineComment('# ')<cr>
" C Comment
nnoremap <leader>cc :call EasyLineComment('//')<cr>
" Move Line Down
nnoremap <leader>ld :call MoveLinesDown(1)<cr>
" Move Line Up
nnoremap <leader>lu :call MoveLinesUp(1)<cr>
" Insert newline above
nnoremap <leader>O :execute "normal! O\e"<cr>
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
" Change current window to file directory
nnoremap <leader>cd :lcd %:p:h<cr>
" Compile C File
nnoremap <leader>cf :call CompileFile()<cr>
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

" function to do or undo python or c comments
function! EasyLineComment(...)
    execute "normal! ^"
    let l:commentsymbol=matchstr(getline('.'), '\%' . col('.') . 'c.')
    execute "normal! l"
    let l:commentsymbol2=matchstr(getline('.'), '\%' . col('.') . 'c.')
    let l:indicator=l:commentsymbol . l:commentsymbol2
    if l:indicator ==? a:1
        execute "normal! ^dw"
    elseif a:1 ==? "# "
        execute "normal! ^i# \e"
    elseif a:1 ==? "//"
        execute "normal! ^i// \e"
    endif
endfunction

" function to compile c files intelligently
function! CompileFile(...)
    let l:searchstring="grep '#include <ncurses.h>' " . expand('%:t')
    let l:hasncurses=system(l:searchstring)
    echom "Compiling with the following libraries:"
    if l:hasncurses==?''
        execute "!g++ -o output %:t"
        echom "none"
    else
        execute "!g++ -o output %:t -lncurses"
        echom "ncurses"
    endif
endfunction

" returns the line number of the given mark
function! GetMarkLine(...)
    let l:filter="cat ~/.viminfo |
                \ grep \"\\\'" . a:1 . " \\d* \\d* .*\" |
                \ sed -E \"s/\\\'" . a:1 . "  ([0-9]+)  ([0-9]+).*/\\1/\"" 
    let l:linenumber=system(l:filter)
    return l:linenumber
endfunction

" returns the column number of the given mark
function! GetMarkColumn(...)
    let l:filter="cat ~/.viminfo |
                \ grep \"\\\'" . a:1 . " \\d* \\d* .*\" |
                \ sed -E \"s/\\\'" . a:1 . "  ([0-9]+)  ([0-9]+).*/\\2/\"" 
    let l:linecolumn=system(l:filter)
    return l:linecolumn
endfunction

" Convert line to qwerty
function! QwertyLine()
    execute "normal! $mA^mB"
    execute "wv"
    let l:apos=GetMarkColumn('A')
    let l:bpos=GetMarkColumn('B')
    call QwertyLetter()
    while l:bpos<l:apos
        execute "normal! lmB"
        call QwertyLetter()
        let l:bpos=l:bpos+1
    endwhile
endfunction

" Convert line to dvorak
function! DvorakLine()
    execute "normal! $mA^mB"
    execute "wv"
    let l:apos=GetMarkColumn('A')
    let l:bpos=GetMarkColumn('B')
    call DvorakLetter()
    while l:bpos<l:apos
        execute "normal! lmB"
        call DvorakLetter()
        let l:bpos=l:bpos+1
    endwhile
endfunction

" Convert letter to qwerty
function! QwertyLetter()
    let l:currentcharacter=matchstr(getline('.'), '\%' . col('.') . 'c.')
    if l:currentcharacter==#"["
        execute "normal! s-\e"
    elseif l:currentcharacter==#"{"
        execute "normal! s_\e"
    elseif l:currentcharacter==#"]"
        execute "normal! s=\e"
    elseif l:currentcharacter==#"}"
        execute "normal! s+\e"
    elseif l:currentcharacter==#"'"
        execute "normal! sq\e"
    elseif l:currentcharacter==#"\""
        execute "normal! sQ\e"
    elseif l:currentcharacter==#","
        execute "normal! sw\e"
    elseif l:currentcharacter==#"<"
        execute "normal! sW\e"
    elseif l:currentcharacter==#"."
        execute "normal! se\e"
    elseif l:currentcharacter==#">"
        execute "normal! sE\e"
    elseif l:currentcharacter==#"p"
        execute "normal! sr\e"
    elseif l:currentcharacter==#"P"
        execute "normal! sR\e"
    elseif l:currentcharacter==#"y"
        execute "normal! st\e"
    elseif l:currentcharacter==#"Y"
        execute "normal! sT\e"
    elseif l:currentcharacter==#"f"
        execute "normal! sy\e"
    elseif l:currentcharacter==#"F"
        execute "normal! sY\e"
    elseif l:currentcharacter==#"g"
        execute "normal! su\e"
    elseif l:currentcharacter==#"G"
        execute "normal! sU\e"
    elseif l:currentcharacter==#"c"
        execute "normal! si\e"
    elseif l:currentcharacter==#"C"
        execute "normal! sI\e"
    elseif l:currentcharacter==#"r"
        execute "normal! so\e"
    elseif l:currentcharacter==#"R"
        execute "normal! sO\e"
    elseif l:currentcharacter==#"l"
        execute "normal! sp\e"
    elseif l:currentcharacter==#"L"
        execute "normal! sP\e"
    elseif l:currentcharacter==#"/"
        execute "normal! s[\e"
    elseif l:currentcharacter==#"?"
        execute "normal! s{\e"
    elseif l:currentcharacter==#"="
        execute "normal! s]\e"
    elseif l:currentcharacter==#"+"
        execute "normal! s}\e"
    elseif l:currentcharacter==#"\\"
        execute "normal! s\\\e"
    elseif l:currentcharacter==#"|"
        execute "normal! s|\e"
    elseif l:currentcharacter==#"a"
        execute "normal! sa\e"
    elseif l:currentcharacter==#"A"
        execute "normal! sA\e"
    elseif l:currentcharacter==#"o"
        execute "normal! ss\e"
    elseif l:currentcharacter==#"O"
        execute "normal! sS\e"
    elseif l:currentcharacter==#"e"
        execute "normal! sd\e"
    elseif l:currentcharacter==#"E"
        execute "normal! sD\e"
    elseif l:currentcharacter==#"u"
        execute "normal! sf\e"
    elseif l:currentcharacter==#"U"
        execute "normal! sF\e"
    elseif l:currentcharacter==#"i"
        execute "normal! sg\e"
    elseif l:currentcharacter==#"I"
        execute "normal! sG\e"
    elseif l:currentcharacter==#"d"
        execute "normal! sh\e"
    elseif l:currentcharacter==#"D"
        execute "normal! sH\e"
    elseif l:currentcharacter==#"h"
        execute "normal! sj\e"
    elseif l:currentcharacter==#"H"
        execute "normal! sJ\e"
    elseif l:currentcharacter==#"t"
        execute "normal! sk\e"
    elseif l:currentcharacter==#"T"
        execute "normal! sK\e"
    elseif l:currentcharacter==#"n"
        execute "normal! sl\e"
    elseif l:currentcharacter==#"N"
        execute "normal! sL\e"
    elseif l:currentcharacter==#"s"
        execute "normal! s;\e"
    elseif l:currentcharacter==#"S"
        execute "normal! s:\e"
    elseif l:currentcharacter==#"-"
        execute "normal! s'\e"
    elseif l:currentcharacter==#"_"
        execute "normal! s\"\e"
    elseif l:currentcharacter==#";"
        execute "normal! sz\e"
    elseif l:currentcharacter==#":"
        execute "normal! sZ\e"
    elseif l:currentcharacter==#"q"
        execute "normal! sx\e"
    elseif l:currentcharacter==#"Q"
        execute "normal! sX\e"
    elseif l:currentcharacter==#"j"
        execute "normal! sc\e"
    elseif l:currentcharacter==#"J"
        execute "normal! sC\e"
    elseif l:currentcharacter==#"k"
        execute "normal! sv\e"
    elseif l:currentcharacter==#"K"
        execute "normal! sV\e"
    elseif l:currentcharacter==#"x"
        execute "normal! sb\e"
    elseif l:currentcharacter==#"X"
        execute "normal! sB\e"
    elseif l:currentcharacter==#"b"
        execute "normal! sn\e"
    elseif l:currentcharacter==#"B"
        execute "normal! sN\e"
    elseif l:currentcharacter==#"m"
        execute "normal! sm\e"
    elseif l:currentcharacter==#"M"
        execute "normal! sM\e"
    elseif l:currentcharacter==#"w"
        execute "normal! s,\e"
    elseif l:currentcharacter==#"W"
        execute "normal! s<\e"
    elseif l:currentcharacter==#"v"
        execute "normal! s.\e"
    elseif l:currentcharacter==#"V"
        execute "normal! s>\e"
    elseif l:currentcharacter==#"z"
        execute "normal! s/\e"
    elseif l:currentcharacter==#"Z"
        execute "normal! s?\e"
    endif
endfunction 

" Convert letter to dvorak
function! DvorakLetter()
    let l:currentcharacter=matchstr(getline('.'), '\%' . col('.') . 'c.')
    if l:currentcharacter==#"-"
        execute "normal! s[\e"
    elseif l:currentcharacter==#"_"
        execute "normal! s{\e"
    elseif l:currentcharacter==#"="
        execute "normal! s]\e"
    elseif l:currentcharacter==#"+"
        execute "normal! s}\e"
    elseif l:currentcharacter==#"q"
        execute "normal! s'\e"
    elseif l:currentcharacter==#"Q"
        execute "normal! s\"\e"
    elseif l:currentcharacter==#"w"
        execute "normal! s,\e"
    elseif l:currentcharacter==#"W"
        execute "normal! s<\e"
    elseif l:currentcharacter==#"e"
        execute "normal! s.\e"
    elseif l:currentcharacter==#"E"
        execute "normal! s>\e"
    elseif l:currentcharacter==#"r"
        execute "normal! sp\e"
    elseif l:currentcharacter==#"R"
        execute "normal! sP\e"
    elseif l:currentcharacter==#"t"
        execute "normal! sy\e"
    elseif l:currentcharacter==#"T"
        execute "normal! sY\e"
    elseif l:currentcharacter==#"y"
        execute "normal! sf\e"
    elseif l:currentcharacter==#"Y"
        execute "normal! sF\e"
    elseif l:currentcharacter==#"u"
        execute "normal! sg\e"
    elseif l:currentcharacter==#"U"
        execute "normal! sG\e"
    elseif l:currentcharacter==#"i"
        execute "normal! sc\e"
    elseif l:currentcharacter==#"I"
        execute "normal! sC\e"
    elseif l:currentcharacter==#"o"
        execute "normal! sr\e"
    elseif l:currentcharacter==#"O"
        execute "normal! sR\e"
    elseif l:currentcharacter==#"p"
        execute "normal! sl\e"
    elseif l:currentcharacter==#"P"
        execute "normal! sL\e"
    elseif l:currentcharacter==#"["
        execute "normal! s/\e"
    elseif l:currentcharacter==#"{"
        execute "normal! s?\e"
    elseif l:currentcharacter==#"]"
        execute "normal! s=\e"
    elseif l:currentcharacter==#"}"
        execute "normal! s+\e"
    elseif l:currentcharacter==#"\\"
        execute "normal! s\\\e"
    elseif l:currentcharacter==#"|"
        execute "normal! s|\e"
    elseif l:currentcharacter==#"a"
        execute "normal! sa\e"
    elseif l:currentcharacter==#"A"
        execute "normal! sA\e"
    elseif l:currentcharacter==#"s"
        execute "normal! so\e"
    elseif l:currentcharacter==#"S"
        execute "normal! sO\e"
    elseif l:currentcharacter==#"d"
        execute "normal! se\e"
    elseif l:currentcharacter==#"D"
        execute "normal! sE\e"
    elseif l:currentcharacter==#"f"
        execute "normal! su\e"
    elseif l:currentcharacter==#"F"
        execute "normal! sU\e"
    elseif l:currentcharacter==#"g"
        execute "normal! si\e"
    elseif l:currentcharacter==#"G"
        execute "normal! sI\e"
    elseif l:currentcharacter==#"h"
        execute "normal! sd\e"
    elseif l:currentcharacter==#"H"
        execute "normal! sD\e"
    elseif l:currentcharacter==#"j"
        execute "normal! sh\e"
    elseif l:currentcharacter==#"J"
        execute "normal! sH\e"
    elseif l:currentcharacter==#"k"
        execute "normal! st\e"
    elseif l:currentcharacter==#"K"
        execute "normal! sT\e"
    elseif l:currentcharacter==#"l"
        execute "normal! sn\e"
    elseif l:currentcharacter==#"L"
        execute "normal! sN\e"
    elseif l:currentcharacter==#";"
        execute "normal! ss\e"
    elseif l:currentcharacter==#":"
        execute "normal! sS\e"
    elseif l:currentcharacter==#"'"
        execute "normal! s-\e"
    elseif l:currentcharacter==#"\""
        execute "normal! s_\e"
    elseif l:currentcharacter==#"z"
        execute "normal! s;\e"
    elseif l:currentcharacter==#"Z"
        execute "normal! s:\e"
    elseif l:currentcharacter==#"x"
        execute "normal! sq\e"
    elseif l:currentcharacter==#"X"
        execute "normal! sQ\e"
    elseif l:currentcharacter==#"c"
        execute "normal! sj\e"
    elseif l:currentcharacter==#"C"
        execute "normal! sJ\e"
    elseif l:currentcharacter==#"v"
        execute "normal! sk\e"
    elseif l:currentcharacter==#"V"
        execute "normal! sK\e"
    elseif l:currentcharacter==#"b"
        execute "normal! sx\e"
    elseif l:currentcharacter==#"B"
        execute "normal! sX\e"
    elseif l:currentcharacter==#"n"
        execute "normal! sb\e"
    elseif l:currentcharacter==#"N"
        execute "normal! sB\e"
    elseif l:currentcharacter==#"m"
        execute "normal! sm\e"
    elseif l:currentcharacter==#"M"
        execute "normal! sM\e"
    elseif l:currentcharacter==#","
        execute "normal! sw\e"
    elseif l:currentcharacter==#"<"
        execute "normal! sW\e"
    elseif l:currentcharacter==#"."
        execute "normal! sv\e"
    elseif l:currentcharacter==#">"
        execute "normal! sV\e"
    elseif l:currentcharacter==#"/"
        execute "normal! sz\e"
    elseif l:currentcharacter==#"?"
        execute "normal! sZ\e"
    endif
endfunction 
    
