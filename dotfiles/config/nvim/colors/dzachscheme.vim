" Vim color file
" Maintainer:	Zach Taira
" Last Change:	5/16/2016
" Modified color scheme - original by Bram Moolenaar <Bram@vim.org>

" This is the default color scheme.  It doesn't define the Normal
" highlighting, it uses whatever the colors used to be.

" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
hi clear Normal
set background=dark

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "dzachscheme"


" Helper functions =============================================================

" Execute the 'highlight' command with a List of arguments.
function! s:Highlight(args)
  exec 'highlight ' . join(a:args, ' ')
endfunction

function! s:AddGroundValues(accumulator, ground, color)
  let new_list = a:accumulator
  for [where, value] in items(a:color)
    call add(new_list, where . a:ground . '=' . value)
  endfor

  return new_list
endfunction

function! s:Col(group, fg_name, ...)
  " ... = optional bg_name

  let pieces = [a:group]

  if a:fg_name !=# ''
    let pieces = s:AddGroundValues(pieces, 'fg', s:colors[a:fg_name])
  endif

  if a:0 > 0 && a:1 !=# ''
    let pieces = s:AddGroundValues(pieces, 'bg', s:colors[a:1])
  endif

  call s:Clear(a:group)
  call s:Highlight(pieces)
endfunction

function! s:Attr(group, attr)
  let l:attrs = [a:group, 'term=' . a:attr, 'cterm=' . a:attr, 'gui=' . a:attr]
  call s:Highlight(l:attrs)
endfunction

function! s:Clear(group)
  exec 'highlight clear ' . a:group
endfunction


" Colors ======================================================================

" Let's store all the colors in a dictionary.
let s:colors = {}

" Base colors.
" background 234
let s:colors.base0 = { 'gui': '#fff', 'cterm': 234 }
" column highlighting 235
let s:colors.base1 = { 'gui': '#fff', 'cterm': 235 }
" statusbar 240
let s:colors.base2 = { 'gui': '#fff', 'cterm': 240  }
" visual select 236
let s:colors.base3 = { 'gui': '#fff', 'cterm': 236  }
" comments 240
let s:colors.base4 = { 'gui': '#fff', 'cterm': 240  }
" ???
let s:colors.base5 = { 'gui': '#fff', 'cterm': 2  }
" text 244
let s:colors.base6 = { 'gui': '#fff', 'cterm': 244 }
" ???
let s:colors.base7 = { 'gui': '#fff', 'cterm': 3 }

" Other colors.
let s:colors.red     = { 'gui': '#fff', 'cterm': 167 }
let s:colors.orange  = { 'gui': '#fff', 'cterm': 173 }
let s:colors.yellow  = { 'gui': '#fff', 'cterm': 106 }
" ???
let s:colors.magenta = { 'gui': '#fff', 'cterm': 1 }
let s:colors.violet  = { 'gui': '#fff', 'cterm': 60  }
let s:colors.blue    = { 'gui': '#fff', 'cterm': 24  }
let s:colors.cyan    = { 'gui': '#fff', 'cterm': 6  }
let s:colors.green   = { 'gui': '#fff', 'cterm': 29 }


" Native highlighting ==========================================================

let s:background = 'base0'
let s:linenr_background = 'base0'

" Everything starts here.
call s:Col('Normal', 'base6', s:background)

" Line, cursor and so on.
set cursorline
set cursorcolumn
call s:Col('Cursor', 'base1', 'base1')
call s:Col('CursorLine', '', 'base1')
call s:Col('CursorColumn', '', 'base1')

" Sign column, line numbers.
call s:Col('LineNr', 'base4', s:linenr_background)
call s:Col('CursorLineNr', 'base6', s:linenr_background)
call s:Col('SignColumn', '', s:linenr_background)
call s:Col('ColorColumn', '', s:linenr_background)

" Visual selection.
call s:Col('Visual', '', 'base3')

" Easy-to-guess code elements.
call s:Col('Comment', 'base4')
call s:Col('String', 'violet')
call s:Col('Number', 'blue')
call s:Col('Statement', 'red')
call s:Col('Special', 'orange')
call s:Col('Identifier', 'green')

" Constants, Ruby symbols.
call s:Col('Constant', 'base6')

" Some HTML tags (<title>, some <h*>s)
call s:Col('Title', 'base6')

" <a> tags.
call s:Col('Underlined', 'base6')
call s:Attr('Underlined', 'underline')

" Types, HTML attributes, Ruby constants (and class names).
call s:Col('Type', 'cyan')

