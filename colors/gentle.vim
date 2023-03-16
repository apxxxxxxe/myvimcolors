" ----------------------------------------------------------------
" initialize
" ----------------------------------------------------------------
highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'gentle'

" ----------------------------------------------------------------
" Colors base
" ----------------------------------------------------------------
let s:BG         = myvimcolors#tone2rgb(200, g:myvimcolors#tone_dkg)
let s:FIRST      = myvimcolors#tone2rgb(180, g:myvimcolors#tone_g) " String,CursorLineNr
let s:SECOND     = myvimcolors#tone2rgb(180, g:myvimcolors#tone_p) " Function,Keyword
let s:THIRD      = myvimcolors#tone2rgb(180, g:myvimcolors#tone_d) " Number,Float,Statement
let s:FOURTH     = myvimcolors#tone2rgb(180, g:myvimcolors#tone_p) " Identifier,Type
let s:FIFTH      = myvimcolors#tone2rgb(180, g:myvimcolors#tone_v) " Operator,PreProc
let s:contrast   = 1.0

" 'tone_on_tone' : 色相固定
" 'tone_in_tone' : トーン固定
" '70_25_5'      : トーン・色相固定
" 'single_color' : トーン・色相固定
let s:pattern = ''

" ----------------------------------------------------------------
" colors definition
" ----------------------------------------------------------------
if myvimcolors#rgb2hsl(s:BG)[2] < 50
  set background=dark
  let s:isdark = 1
else
  set background=light
  let s:isdark = -1
endif

let s:bg_hsl = myvimcolors#rgb2hsl(s:BG)
let s:bglight = myvimcolors#hsl2rgb(s:bg_hsl[0], s:bg_hsl[1], myvimcolors#clump(s:bg_hsl[2] * 1.1, 0, 255))
let s:bgdark = myvimcolors#hsl2rgb(s:bg_hsl[0], s:bg_hsl[1], myvimcolors#clump(s:bg_hsl[2] * 0.9, 0, 255))

let s:first_hsl = myvimcolors#rgb2hsl(s:FIRST)
let s:green = myvimcolors#hsl2rgb(120, s:first_hsl[1], s:first_hsl[2])
let s:yellow = myvimcolors#hsl2rgb(50, s:first_hsl[1], s:first_hsl[2])
let s:red = myvimcolors#hsl2rgb(0, s:first_hsl[1], s:first_hsl[2])

let s:fg         = myvimcolors#hsl2rgb(s:bg_hsl[0], s:bg_hsl[1], 100 - myvimcolors#rgb2hsl(s:BG)[2])
let s:subbg1     = myvimcolors#adjust_hex(s:BG, float2nr(s:isdark * 12.5 * s:contrast))
let s:subbg2     = myvimcolors#adjust_hex(s:BG, float2nr(s:isdark * 15 * s:contrast))
let s:comment    = myvimcolors#adjust_hex(s:BG, float2nr(s:isdark * 40 * s:contrast))
let s:matchparen = myvimcolors#opposite(s:BG)
let s:linenr     = myvimcolors#adjust_hex(s:BG, float2nr(s:isdark * 60 * s:contrast))

if s:pattern == 'single_color'
  let s:SECOND = myvimcolors#hsl2rgb(0, 0, float2nr(s:first_hsl[2]*0.6))
  let s:THIRD  = myvimcolors#hsl2rgb(0, 0, float2nr(s:first_hsl[2]*0.7))
  let s:FOURTH = myvimcolors#hsl2rgb(0, 0, float2nr(s:first_hsl[2]*0.8))
  let s:FIFTH  = myvimcolors#hsl2rgb(0, 0, float2nr(s:first_hsl[2]*0.9))
elseif s:pattern == 'tone_on_tone'
  let s:SECOND = myvimcolors#hsl2rgb(s:first_hsl[0], s:first_hsl[1], float2nr(s:first_hsl[2]*0.6))
  let s:THIRD  = myvimcolors#hsl2rgb(s:first_hsl[0], s:first_hsl[1], float2nr(s:first_hsl[2]*0.7))
  let s:FOURTH = myvimcolors#hsl2rgb(s:first_hsl[0], s:first_hsl[1], float2nr(s:first_hsl[2]*0.8))
  let s:FIFTH  = myvimcolors#hsl2rgb(s:first_hsl[0], s:first_hsl[1], float2nr(s:first_hsl[2]*0.9))
elseif s:pattern == '70_25_5'
  let s:SECOND = myvimcolors#hsl2rgb((s:first_hsl[0] + 180)%360, s:first_hsl[1], float2nr(s:first_hsl[2]*0.6))
  let s:THIRD  = myvimcolors#hsl2rgb((s:first_hsl[0] + 180)%360, s:first_hsl[1], float2nr(s:first_hsl[2]*0.7))
  let s:FOURTH = myvimcolors#hsl2rgb((s:first_hsl[0] + 180)%360, s:first_hsl[1], float2nr(s:first_hsl[2]*0.8))
  let s:FIFTH  = myvimcolors#hsl2rgb((s:first_hsl[0] + 180)%360, s:first_hsl[1], float2nr(s:first_hsl[2]*0.9))
