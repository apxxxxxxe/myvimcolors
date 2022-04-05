" ----------------------------------------------------------------
" Colors base
" ----------------------------------------------------------------
let s:MAINBG        =   '#fff4ef'
let s:SUBBG         =   '#582b39'
let s:PRIMARY       =   '#bb8377'
let s:SECONDARY     =   '#b71010'
let s:ACCENT        =   '#b71010'

" ----------------------------------------------------------------
" initialize
" ----------------------------------------------------------------
highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'cpcpcp'
" 元はhacker

" ----------------------------------------------------------------
" functions
" ----------------------------------------------------------------
function! s:hi(group, foreground, background, fontStyle)
  exec  "highlight "  . a:group
    \ . " guifg="     . a:foreground
    \ . " guibg="     . a:background
    \ . " gui="       . a:fontStyle
endfunction

function! s:clump(value, min, max)
  " 値を最小値と最大値の範囲に収める
  if a:value < a:min
    return a:min
  elseif a:value > a:max
    return a:max
  else
    return a:value
  endif
endfunction

function! s:adjust_hex(hex, num)
  " 輝度を加算して返す
  let l:r = s:clump(str2nr(strpart(a:hex, 1, 2), 16) + a:num, 0, 255)
  let l:g = s:clump(str2nr(strpart(a:hex, 3, 2), 16) + a:num, 0, 255)
  let l:b = s:clump(str2nr(strpart(a:hex, 5, 2), 16) + a:num, 0, 255)
  return printf("#%02x%02x%02x", l:r, l:g, l:b)
endfunction

function! s:luminance(hex)
  " 輝度を反映したグレイスケールを返す
  let l:r = str2nr(strpart(a:hex, 1, 2), 16)
  let l:g = str2nr(strpart(a:hex, 3, 2), 16)
  let l:b = str2nr(strpart(a:hex, 5, 2), 16)
  let l:lum = (max([l:r, l:g, l:b]) + min([l:r, l:g, l:b]))

  return printf("#%02x%02x%02x", l:lum, l:lum, l:lum)
endfunction

function! s:complementary(hex)
  " 補色を返す
  let l:r = str2nr(strpart(a:hex, 1, 2), 16)
  let l:g = str2nr(strpart(a:hex, 3, 2), 16)
  let l:b = str2nr(strpart(a:hex, 5, 2), 16)
  let l:tmp = (max([l:r, l:g, l:b]) + min([l:r, l:g, l:b]))

  let l:r = l:tmp - l:r
  let l:g = l:tmp - l:g
  let l:b = l:tmp - l:b

  return printf("#%02x%02x%02x", l:r, l:g, l:b)
endfunction

function! s:opposite(hex)
  " 反対色を返す
  let l:r = 255 - str2nr(strpart(a:hex, 1, 2), 16)
  let l:g = 255 - str2nr(strpart(a:hex, 3, 2), 16)
  let l:b = 255 - str2nr(strpart(a:hex, 5, 2), 16)

  return printf("#%02x%02x%02x", l:r, l:g, l:b)
endfunction

" ----------------------------------------------------------------
" colors definition
" ----------------------------------------------------------------
let s:bg_check = str2nr(strpart(s:luminance(s:MAINBG), 1, 2), 16)
if s:bg_check < 128
  set background=dark
  let s:dim = 1
else
  set background=light
  let s:dim = -1
endif

let s:sub           =   s:adjust_hex(s:MAINBG, s:dim * 16)
let s:matchparen    =   s:opposite(s:MAINBG)

let s:fg            =   s:adjust_hex(s:MAINBG, s:dim * -16 * 10)
let s:function      =   s:SECONDARY
let s:keyword       =   s:PRIMARY
let s:const         =   s:ACCENT
let s:string        =   s:ACCENT

let s:comment       =   s:adjust_hex(s:MAINBG, s:dim * -16 * 4)

" ----------------------------------------------------------------
" highlighting
" ----------------------------------------------------------------

