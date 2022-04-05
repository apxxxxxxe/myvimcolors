highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'grosh'

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
let s:bg1           =   '#483434'
let s:bg2           =   '#6B4F4F'
let s:sub           =   s:adjust_hex(s:bg1, s:dim * 16)
let s:match         =   s:adjust_hex(s:bg1, s:dim * 16 * 4)


" Colors base
let s:primary       =   '#FFF3E4'
let s:secondary     =   '#EED6C4'
let s:accent        =   '#87AAAA'

let s:fg            =   s:adjust_hex(s:bg1, s:dim * 16 * 10)
let s:function      =   s:primary
let s:keyword       =   s:secondary
let s:const         =   s:accent
let s:string        =   s:accent

let s:comment       =   s:adjust_hex(s:bg1, s:dim * 16 * 4)


" Syntax highlighting groups
call s:hi('TabLineSel', s:secondary, s:bg1, s:none)
call s:hi('TabLine', s:bg1, s:bg2, s:none)
call s:hi('TabLineFill', s:bg2, s:bg2, s:none)

call s:hi('Comment', s:comment, s:bg1, s:none)
call s:hi('Constant', s:secondary, s:bg1, s:none)
call s:hi('String', s:string, s:bg1, s:none)
call s:hi('Character', s:string, s:bg1, s:none)
call s:hi('Number', s:const, s:bg1, s:none)
call s:hi('Boolean', s:const, s:bg1, s:none)
call s:hi('Float', s:const, s:bg1, s:none)

call s:hi('Identifier', s:secondary, s:bg1, s:none)
call s:hi('Function', s:function, s:bg1, s:none)

call s:hi('Statement', s:secondary, s:bg1, s:none)"
call s:hi('Conditional', s:keyword, s:bg1, s:none)
call s:hi('Repeat', s:keyword, s:bg1, s:none)
call s:hi('Label', s:secondary, s:bg1, s:none)
call s:hi('Operator', s:secondary, s:bg1, s:none)
call s:hi('Keyword', s:secondary, s:bg1, s:none)
call s:hi('Exception', s:secondary, s:bg1, s:none)"

call s:hi('PreProc', s:fg, s:bg1, s:none)"
call s:hi('Include', s:secondary, s:bg1, s:none)
call s:hi('Define', s:fg, s:bg1, s:none)
call s:hi('Macro', s:fg, s:bg1, s:none)
call s:hi('PreCondit', s:secondary, s:bg1, s:none)"

call s:hi('Type', s:primary, s:bg1, s:none)"
call s:hi('StorageClass', s:secondary, s:bg1, s:none)
call s:hi('Structure', s:secondary, s:bg1, s:none)
call s:hi('Typedef', s:secondary, s:bg1, s:none)"

call s:hi('Special', s:fg, s:bg1, s:none)"
call s:hi('SpecialChar', s:secondary, s:bg1, s:none)
call s:hi('Delimiter', s:fg, s:bg1, s:none)
call s:hi('SpecialComment', s:comment, s:bg1, s:none)
call s:hi('Debug', s:secondary, s:bg1, s:none)
call s:hi('Underlined', s:fg, s:bg1, s:underline)
call s:hi('Todo', s:secondary, s:bg1, s:none)
call s:hi('Error', s:const, s:bg1, s:underline)
call s:hi('ErrorMsg', s:const, s:bg1, s:none)
call s:hi('Question', s:string, s:bg1, s:none)
call s:hi('WarningMsg', s:secondary, s:none, s:none)
call s:hi('Search', s:bg1, s:fg, s:none)"

call s:hi('Directory', s:string, s:bg1, s:none)"
call s:hi('CursorLine', s:none, s:sub, s:none)
call s:hi('MatchParen', s:fg, s:match, s:none)
call s:hi('ColorColumn', s:fg, s:sub, s:none)"

call s:hi('Folded', s:fg, s:comment, s:none)
call s:hi('FoldColumn', s:fg, s:bg1, s:none)