" Stuff like 'require' in Ruby.
call s:Col('PreProc', 'base6')

" Tildes on the bottom of the page.
call s:Col('NonText', 'base4')

" Concealed stuff.
call s:Col('Conceal', 'base6', s:background)

" TODO and similar tags.
call s:Col('Todo', 'yellow', s:background)

" The column separating vertical splits.
call s:Col('VertSplit', 'base6', s:linenr_background)
call s:Col('StatusLineNC', 'base1', 'base2')

" Matching parenthesis.
call s:Col('MatchParen', 'base1', 'base6')

" Special keys, e.g. some of the chars in 'listchars'. See ':h listchars'.
call s:Col('SpecialKey', 'base6')

" Folds.
call s:Col('Folded', 'base6', 'base0')
call s:Col('FoldColumn', 'base5', 'base3')

" Searching.
call s:Col('Search', 'base2', 'yellow')
call s:Attr('IncSearch', 'reverse')

" Popup menu.
call s:Col('Pmenu', 'base6', 'base2')
call s:Col('PmenuSel', 'base7', 'base4')
call s:Col('PmenuSbar', '', 'base2')
call s:Col('PmenuThumb', '', 'base4')

" Command line stuff.
call s:Col('ErrorMsg', 'cyan', 'base0')
call s:Col('ModeMsg', 'blue')

" Wild menu.
" StatusLine determines the color of the non-active entries in the wild menu.
call s:Col('StatusLine', 'base0', 'base2')
call s:Col('WildMenu', 'cyan', 'base2')

" The 'Hit ENTER to continue prompt'.
call s:Col('Question', 'cyan')

" Tab line.
call s:Col('TabLineSel', 'base7', 'base4')  " the selected tab
call s:Col('TabLine', 'base6', 'base2')     " the non-selected tabs
call s:Col('TabLineFill', 'base0', 'base0') " the rest of the tab line

" Spelling.
call s:Col('SpellBad', 'base7', 'red')
call s:Col('SpellCap', 'base7', 'blue')
call s:Col('SpellLocal', 'yellow')
call s:Col('SpellRare', 'base7', 'violet')

" Diffing.
call s:Col('DiffAdd', 'base7', 'green')
call s:Col('DiffChange', 'base7', 'blue')
call s:Col('DiffDelete', 'base7', 'red')
call s:Col('DiffText', 'base7', 'cyan')
call s:Col('DiffAdded', 'green')
call s:Col('DiffChanged', 'blue')
call s:Col('DiffRemoved', 'red')
call s:Col('DiffSubname', 'base4')

" Directories (e.g. netrw).
call s:Col('Directory', 'cyan')


" Programming languages and filetypes ==========================================

" Ruby.
call s:Col('rubyDefine', 'blue')
call s:Col('rubyStringDelimiter', 'green')

" HTML (and often Markdown).
call s:Col('htmlArg', 'base6')
call s:Col('htmlItalic', 'base6')
call s:Col('htmlBold', 'base6', '')

" Python
call s:Col('pythonStatement', 'orange')


" Plugin =======================================================================

" GitGutter
call s:Col('GitGutterAdd', 'green', s:linenr_background)
call s:Col('GitGutterChange', 'cyan', s:linenr_background)
call s:Col('GitGutterDelete', 'magenta', s:linenr_background)
call s:Col('GitGutterChangeDelete', 'magenta', s:linenr_background)

" CtrlP
call s:Col('CtrlPNoEntries', 'base7', 'orange') " no entries
call s:Col('CtrlPMatch', 'green')               " matching part
call s:Col('CtrlPPrtBase', 'base4')             " '>>>' prompt
call s:Col('CtrlPPrtText', 'cyan')              " text in the prompt
call s:Col('CtrlPPtrCursor', 'base7')           " cursor in the prompt

" unite.vim
call s:Col('UniteGrep', 'base7', 'green')
let g:unite_source_grep_search_word_highlight = 'UniteGrep'

" coc.vim
call s:Col('CocFloating', 'base6', 'base4')
call s:Col('CocErrorSign', 'orange')
call s:Col('CocHintSign', 'orange')
call s:Col('FgCocErrorFloatBgCocFloating', 'orange', 'base4')
call s:Col('FgCocHintFloatBgCocFloating', 'orange', 'base4')
call s:Attr('CocUnderline', 'underline')


" Cleanup =====================================================================

unlet s:colors
unlet s:background
unlet s:linenr_background