elseif s:pattern == 'tone_in_tone'
  let s:SECOND = myvimcolors#hsl2rgb((s:first_hsl[0] + 72*1)%360, s:first_hsl[1], s:first_hsl[2])
  let s:THIRD  = myvimcolors#hsl2rgb((s:first_hsl[0] + 72*2)%360, s:first_hsl[1], s:first_hsl[2])
  let s:FOURTH = myvimcolors#hsl2rgb((s:first_hsl[0] + 72*3)%360, s:first_hsl[1], s:first_hsl[2])
  let s:FIFTH  = myvimcolors#hsl2rgb((s:first_hsl[0] + 72*4)%360, s:first_hsl[1], s:first_hsl[2])
endif

" ----------------------------------------------------------------
" highlighting
" ----------------------------------------------------------------
function! s:hi(group, foreground, background, fontStyle)
  exec  "highlight " . a:group
    \ . " guifg="    . a:foreground
    \ . " guibg="    . a:background
    \ . " gui="      . a:fontStyle
endfunction

" Syntax highlighting groups
call s:hi('TabLineSel', s:fg, s:BG, 'NONE')
call s:hi('TabLine', s:comment, s:subbg2, 'NONE')
call s:hi('TabLineFill', s:comment, s:subbg2, 'NONE')

call s:hi('StatusLine', s:fg, s:subbg2, 'NONE')
call s:hi('StatusLineNC', s:subbg2, s:BG, 'NONE')

call s:hi('Comment', s:comment, 'NONE', 'NONE')
call s:hi('Constant', s:fg, 'NONE', 'NONE')
call s:hi('String', s:FIRST, 'NONE', 'NONE')
call s:hi('Character', s:FIRST, 'NONE', 'NONE')
call s:hi('Number', s:THIRD, 'NONE', 'NONE')
call s:hi('Boolean', s:THIRD, 'NONE', 'NONE')
call s:hi('Float', s:THIRD, 'NONE', 'NONE')

call s:hi('Identifier', s:FOURTH, 'NONE', 'NONE')
call s:hi('Function', s:SECOND, 'NONE', 'NONE')

call s:hi('Statement', s:THIRD, 'NONE', 'NONE')"
call s:hi('Conditional', s:fg, 'NONE', 'NONE')
call s:hi('Repeat', s:fg, 'NONE', 'NONE')
call s:hi('Label', s:fg, 'NONE', 'NONE')
call s:hi('Operator', s:FIFTH, 'NONE', 'NONE')
call s:hi('Keyword', s:SECOND, 'NONE', 'NONE')
call s:hi('Exception', s:fg, 'NONE', 'NONE')"

call s:hi('PreProc', s:FIFTH, 'NONE', 'NONE')"
call s:hi('Include', s:FIFTH, 'NONE', 'NONE')
call s:hi('Define', s:FIFTH, 'NONE', 'NONE')
call s:hi('Macro', s:FIFTH, 'NONE', 'NONE')
call s:hi('PreCondit', s:FIFTH, 'NONE', 'NONE')"

call s:hi('Type', s:FOURTH, 'NONE', 'NONE')"
call s:hi('StorageClass', s:fg, 'NONE', 'NONE')
call s:hi('Structure', s:fg, 'NONE', 'NONE')
call s:hi('Typedef', s:fg, 'NONE', 'NONE')"

call s:hi('Special', s:fg, s:BG, 'NONE')"
call s:hi('SpecialChar', s:fg, s:BG, 'NONE')
call s:hi('Delimiter', s:fg, s:BG, 'NONE')
call s:hi('SpecialComment', s:comment, s:BG, 'NONE')
call s:hi('Debug', s:fg, s:BG, 'NONE')
call s:hi('Underlined', s:fg, s:BG, 'underline')
call s:hi('Todo', s:fg, s:BG, 'NONE')
call s:hi('Error', s:fg, s:red, 'underline')
call s:hi('ErrorMsg', s:fg, s:red, 'NONE')
call s:hi('Question', s:FIRST, s:BG, 'NONE')
call s:hi('WarningMsg', s:fg, s:yellow, 'NONE')
call s:hi('Search', s:BG, s:fg, 'NONE')"

call s:hi('Directory', s:linenr, s:BG, 'NONE')"
call s:hi('CursorLine', 'NONE', s:subbg2, 'NONE')
call s:hi('MatchParen', s:fg, s:matchparen, 'NONE')
call s:hi('ColorColumn', s:fg, s:subbg2, 'NONE')"

call s:hi('Folded', s:fg, s:comment, 'NONE')
call s:hi('FoldColumn', s:fg, s:BG, 'NONE')

