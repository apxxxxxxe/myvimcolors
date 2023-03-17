if exists('g:autoloaded_myvimcolors')
  " finish
endif
let g:autoloaded_myvimcolors = 1

" 24, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22
let s:pccs_hue = [330, 344, 19, 37, 53, 66, 153, 181, 201, 209, 251, 300]

function! myvimcolors#pccs2idx(pccs)
  return str2nr(matchstr(a:pccs, '[0-9]\+'))
endfunction

function! myvimcolors#idx2hue(idx)
  let l:idx = a:idx % 24 / 2
  return s:pccs_hue[l:idx]
endfunction

function! myvimcolors#hue_info(hue)
  let l:min = 360
  let l:min_idx = -1
  let l:i=0
  for h in s:pccs_hue
    let l:m = abs(a:hue-h)
    if l:m < l:min
      let l:min = l:m
      let l:min_idx = l:i
    endif
    let l:i += 1
  endfor
  return {
        \ 'index': l:min_idx == 0 ? 24 : l:min_idx*2,
        \ 'hue'  : s:pccs_hue[l:min_idx],
        \}
endfunction

" 値を最小値と最大値の範囲に収める
function! myvimcolors#clump(value, min, max)
  if a:value < a:min
    return a:min
  elseif a:value > a:max
    return a:max
  else
    return a:value
  endif
endfunction

" 輝度を加算して返す
function! myvimcolors#adjust_hex(hex, num)
  let l:hex_hsl = myvimcolors#rgb2hsl(a:hex)
  return myvimcolors#hsl2rgb(l:hex_hsl[0], l:hex_hsl[1], myvimcolors#clump(l:hex_hsl[2] + a:num, 0, 100))
endfunction

" 反対色を返す
function! myvimcolors#opposite(hex)
  let l:r = 255 - str2nr(strpart(a:hex, 1, 2), 16)
  let l:g = 255 - str2nr(strpart(a:hex, 3, 2), 16)
  let l:b = 255 - str2nr(strpart(a:hex, 5, 2), 16)

  return printf("#%02x%02x%02x", l:r, l:g, l:b)
endfunction

function! myvimcolors#ary2hex(R,G,B) abort
  return printf("#%02x%02x%02x", a:R, a:G, a:B)
endfunction

function! myvimcolors#hex2ary(hex) abort
  let l:r = str2nr(strpart(a:hex, 1, 2), 16)
  let l:g = str2nr(strpart(a:hex, 3, 2), 16)
  let l:b = str2nr(strpart(a:hex, 5, 2), 16)
  return [l:r, l:g, l:b]
endfunction

function! myvimcolors#hsl2rgb(H, S, L) abort
  if a:L <= 49
    let max = 2.55 * (a:L + a:L * (1.0 * a:S / 100))
    let min = 2.55 * (a:L - a:L * (1.0 * a:S / 100))
  else
    let max = 2.55 * (a:L + (100 - a:L) * (1.0 * a:S / 100))
    let min = 2.55 * (a:L - (100 - a:L) * (1.0 * a:S / 100))
  endif
  if (0 <= a:H) && (a:H < 60)
    let l:r = max
    let l:g = (1.0 * a:H / 60) * (max - min) + min
    let l:b = min
  elseif (60 <= a:H) && (a:H < 120)
    let l:r = (1.0 * (120 - a:H) / 60) * (max - min) + min
    let l:g = max
    let l:b = min
  elseif (120 <= a:H) && (a:H < 180)
    let l:r = min
    let l:g = max
    let l:b = (1.0 * (a:H - 120) / 60) * (max - min) + min
  elseif (180 <= a:H) && (a:H < 240)
    let l:r = min
    let l:g = (1.0 * (240 - a:H) / 60) * (max - min) + min
    let l:b = max
  elseif (240 <= a:H) && (a:H < 300)
    let l:r = (1.0 * (a:H - 240) / 60) * (max - min) + min
    let l:g = min
    let l:b = max
  elseif (300 <= a:H) && (a:H <= 360)
    let l:r = max
    let l:g = min
    let l:b = (1.0 * (360 - a:H) / 60) * (max - min) + min
  endif
  return printf("#%02x%02x%02x", float2nr(l:r), float2nr(l:g), float2nr(l:b))
endfunction

