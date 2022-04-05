highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'neon'

set background=dark

if &background == 'dark'
  let s:dim = 1
else
  let s:dim = -1
endif


" Helper function to set up highlight executions
function! s:hi(group, foreground, background, fontStyle)
  exec  "highlight "  . a:group
    \ . " guifg="     . a:foreground
    \ . " guibg="     . a:background
    \ . " gui="       . a:fontStyle
endfunction

function! s:adjust_hex(hex, num)
  let l:r = str2nr(strpart(a:hex, 1, 2), 16) + a:num
  if l:r < 0
    let l:r = 0
  elseif l:r > 255
    let l:r = 255
  endif
  let l:g = str2nr(strpart(a:hex, 3, 2), 16) + a:num
  if l:g < 0
    let l:g = 0
  elseif l:g > 255
    let l:g = 255
  endif
  let l:b = str2nr(strpart(a:hex, 5, 2), 16) + a:num
  if l:b < 0
    let l:b = 0
  elseif l:b > 255
    let l:b = 255
  endif
  return printf("#%02x%02x%02x", l:r, l:g, l:b)
endfunction

" Text style
let s:italic        =   'italic'
let s:bold          =   'bold'
let s:underline     =   'underline'
let s:none          =   'NONE'


" Background
let s:base          =   '#2E2833'
let s:sub           =   s:adjust_hex(s:base, s:dim * 16)
let s:match         =   s:adjust_hex(s:base, s:dim * 16 * 4)


" Colors base
let s:primary       =   '#E65683'
let s:socondary     =   '#D92A7A'
let s:accent        =   '#4BB0B2'

let s:fg            =   s:adjust_hex(s:base, s:dim * 16 * 10)
let s:keyword       =   s:socondary
let s:structure     =   s:primary
let s:const         =   s:accent
let s:string        =   s:accent

let s:comment       =   s:adjust_hex(s:base, s:dim * 16 * 4)


" Syntax highlighting groups
call s:hi('TabLineSel', s:socondary, s:base, s:none)
call s:hi('TabLine', s:base, s:primary, s:none)
call s:hi('TabLineFill', s:primary, s:primary, s:none)

call s:hi('Comment', s:comment, s:base, s:none)
call s:hi('Constant', s:socondary, s:base, s:none)
call s:hi('String', s:string, s:base, s:none)
call s:hi('Character', s:string, s:base, s:none)
call s:hi('Number', s:const, s:base, s:none)
call s:hi('Boolean', s:const, s:base, s:none)
call s:hi('Float', s:const, s:base, s:none)

call s:hi('Identifier', s:socondary, s:base, s:none)
call s:hi('Function', s:primary, s:base, s:none)

call s:hi('Statement', s:socondary, s:base, s:none)
call s:hi('Conditional', s:keyword, s:base, s:none)
call s:hi('Repeat', s:keyword, s:base, s:none)
call s:hi('Label', s:socondary, s:base, s:none)
call s:hi('Operator', s:socondary, s:base, s:none)
call s:hi('Keyword', s:socondary, s:base, s:none)
call s:hi('Exception', s:socondary, s:base, s:none)

call s:hi('PreProc', s:fg, s:base, s:none)
call s:hi('Include', s:socondary, s:base, s:none)
call s:hi('Define', s:fg, s:base, s:none)
call s:hi('Macro', s:fg, s:base, s:none)
call s:hi('PreCondit', s:socondary, s:base, s:none)

call s:hi('Type', s:primary, s:base, s:none)
call s:hi('StorageClass', s:socondary, s:base, s:none)
call s:hi('Structure', s:socondary, s:base, s:none)
call s:hi('Typedef', s:socondary, s:base, s:none)

call s:hi('Special', s:fg, s:base, s:none)
call s:hi('SpecialChar', s:socondary, s:base, s:none)
call s:hi('Delimiter', s:fg, s:base, s:none)
call s:hi('SpecialComment', s:comment, s:base, s:none)
call s:hi('Debug', s:socondary, s:base, s:none)
call s:hi('Underlined', s:fg, s:base, s:underline)
call s:hi('Todo', s:socondary, s:base, s:none)
call s:hi('Error', s:const, s:base, s:underline)
call s:hi('ErrorMsg', s:const, s:base, s:none)
call s:hi('Question', s:string, s:base, s:none)
call s:hi('WarningMsg', s:socondary, s:none, s:none)
call s:hi('Search', s:base, s:fg, s:none)

call s:hi('Directory', s:string, s:base, s:none)
call s:hi('CursorLine', s:none, s:sub, s:none)
call s:hi('MatchParen', s:fg, s:match, s:none)
call s:hi('ColorColumn', s:fg, s:sub, s:none)