" Interface highlighting
call s:hi('Normal', s:fg, s:BG, 'NONE')"
call s:hi('Visual', s:BG, s:fg, 'NONE')
call s:hi('Cursor', 'NONE', 'NONE', 'NONE')
call s:hi('iCursor', 'NONE', 'NONE', 'NONE')
call s:hi('LineNr', s:fg, s:subbg1, 'NONE')
call s:hi('SignColumn', s:fg, s:subbg1, 'NONE')
call s:hi('NonText', s:comment, s:BG, 'NONE')
call s:hi('CursorLineNr', s:FIRST, s:BG, 'NONE')
call s:hi('VertSplit', s:subbg2, s:BG, 'NONE')
call s:hi('Title', s:FIRST, s:BG, 'NONE')
call s:hi('Pmenu', s:fg, s:subbg2, 'NONE')
call s:hi('PmenuSel', s:BG, s:fg, 'NONE')
call s:hi('SpecialKey', s:BG, s:subbg2, 'NONE')"

" ###########################################
" Git Gutter
call s:hi('GitGutterAdd', s:green, s:subbg1, 'NONE')
call s:hi('GitGutterChange', s:yellow, s:subbg1, 'NONE')
call s:hi('GitGutterDelete', s:red, s:subbg1, 'NONE')
call s:hi('GitGutterChangeDelete', s:yellow, s:subbg1, 'NONE')

" Python syntax highlighting
call s:hi('pythonBuiltin', s:FIRST, s:BG, 'NONE')
call s:hi('pythonDecoratorName', s:FIRST, s:BG, 'NONE')
call s:hi('pythonDecorator', s:FIRST, s:BG, 'NONE')
call s:hi('pythonOperator', s:fg, s:BG, 'NONE')
call s:hi('jinjaTagDelim', s:FIRST, s:BG, 'NONE')
call s:hi('jinjaVarBlock', s:FIRST, s:BG, 'NONE')
call s:hi('jinjaStatement', s:FIRST, s:BG, 'NONE')
call s:hi('jinjaBlockName', s:fg, s:BG, 'NONE')
call s:hi('jinjaVariable', s:fg, s:BG, 'NONE')
call s:hi('jinjaString', s:FIRST, s:BG, 'NONE')
call s:hi('jinjaOperator', s:fg, s:BG, 'NONE')

" PHP
call s:hi('phpDefine', s:fg, s:BG, 'NONE')
call s:hi('phpIdentifier', s:fg, s:BG, 'NONE')
call s:hi('phpVarSelector', s:fg, s:BG, 'NONE')
call s:hi('bladeKeyword', s:FIRST, s:BG, 'NONE')

" Javascript
call s:hi('jsNull', s:FIRST, s:BG, 'NONE')
call s:hi('jsUndefined', s:FIRST, s:BG, 'NONE')
call s:hi('jsFunction', s:fg, s:BG, 'NONE')
call s:hi('jsFuncName', s:SECOND, s:BG, 'NONE')
call s:hi('jsArrowFunction', s:fg, s:BG, 'NONE')
call s:hi('jsonKeyword', s:fg, s:BG, 'NONE')

" Typescript
call s:hi('typescriptBraces', s:fg, s:BG, 'NONE')
call s:hi('typescriptDecorator', s:subbg2, s:BG, 'NONE')
call s:hi('typescriptImport', s:fg, s:BG, 'NONE')
call s:hi('typescriptExport', s:fg, s:BG, 'NONE')

" Java
call s:hi('javaAnnotation', s:subbg2, s:BG, 'NONE')

" HTML
call s:hi('htmlTagName', s:fg, s:BG, 'NONE')
call s:hi('htmlTag', s:fg, s:BG, 'NONE')
call s:hi('htmlArg', s:subbg2, s:BG, 'NONE')

" CSS
call s:hi('cssProp', s:fg, s:BG, 'NONE')
call s:hi('cssBraces', s:fg, s:BG, 'NONE')

" Ruby
call s:hi('rubyModule', s:fg, s:BG, 'NONE')
call s:hi('rubyDefine', s:fg, s:BG, 'NONE')
call s:hi('rubyClass', s:fg, s:BG, 'NONE')
call s:hi('rubyFunction', s:fg, s:BG, 'NONE')

" Clojure
call s:hi('clojureSpecial', s:fg, s:BG, 'NONE')
call s:hi('clojureDefine', s:fg, s:BG, 'NONE')
call s:hi('clojureKeyword', s:fg, s:BG, 'NONE')

" Vimscript syntax highlighting
call s:hi('vimOption', s:fg, s:BG, 'NONE')

" NERDTree
call s:hi('NERDTreeClosable', s:FIRST, s:BG, 'NONE')
call s:hi('NERDTreeOpenable', s:FIRST, s:BG, 'NONE')

" Hacks
hi CursorLine cterm=none
hi Identifier cterm=none

if has("gui_win32")
    call s:hi('Cursor', s:BG, s:FIRST, 'NONE')
endif