" Interface highlighting
call s:hi('Normal', s:fg, s:bg1, s:none)"
call s:hi('Visual', s:bg1, s:fg, s:none)
call s:hi('Cursor', s:none, s:bg1, s:none)
call s:hi('iCursor', s:none, s:bg1, s:none)
call s:hi('LineNr', s:bg1, s:bg2, s:none)
call s:hi('NonText', s:comment, s:bg1, s:none)
call s:hi('CursorLineNr', s:accent, s:bg1, s:none)
call s:hi('VertSplit', s:sub, s:bg1, s:none)
call s:hi('Title', s:const, s:bg1, s:none)
call s:hi('Pmenu', s:fg, s:sub, s:none)
call s:hi('PmenuSel', s:bg1, s:fg, s:none)
call s:hi('SpecialKey', s:bg1, s:sub, s:none)"

" ###########################################
" Git Gutter
call s:hi('GitGutterAdd', s:fg, s:bg1, s:none)
call s:hi('GitGutterChange', s:fg, s:bg1, s:none)
call s:hi('GitGutterDelete', s:fg, s:bg1, s:none)
call s:hi('GitGutterChangeDelete', s:fg, s:bg1, s:none)
call s:hi('SignColumn', s:bg1, s:bg2, s:none)

" Python syntax highlighting
call s:hi('pythonBuiltin', s:const, s:bg1, s:none)
call s:hi('pythonDecoratorName', s:const, s:bg1, s:none)
call s:hi('pythonDecorator', s:const, s:bg1, s:none)
call s:hi('pythonOperator', s:secondary, s:bg1, s:none)
call s:hi('jinjaTagDelim', s:const, s:bg1, s:none)
call s:hi('jinjaVarBlock', s:const, s:bg1, s:none)
call s:hi('jinjaStatement', s:const, s:bg1, s:none)
call s:hi('jinjaBlockName', s:fg, s:bg1, s:none)
call s:hi('jinjaVariable', s:fg, s:bg1, s:none)
call s:hi('jinjaString', s:string, s:bg1, s:none)
call s:hi('jinjaOperator', s:secondary, s:bg1, s:none)

" PHP
call s:hi('phpDefine', s:secondary, s:bg1, s:none)
call s:hi('phpIdentifier', s:fg, s:bg1, s:none)
call s:hi('phpVarSelector', s:fg, s:bg1, s:none)
call s:hi('bladeKeyword', s:const, s:bg1, s:none)

" Javascript
call s:hi('jsNull', s:const, s:bg1, s:none)
call s:hi('jsUndefined', s:const, s:bg1, s:none)
call s:hi('jsFunction', s:secondary, s:bg1, s:none)
call s:hi('jsFuncName', s:function, s:bg1, s:none)
call s:hi('jsArrowFunction', s:secondary, s:bg1, s:none)
call s:hi('jsonKeyword', s:fg, s:bg1, s:none)

" Typescript
call s:hi('typescriptBraces', s:fg, s:bg1, s:none)
call s:hi('typescriptDecorator', s:bg2, s:bg1, s:none)
call s:hi('typescriptImport', s:secondary, s:bg1, s:none)
call s:hi('typescriptExport', s:secondary, s:bg1, s:none)

" Java
call s:hi('javaAnnotation', s:bg2, s:bg1, s:none)

" HTML
call s:hi('htmlTagName', s:secondary, s:bg1, s:none)
call s:hi('htmlTag', s:secondary, s:bg1, s:none)
call s:hi('Identifier', s:secondary, s:bg1, s:none)
call s:hi('htmlArg', s:bg2, s:bg1, s:none)

" CSS
call s:hi('cssProp', s:fg, s:bg1, s:none)
call s:hi('cssBraces', s:fg, s:bg1, s:none)

" Ruby
call s:hi('rubyModule', s:secondary, s:bg1, s:none)
call s:hi('rubyDefine', s:secondary, s:bg1, s:none)
call s:hi('rubyClass', s:secondary, s:bg1, s:none)
call s:hi('rubyFunction', s:fg, s:bg1, s:none)

" Clojure
call s:hi('clojureSpecial', s:secondary, s:bg1, s:none)
call s:hi('clojureDefine', s:secondary, s:bg1, s:none)
call s:hi('clojureKeyword', s:fg, s:bg1, s:none)

" Vimscript syntax highlighting
call s:hi('vimOption', s:fg, s:bg1, s:none)

" NERDTree
call s:hi('NERDTreeClosable', s:string, s:bg1, s:none)
call s:hi('NERDTreeOpenable', s:string, s:bg1, s:none)

" Hacks
hi CursorLine cterm=none
hi Identifier cterm=none

if has("gui_win32")
    call s:hi('Cursor', s:bg1, s:string, s:none)
endif