" Syntax highlighting groups
call s:hi('TabLineSel', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('TabLine', s:MAINBG, s:SUBBG, 'NONE')
call s:hi('TabLineFill', s:SUBBG, s:SUBBG, 'NONE')

call s:hi('Comment', s:comment, s:MAINBG, 'NONE')
call s:hi('Constant', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('String', s:string, s:MAINBG, 'NONE')
call s:hi('Character', s:string, s:MAINBG, 'NONE')
call s:hi('Number', s:const, s:MAINBG, 'NONE')
call s:hi('Boolean', s:const, s:MAINBG, 'NONE')
call s:hi('Float', s:const, s:MAINBG, 'NONE')

call s:hi('Identifier', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('Function', s:function, s:MAINBG, 'NONE')

call s:hi('Statement', s:PRIMARY, s:MAINBG, 'NONE')"
call s:hi('Conditional', s:keyword, s:MAINBG, 'NONE')
call s:hi('Repeat', s:keyword, s:MAINBG, 'NONE')
call s:hi('Label', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('Operator', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('Keyword', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('Exception', s:PRIMARY, s:MAINBG, 'NONE')"

call s:hi('PreProc', s:fg, s:MAINBG, 'NONE')"
call s:hi('Include', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('Define', s:fg, s:MAINBG, 'NONE')
call s:hi('Macro', s:fg, s:MAINBG, 'NONE')
call s:hi('PreCondit', s:PRIMARY, s:MAINBG, 'NONE')"

call s:hi('Type', s:SECONDARY, s:MAINBG, 'NONE')"
call s:hi('StorageClass', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('Structure', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('Typedef', s:PRIMARY, s:MAINBG, 'NONE')"

call s:hi('Special', s:fg, s:MAINBG, 'NONE')"
call s:hi('SpecialChar', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('Delimiter', s:fg, s:MAINBG, 'NONE')
call s:hi('SpecialComment', s:comment, s:MAINBG, 'NONE')
call s:hi('Debug', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('Underlined', s:fg, s:MAINBG, 'underline')
call s:hi('Todo', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('Error', s:const, s:MAINBG, 'underline')
call s:hi('ErrorMsg', s:const, s:MAINBG, 'NONE')
call s:hi('Question', s:string, s:MAINBG, 'NONE')
call s:hi('WarningMsg', s:PRIMARY, 'NONE', 'NONE')
call s:hi('Search', s:MAINBG, s:fg, 'NONE')"

call s:hi('Directory', s:string, s:MAINBG, 'NONE')"
call s:hi('CursorLine', 'NONE', s:sub, 'NONE')
call s:hi('MatchParen', s:fg, s:matchparen, 'NONE')
call s:hi('ColorColumn', s:fg, s:sub, 'NONE')"

call s:hi('Folded', s:fg, s:comment, 'NONE')
call s:hi('FoldColumn', s:fg, s:MAINBG, 'NONE')

" Interface highlighting
call s:hi('Normal', s:fg, s:MAINBG, 'NONE')"
call s:hi('Visual', s:MAINBG, s:fg, 'NONE')
call s:hi('Cursor', 'NONE', s:MAINBG, 'NONE')
call s:hi('iCursor', 'NONE', s:MAINBG, 'NONE')
call s:hi('LineNr', s:MAINBG, s:SUBBG, 'NONE')
call s:hi('NonText', s:comment, s:MAINBG, 'NONE')
call s:hi('CursorLineNr', s:ACCENT, s:MAINBG, 'NONE')
call s:hi('VertSplit', s:sub, s:MAINBG, 'NONE')
call s:hi('Title', s:const, s:MAINBG, 'NONE')
call s:hi('Pmenu', s:fg, s:sub, 'NONE')
call s:hi('PmenuSel', s:MAINBG, s:fg, 'NONE')
call s:hi('SpecialKey', s:MAINBG, s:sub, 'NONE')"

" ###########################################
" Git Gutter
call s:hi('GitGutterAdd', s:fg, s:MAINBG, 'NONE')
call s:hi('GitGutterChange', s:fg, s:MAINBG, 'NONE')
call s:hi('GitGutterDelete', s:fg, s:MAINBG, 'NONE')
call s:hi('GitGutterChangeDelete', s:fg, s:MAINBG, 'NONE')
call s:hi('SignColumn', s:MAINBG, s:SUBBG, 'NONE')

" Python syntax highlighting
call s:hi('pythonBuiltin', s:const, s:MAINBG, 'NONE')
call s:hi('pythonDecoratorName', s:const, s:MAINBG, 'NONE')
call s:hi('pythonDecorator', s:const, s:MAINBG, 'NONE')
call s:hi('pythonOperator', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('jinjaTagDelim', s:const, s:MAINBG, 'NONE')
call s:hi('jinjaVarBlock', s:const, s:MAINBG, 'NONE')
call s:hi('jinjaStatement', s:const, s:MAINBG, 'NONE')
call s:hi('jinjaBlockName', s:fg, s:MAINBG, 'NONE')
call s:hi('jinjaVariable', s:fg, s:MAINBG, 'NONE')
call s:hi('jinjaString', s:string, s:MAINBG, 'NONE')
call s:hi('jinjaOperator', s:PRIMARY, s:MAINBG, 'NONE')

" PHP
call s:hi('phpDefine', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('phpIdentifier', s:fg, s:MAINBG, 'NONE')
call s:hi('phpVarSelector', s:fg, s:MAINBG, 'NONE')
call s:hi('bladeKeyword', s:const, s:MAINBG, 'NONE')

" Javascript
call s:hi('jsNull', s:const, s:MAINBG, 'NONE')
call s:hi('jsUndefined', s:const, s:MAINBG, 'NONE')
call s:hi('jsFunction', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('jsFuncName', s:function, s:MAINBG, 'NONE')
call s:hi('jsArrowFunction', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('jsonKeyword', s:fg, s:MAINBG, 'NONE')

" Typescript
call s:hi('typescriptBraces', s:fg, s:MAINBG, 'NONE')
call s:hi('typescriptDecorator', s:SUBBG, s:MAINBG, 'NONE')
call s:hi('typescriptImport', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('typescriptExport', s:PRIMARY, s:MAINBG, 'NONE')

" Java
call s:hi('javaAnnotation', s:SUBBG, s:MAINBG, 'NONE')

" HTML
call s:hi('htmlTagName', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('htmlTag', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('Identifier', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('htmlArg', s:SUBBG, s:MAINBG, 'NONE')

" CSS
call s:hi('cssProp', s:fg, s:MAINBG, 'NONE')
call s:hi('cssBraces', s:fg, s:MAINBG, 'NONE')

" Ruby
call s:hi('rubyModule', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('rubyDefine', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('rubyClass', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('rubyFunction', s:fg, s:MAINBG, 'NONE')

" Clojure
call s:hi('clojureSpecial', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('clojureDefine', s:PRIMARY, s:MAINBG, 'NONE')
call s:hi('clojureKeyword', s:fg, s:MAINBG, 'NONE')

" Vimscript syntax highlighting
call s:hi('vimOption', s:fg, s:MAINBG, 'NONE')

" NERDTree
call s:hi('NERDTreeClosable', s:string, s:MAINBG, 'NONE')
call s:hi('NERDTreeOpenable', s:string, s:MAINBG, 'NONE')

" Hacks
hi CursorLine cterm=none
hi Identifier cterm=none

if has("gui_win32")
    call s:hi('Cursor', s:MAINBG, s:string, 'NONE')
endif