" ref: http://www.w3.org/TR/AERT#color
function! myvimcolors#get_contrast(a,b)
  let l:a = myvimcolors#hex2ary(a:a)
  let l:b = myvimcolors#hex2ary(a:b)
  return abs(((l:a[0]-l:b[0])*299.0 + (l:a[1]-l:b[1])*587.0 + (l:a[2]-l:b[2])*114.0) / 1000)
endfunction

function! myvimcolors#find_suite_contrast(hex, threshold)
  let l:best_contrast = 0
  let l:best_color = ''

  let l:hex_hsl = myvimcolors#rgb2hsl(a:hex)
  if l:hex_hsl[2] < 50
    let l:mono_range = range(1,9)
    let l:hoge_range = ['p', 'lt', 'b', 'sf', 'ltg', 'v', 's', 'd', 'g', 'dp', 'dk', 'dkg']
  else
    let l:mono_range = range(9,1,-1)
    let l:hoge_range = ['dkg', 'dk', 'dp', 'g', 'd', 's', 'v', 'ltg', 'sf', 'b', 'lt', 'p']
  endif

  " normal colors
  let l:hue_idx = (myvimcolors#hue_info(l:hex_hsl[0])['index']+12)%24
  if l:hue_idx == 0 | let l:hue_idx = 24 | endif
  for tone in l:hoge_range
    let l:col = g:myvimcolors#pccs[tone .. l:hue_idx]
    let l:con = myvimcolors#get_contrast(a:hex, l:col)
    if l:con > l:best_contrast
      let l:best_contrast = l:con
      let l:best_color = l:col
    endif
  endfor

  " monotone colors
  if l:best_contrast < a:threshold
    for i in l:mono_range
      let l:col = g:myvimcolors#pccs['Gy-' .. i .. '.5']
      let l:con = myvimcolors#get_contrast(a:hex, l:col)
      if l:con > l:best_contrast
        let l:best_contrast = l:con
        let l:best_color = l:col
      endif
    endfor
  endif

  return l:best_color
endfunction

function! myvimcolors#rgb2hsl(hex) abort
  let l:hex = myvimcolors#hex2ary(a:hex)
  let l:r = l:hex[0]
  let l:g = l:hex[1]
  let l:b = l:hex[2]

  let max = max([(l:r), (l:g), (l:b)])
  let min = min([(l:r), (l:g), (l:b)])

  " Hue calculation
  if max == min
    let H = 0
  elseif max == l:r
    let H = 60 * (1.0 * (l:g - l:b) / (max - min))
  elseif max == l:g
    let H = 60 * (1.0 * (l:b - l:r) / (max - min)) + 120
  elseif max == l:b
    let H = 60 * (1.0 * (l:r - l:g) / (max - min)) + 240
  else
    let H = 0
  endif
  if H < 0
    let H = H + 360
  endif

  " Saturation calculation
  if max == min
    let S = 0
  else
    if 128 <= (max + min) / 2
      let S = 1.0 * (max - min) / (510 - max - min)
    else
      let S = 1.0 * (max - min) / (max + min)
    endif
    let S *= 100
  endif

  " Lightness calculation
  let L = 1.0 * (max + min) / 2 / 255
  let L *= 100

  return map([H, S, L], { i,x -> float2nr(ceil(floor(x * 10) / 10)) })
endfunction

function! myvimcolors#palette(pattern, accent_color, bg_color)
  let l:accent_hsl = myvimcolors#rgb2hsl(a:accent_color)
  if myvimcolors#rgb2hsl(a:bg_color)[2] < 50
    let l:isdark = 1
  else
    let l:isdark = -1
  endif
  if a:pattern == 'single_color'
    " 'single_color' : トーン・色相固定
    return [
          \  myvimcolors#hsl2rgb(0, 0, float2nr(l:accent_hsl[2]*0.6)),
          \  myvimcolors#hsl2rgb(0, 0, float2nr(l:accent_hsl[2]*0.7)),
          \  myvimcolors#hsl2rgb(0, 0, float2nr(l:accent_hsl[2]*0.8)),
          \  myvimcolors#hsl2rgb(0, 0, float2nr(l:accent_hsl[2]*0.9)),
          \  myvimcolors#hsl2rgb(0, 0, float2nr(l:accent_hsl[2]*0.9)),
          \]
  elseif a:pattern == '70_25_5'
    " '70_25_5'      : トーン・色相固定
    return [
          \  myvimcolors#hsl2rgb((l:accent_hsl[0] + 180)%360, l:accent_hsl[1], float2nr(l:accent_hsl[2]*0.6)),
          \  myvimcolors#hsl2rgb((l:accent_hsl[0] + 180)%360, l:accent_hsl[1], float2nr(l:accent_hsl[2]*0.7)),
          \  myvimcolors#hsl2rgb((l:accent_hsl[0] + 180)%360, l:accent_hsl[1], float2nr(l:accent_hsl[2]*0.8)),
          \  myvimcolors#hsl2rgb((l:accent_hsl[0] + 180)%360, l:accent_hsl[1], float2nr(l:accent_hsl[2]*0.9)),
          \  myvimcolors#hsl2rgb((l:accent_hsl[0] + 180)%360, l:accent_hsl[1], float2nr(l:accent_hsl[2]*0.9)),
          \]
  elseif a:pattern == 'tone_on_tone'
    " 'tone_on_tone' : 色相固定
    return [
          \  myvimcolors#hsl2rgb(l:accent_hsl[0], l:accent_hsl[1], float2nr(l:accent_hsl[2]*0.6)),
          \  myvimcolors#hsl2rgb(l:accent_hsl[0], l:accent_hsl[1], float2nr(l:accent_hsl[2]*0.7)),
          \  myvimcolors#hsl2rgb(l:accent_hsl[0], l:accent_hsl[1], float2nr(l:accent_hsl[2]*0.8)),
          \  myvimcolors#hsl2rgb(l:accent_hsl[0], l:accent_hsl[1], float2nr(l:accent_hsl[2]*0.9)),
          \  myvimcolors#hsl2rgb(l:accent_hsl[0], l:accent_hsl[1], float2nr(l:accent_hsl[2]*0.9)),
          \]
  elseif a:pattern == 'tone_in_tone'
    " 'tone_in_tone' : トーン固定
    return [
          \  myvimcolors#hsl2rgb((l:accent_hsl[0] + (360/24* 0))%360, l:accent_hsl[1], myvimcolors#clump(l:accent_hsl[2]*(1.0-l:isdark*(-0.2)), 0, 100)),
          \  myvimcolors#hsl2rgb((l:accent_hsl[0] + (360/24* 0))%360, l:accent_hsl[1], myvimcolors#clump(l:accent_hsl[2]*(1.0-l:isdark*( 0.2)), 0, 100)),
          \  myvimcolors#hsl2rgb((l:accent_hsl[0] + (360/24*12))%360, 50, l:accent_hsl[2]),
          \  myvimcolors#hsl2rgb((l:accent_hsl[0] + (360/24*12))%360, 50, myvimcolors#clump(l:accent_hsl[2]*(1.0-l:isdark*( 0.2)), 0, 100)),
          \  myvimcolors#hsl2rgb((l:accent_hsl[0] + (360/24*12))%360, 50, myvimcolors#clump(l:accent_hsl[2]*(1.0-l:isdark*(-0.2)), 0, 100)),
          \]
  endif
endfunction

function! s:hi(group, foreground, background, fontStyle)
  exec  "hi " . a:group
    \ . " guifg="    . a:foreground
    \ . " guibg="    . a:background
    \ . " cterm="    . a:fontStyle
    \ . " gui="      . a:fontStyle
endfunction

function! s:link(src, dest)
  exec "hi! link " . a:src . " " . a:dest
endfunction

function! myvimcolors#highlights(colors)
  if myvimcolors#rgb2hsl(a:colors.bg)[2] < 50
    let l:warning_fg = a:colors.bg
  else
    let l:warning_fg = a:colors.fg
  endif
  highlight clear

  if exists('syntax_on')
    syntax reset
  endif

  call s:hi('Comment', a:colors.comment, 'NONE', 'NONE')

  " *Constant
  call s:hi('Constant', a:colors.third, 'NONE', 'NONE')
  call s:link('String', 'Constant')
  call s:link('Character', 'Constant')
  call s:hi('Number', a:colors.second, 'NONE', 'NONE')
  call s:hi('Boolean', a:colors.second, 'NONE', 'NONE')
  call s:hi('Float', a:colors.second, 'NONE', 'NONE')

  " *Identifier
  call s:hi('Identifier', a:colors.fg, 'NONE', 'NONE')
  call s:hi('Function', a:colors.fourth, 'NONE', 'NONE')

  " *Statement
  call s:hi('Statement', a:colors.first, 'NONE', g:statement_bold ? 'BOLD' : 'NONE')
  call s:link('Conditional', 'Statement')
  call s:link('Repeat', 'Statement')
  call s:link('Label', 'Statement')
  call s:link('Exception', 'Statement')
  call s:link('Keyword', 'Statement')
  call s:hi('Operator', a:colors.sixth, 'NONE', 'NONE')

  " PreProc
  call s:hi('PreProc', a:colors.sixth, 'NONE', 'NONE')
  call s:link('Include', 'PreProc')
  call s:link('Define', 'PreProc')
  call s:link('Macro', 'PreProc')
  call s:link('PreCondit', 'PreProc')

  " *Type
  call s:hi('Type', a:colors.first, 'NONE', 'NONE')
  call s:link('StorageClass', 'Type')
  call s:link('Structure', 'Type')
  call s:link('Typedef', 'Type')

  " *Special
  call s:hi('Special', a:colors.fifth, 'NONE', 'NONE')
  call s:link('SpecialChar', 'Special')
  call s:hi('Delimiter', a:colors.fg, 'NONE', 'NONE')
  call s:hi('SpecialComment', a:colors.comment, a:colors.bg, 'NONE')
  call s:hi('Debug', a:colors.fg, a:colors.bg, 'NONE')
  call s:hi('Underlined', a:colors.fg, a:colors.bg, 'underline')
  call s:link('Todo', 'Special')
  call s:hi('Error', l:warning_fg, a:colors.red, 'underline')
  call s:hi('ErrorMsg', l:warning_fg, a:colors.red, 'NONE')
  call s:hi('Question', a:colors.third, a:colors.bg, 'NONE')
  call s:hi('WarningMsg', l:warning_fg, a:colors.yellow, 'NONE')
  call s:hi('Search', a:colors.bg, a:colors.fg, 'NONE')

  call s:link('IncSearch', 'Search')

  call s:hi('Directory', a:colors.comment, a:colors.bg, 'NONE')
  call s:hi('MatchParen', a:colors.red, a:colors.matchparen, 'NONE')
  call s:hi('ColorColumn', a:colors.fg, a:colors.subbg, 'NONE')

  " Interface highlighting
  call s:hi('Normal', a:colors.fg, a:colors.bg, 'NONE')
  call s:hi('Visual', a:colors.bg, a:colors.fg, 'NONE')
  call s:hi('Cursor', 'NONE', 'NONE', 'NONE')
  call s:hi('iCursor', 'NONE', 'NONE', 'NONE')
  call s:hi('LineNr', a:colors.linenr, a:colors.bg, 'NONE')
  call s:hi('SignColumn', a:colors.linenr, a:colors.bg, 'NONE')
  call s:hi('NonText', a:colors.comment, a:colors.bg, 'NONE')
  call s:hi('CursorLine', 'NONE', a:colors.subbg, 'NONE')
  call s:hi('CursorLineNr', a:colors.third, a:colors.bg, 'NONE')
  call s:hi('VertSplit', a:colors.subbg, a:colors.bg, 'NONE')
  call s:hi('Title', a:colors.third, a:colors.bg, 'NONE')
  call s:hi('Pmenu', a:colors.fg, a:colors.subbg, 'NONE')
  call s:hi('PmenuSel', a:colors.bg, a:colors.fg, 'NONE')
  call s:hi('SpecialKey', a:colors.bg, a:colors.subbg, 'NONE')

  call s:hi('Folded', a:colors.fg, a:colors.comment, 'NONE')
  call s:hi('FoldColumn', a:colors.fg, a:colors.bg, 'NONE')

  call s:hi('TabLineSel', a:colors.fg, a:colors.bg, 'NONE')
  call s:hi('TabLine', a:colors.comment, a:colors.subbg, 'NONE')
  call s:hi('TabLineFill', a:colors.comment, a:colors.subbg, 'NONE')

  call s:hi('StatusLine', a:colors.fg, a:colors.subbg, 'NONE')
  call s:hi('StatusLineNC', a:colors.subbg, a:colors.bg, 'NONE')

  " ###########################################

  " Git Gutter
  call s:hi('GitGutterAdd', a:colors.green, a:colors.bg, 'NONE')
  call s:hi('GitGutterChange', a:colors.yellow, a:colors.bg, 'NONE')
  call s:hi('GitGutterDelete', a:colors.red, a:colors.bg, 'NONE')
  call s:hi('GitGutterChangeDelete', a:colors.yellow, a:colors.bg, 'NONE')

  " Python syntax highlighting
  call s:hi('pythonBuiltin', a:colors.third, a:colors.bg, 'NONE')
  call s:hi('pythonDecoratorName', a:colors.third, a:colors.bg, 'NONE')
  call s:hi('pythonDecorator', a:colors.third, a:colors.bg, 'NONE')
  call s:hi('pythonOperator', a:colors.fg, a:colors.bg, 'NONE')
  call s:hi('jinjaTagDelim', a:colors.third, a:colors.bg, 'NONE')
  call s:hi('jinjaVarBlock', a:colors.third, a:colors.bg, 'NONE')
  call s:hi('jinjaStatement', a:colors.third, a:colors.bg, 'NONE')
  call s:hi('jinjaBlockName', a:colors.fg, a:colors.bg, 'NONE')
  call s:hi('jinjaVariable', a:colors.fg, a:colors.bg, 'NONE')
  call s:hi('jinjaString', a:colors.third, a:colors.bg, 'NONE')
  call s:hi('jinjaOperator', a:colors.fg, a:colors.bg, 'NONE')

  " PHP
  call s:hi('phpDefine', a:colors.fg, a:colors.bg, 'NONE')
  call s:hi('phpIdentifier', a:colors.fg, a:colors.bg, 'NONE')
  call s:hi('phpVarSelector', a:colors.fg, a:colors.bg, 'NONE')
  call s:hi('bladeKeyword', a:colors.third, a:colors.bg, 'NONE')

  " Javascript
  call s:hi('jsNull', a:colors.third, a:colors.bg, 'NONE')
  call s:hi('jsUndefined', a:colors.third, a:colors.bg, 'NONE')
  call s:hi('jsFunction', a:colors.fg, a:colors.bg, 'NONE')
  call s:hi('jsFuncName', a:colors.second, a:colors.bg, 'NONE')
  call s:hi('jsArrowFunction', a:colors.fg, a:colors.bg, 'NONE')
  call s:hi('jsonKeyword', a:colors.fg, a:colors.bg, 'NONE')

  " Typescript
  call s:hi('typescriptBraces', a:colors.fg, a:colors.bg, 'NONE')
  call s:hi('typescriptDecorator', a:colors.subbg, a:colors.bg, 'NONE')
  call s:hi('typescriptImport', a:colors.fg, a:colors.bg, 'NONE')
  call s:hi('typescriptExport', a:colors.fg, a:colors.bg, 'NONE')

  " Java
  call s:hi('javaAnnotation', a:colors.subbg, a:colors.bg, 'NONE')

  " HTML
  call s:hi('htmlTagName', a:colors.fg, a:colors.bg, 'NONE')
  call s:hi('htmlTag', a:colors.fg, a:colors.bg, 'NONE')
  call s:hi('htmlArg', a:colors.subbg, a:colors.bg, 'NONE')

  " CSS
  call s:hi('cssProp', a:colors.fg, a:colors.bg, 'NONE')
  call s:hi('cssBraces', a:colors.fg, a:colors.bg, 'NONE')

  " Ruby
  call s:hi('rubyModule', a:colors.fg, a:colors.bg, 'NONE')
  call s:hi('rubyDefine', a:colors.fg, a:colors.bg, 'NONE')
  call s:hi('rubyClass', a:colors.fg, a:colors.bg, 'NONE')
  call s:hi('rubyFunction', a:colors.fg, a:colors.bg, 'NONE')

  " Clojure
  call s:hi('clojureSpecial', a:colors.fg, a:colors.bg, 'NONE')
  call s:hi('clojureDefine', a:colors.fg, a:colors.bg, 'NONE')
  call s:hi('clojureKeyword', a:colors.fg, a:colors.bg, 'NONE')

  " Vimscript syntax highlighting
  call s:hi('vimOption', a:colors.fg, a:colors.bg, 'NONE')
  call s:link('vimFunction', 'Function')
  call s:link('vimUserFunc', 'Function')
  call s:link('vimVar', 'Identifier')

  " NERDTree
  call s:hi('NERDTreeClosable', a:colors.third, a:colors.bg, 'NONE')
  call s:hi('NERDTreeOpenable', a:colors.third, a:colors.bg, 'NONE')
endfunction

