" This is a syntax file to fold my notes, which I'm assuming are written
" in markdown. 
"
" Folding via syntax is used for this filetype
setlocal foldmethod=expr
setlocal foldexpr=GetNotesFoldLevel(v:lnum)

" Vim's command window ('q:') and the :options window also set filetype=vim.
" We do not want folding in these enabled by default, though, because some
" malformed :if, :function, ... commands would fold away everything from the
" malformed command until the last command.
if bufname('') =~# '^\%(' . (v:version < 702 ? 'command-line' : '\[Command Line\]') . '\|option-window\)$'
" With this, folding can still be enabled easily via any zm, zc, zi, ...
" command.
    setlocal nofoldenable
else
" Fold settings for ordinary windows.
    setlocal foldcolumn=3
endif

" Function to set vim folds
function! GetNotesFoldLevel(lnum)
    if getline(a:lnum) =~? '\v^# .*$'
        return '0'
    elseif getline(a:lnum) =~? '\v^## .*$'
        return '1'
    elseif getline(a:lnum) =~? '\v^### .*$'
        return '2'
    elseif getline(a:lnum+1) =~? '\v^## .*$'
        return '0'
    elseif getline(a:lnum+1) =~? '\v^### .*$'
        return '1'
    elseif getline(a:lnum+2) =~? '\v^## .*$'
        return '1'
    elseif getline(a:lnum+2) =~? '\v^### .*$'
        return '2'
    elseif getline(a:lnum+1) =~? '\v^\s*$'
        return '2'
    elseif getline(a:lnum) =~? '\v^\s*$'
        return '-1'
    elseif getline(a:lnum) =~? '^.*$'
        return '-1'
    endif
endfunction

" Assuming notes are structured like this:
"0 # Title
"0 Description of title
"0
"1 ## Section
"2 ### Indented Section
"2 Stuff
"2 Stuff
"2 Stuff
"1
"2 ### Indented Section 2
"2 Stuff
"2 Stuff
"2 Stuff
"2
"0
"1 ## Section 2
"2 ### Indented Section 3
"2 Stuff
"1
"2 ### Indented Section 4
"2 Stuff
"2 Stuff
