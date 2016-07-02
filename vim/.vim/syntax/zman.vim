" This is a syntax file to fold zman.md, which documents all the functions
" I've made in bash
"
" Folding via syntax is used for this filetype
setlocal foldmethod=expr
setlocal foldexpr=GetZmanFoldLevel(v:lnum)

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
function! GetZmanFoldLevel(lnum)
    if getline(a:lnum) =~? '\v^\s*$'
        return '-1'
    elseif getline(a:lnum) =~? '\v^## .*$'
        return '1'
    elseif getline(a:lnum) =~? '\v^### .*$'
        return '2'
    elseif getline(a:lnum) =~? '\v^endmodule$'
        return '0'
    elseif getline(a:lnum) =~? '\v^end.*$'
        return '2'
    elseif getline(a:lnum) =~? '\v^\.$'
        return '1'
    elseif getline(a:lnum) =~? '^.*$'
        return '-1'
    endif
endfunction