" Interface highlighting
call s:hi('Normal', s:fg, s:base, s:none)
call s:hi('Visual', s:base, s:fg, s:none)
call s:hi('Cursor', s:none, s:base, s:none)
call s:hi('iCursor', s:none, s:base, s:none)
call s:hi('LineNr', s:base, s:primary, s:none)
call s:hi('NonText', s:comment, s:base, s:none)
call s:hi('CursorLineNr', s:accent, s:base, s:none)
call s:hi('VertSplit', s:sub, s:base, s:none)
call s:hi('Title', s:const, s:base, s:none)
call s:hi('Pmenu', s:fg, s:sub, s:none)
call s:hi('PmenuSel', s:base, s:fg, s:none)
call s:hi('SpecialKey', s:base, s:comment, s:none)

call s:hi('Folded', s:fg, s:comment, s:none)

" ###########################################
" Git Gutter
call s:hi('GitGutterAdd', s:fg, s:base, s:none)
call s:hi('GitGutterChange', s:fg, s:base, s:none)
call s:hi('GitGutterDelete', s:fg, s:base, s:none)
call s:hi('GitGutterChangeDelete', s:fg, s:base, s:none)
call s:hi('SignColumn', s:fg, s:base, s:none)

" Python syntax highlighting
call s:hi('pythonBuiltin', s:const, s:base, s:none)
call s:hi('pythonDecoratorName', s:const, s:base, s:none)
call s:hi('pythonDecorator', s:const, s:base, s:none)
call s:hi('pythonOperator', s:socondary, s:base, s:none)
call s:hi('jinjaTagDelim', s:const, s:base, s:none)
call s:hi('jinjaVarBlock', s:const, s:base, s:none)
call s:hi('jinjaStatement', s:const, s:base, s:none)
call s:hi('jinjaBlockName', s:fg, s:base, s:none)
call s:hi('jinjaVariable', s:fg, s:base, s:none)
call s:hi('jinjaString', s:string, s:base, s:none)
call s:hi('jinjaOperator', s:socondary, s:base, s:none)

" PHP
call s:hi('phpDefine', s:socondary, s:base, s:none)
call s:hi('phpIdentifier', s:fg, s:base, s:none)
call s:hi('phpVarSelector', s:fg, s:base, s:none)
call s:hi('bladeKeyword', s:const, s:base, s:none)

" Javascript
call s:hi('jsNull', s:const, s:base, s:none)
call s:hi('jsUndefined', s:const, s:base, s:none)
call s:hi('jsFunction', s:socondary, s:base, s:none)
call s:hi('jsFuncName', s:primary, s:base, s:none)
call s:hi('jsArrowFunction', s:socondary, s:base, s:none)
call s:hi('jsonKeyword', s:fg, s:base, s:none)

" Typescript
call s:hi('typescriptBraces', s:fg, s:base, s:none)
call s:hi('typescriptDecorator', s:primary, s:base, s:none)
call s:hi('typescriptImport', s:socondary, s:base, s:none)
call s:hi('typescriptExport', s:socondary, s:base, s:none)

" Java
call s:hi('javaAnnotation', s:primary, s:base, s:none)

" HTML
call s:hi('htmlTagName', s:socondary, s:base, s:none)
call s:hi('htmlTag', s:socondary, s:base, s:none)
call s:hi('Identifier', s:socondary, s:base, s:none)
call s:hi('htmlArg', s:primary, s:base, s:none)

" CSS
call s:hi('cssProp', s:fg, s:base, s:none)
call s:hi('cssBraces', s:fg, s:base, s:none)

" Ruby
call s:hi('rubyModule', s:socondary, s:base, s:none)
call s:hi('rubyDefine', s:socondary, s:base, s:none)
call s:hi('rubyClass', s:socondary, s:base, s:none)
call s:hi('rubyFunction', s:fg, s:base, s:none)

" Clojure
call s:hi('clojureSpecial', s:socondary, s:base, s:none)
call s:hi('clojureDefine', s:socondary, s:base, s:none)
call s:hi('clojureKeyword', s:fg, s:base, s:none)

" Vimscript syntax highlighting
call s:hi('vimOption', s:fg, s:base, s:none)

" NERDTree
call s:hi('NERDTreeClosable', s:string, s:base, s:none)
call s:hi('NERDTreeOpenable', s:string, s:base, s:none)

" Hacks
hi CursorLine cterm=none
hi Identifier cterm=none

if has("gui_win32")
    call s:hi('Cursor', s:base, s:string, s:none)
endif

