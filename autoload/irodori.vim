if exists('g:autoloaded_irodori')
  finish
endif
let g:autoloaded_irodori = 1

function! irodori#random_tone(candidates)
  let l:seed = srand()
  let l:tone = a:candidates[rand(l:seed)%len(a:candidates)]
  if l:tone =~ 'Gy-'
    return l:tone
  else
    let l:idx = irodori#adjust_hue(rand(l:seed)%12*2)
    return l:tone .. l:idx
  endif
endfunction

function! irodori#calculate_colors(bg, pattern)
  let l:FIRST = irodori#find_suite_contrast(a:bg, 125)

  if irodori#rgb2hsl(a:bg)[2] < 50
    set background=dark
    let l:isdark = 1
  else
    set background=light
    let l:isdark = -1
  endif

  let l:palette = irodori#palette(a:pattern, l:FIRST, a:bg, l:isdark)
  let l:SECOND     = l:palette[0]
  let l:THIRD      = l:palette[1]
  let l:FOURTH     = l:palette[2]
  let l:FIFTH      = l:palette[3]
  let l:SIXTH      = l:palette[4]

  if rand(srand()) % 100 < g:irodori#monotone_bg_possibility
    let l:bg_info = irodori#rgb2hsl(a:bg)
    let l:BG = irodori#hsl2rgb(l:bg_info[0], 0, l:bg_info[2])
  else
    let l:BG = a:bg
  endif

  let l:SUBBG     = irodori#adjust_hex(l:BG, float2nr(l:isdark * 7.5 * g:irodori#contrast))
  let l:COMMENT    = irodori#adjust_hex(l:BG, float2nr(l:isdark * 40 * g:irodori#contrast))
  let l:MATCHPAREN = irodori#opposite(l:BG)
  let l:LINENR     = irodori#adjust_hex(l:BG, float2nr(l:isdark * 20 * g:irodori#contrast))

  let l:bg_hsl = irodori#rgb2hsl(l:BG)
  let l:FG         = irodori#hsl2rgb(l:bg_hsl[0], l:bg_hsl[1], irodori#clump(100 - l:bg_hsl[2], 30, 70))

  let l:first_hsl = irodori#rgb2hsl(l:FIRST)
  let l:GREEN = irodori#hsl2rgb(120, l:first_hsl[1], l:first_hsl[2])
  let l:YELLOW = irodori#hsl2rgb(50, l:first_hsl[1], l:first_hsl[2])
  let l:RED = irodori#hsl2rgb(0, l:first_hsl[1], l:first_hsl[2])

  return #{
        \  fg:         l:FG,
        \  bg:         l:BG,
        \  comment:    l:COMMENT,
        \  first:      l:FIRST,
        \  second:     l:SECOND,
        \  third:      l:THIRD,
        \  fourth:     l:FOURTH,
        \  fifth:      l:FIFTH,
        \  sixth:      l:SIXTH,
        \  red:        l:RED,
        \  green:      l:GREEN,
        \  yellow:     l:YELLOW,
        \  subbg:      l:SUBBG,
        \  linenr:     l:LINENR,
        \  matchparen: l:MATCHPAREN,
        \}
endfunction

function! irodori#adjust_hue(idx)
  let l:res = a:idx % 24
  return l:res == 0 ? 24 : l:res
endfunction

" 24, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22
let s:pccs_hue = [330, 344, 19, 37, 53, 66, 153, 181, 201, 209, 251, 300]

function! irodori#pccs2idx(pccs)
  return str2nr(matchstr(a:pccs, '[0-9]\+'))
endfunction

function! irodori#idx2hue(idx)
  let l:idx = a:idx % 24 / 2
  return s:pccs_hue[l:idx]
endfunction

function! irodori#hue_info(hue)
  let l:min = 360
  let l:min_idx = -1
  for l:i in range(len(s:pccs_hue))
    let l:m = abs(a:hue-s:pccs_hue[l:i])
    if l:m < l:min
      let l:min = l:m
      let l:min_idx = l:i
    endif
  endfor
  return {
        \ 'index': l:min_idx == 0 ? 24 : l:min_idx*2,
        \ 'hue'  : s:pccs_hue[l:min_idx],
        \}
endfunction

" 値を最小値と最大値の範囲に収める
function! irodori#clump(value, min, max)
  if a:value < a:min
    return a:min
  elseif a:value > a:max
    return a:max
  else
    return a:value
  endif
endfunction

" 輝度を加算して返す
function! irodori#adjust_hex(hex, num)
  let l:hex_hsl = irodori#rgb2hsl(a:hex)
  return irodori#hsl2rgb(l:hex_hsl[0], l:hex_hsl[1], irodori#clump(l:hex_hsl[2] + a:num, 0, 100))
endfunction

" 反対色を返す
function! irodori#opposite(hex)
  let l:r = 255 - str2nr(strpart(a:hex, 1, 2), 16)
  let l:g = 255 - str2nr(strpart(a:hex, 3, 2), 16)
  let l:b = 255 - str2nr(strpart(a:hex, 5, 2), 16)

  return printf("#%02x%02x%02x", l:r, l:g, l:b)
endfunction

function! irodori#ary2hex(R,G,B) abort
  return printf("#%02x%02x%02x", a:R, a:G, a:B)
endfunction

function! irodori#hex2ary(hex) abort
  let l:r = str2nr(strpart(a:hex, 1, 2), 16)
  let l:g = str2nr(strpart(a:hex, 3, 2), 16)
  let l:b = str2nr(strpart(a:hex, 5, 2), 16)
  return [l:r, l:g, l:b]
endfunction

function! irodori#hsl2rgb(H, S, L) abort
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
function! irodori#get_contrast(a,b)
  let l:a = irodori#hex2ary(a:a)
  let l:b = irodori#hex2ary(a:b)
  return abs(((l:a[0]-l:b[0])*299.0 + (l:a[1]-l:b[1])*587.0 + (l:a[2]-l:b[2])*114.0) / 1000)
endfunction

function! irodori#filter_suite_contrast(hex, idx, threshold)
  let l:tones = ['p', 'lt', 'b', 'sf', 'ltg', 'v', 's', 'd', 'g', 'dp', 'dk', 'dkg']
  let l:result = []

  for tone in l:tones
    let l:col = g:irodori#pccs[tone .. a:idx]
    if irodori#get_contrast(a:hex, l:col) > a:threshold
      let l:result += [l:col]
    endif
  endfor

  if len(l:result) < 5 
    if len(l:result) > 0
      while len(l:result) < 5
        let l:result += [l:result[rand(srand())%len(l:result)]]
      endwhile
    endif
  endif

  return l:result
endfunction

function! irodori#find_suite_contrast(hex, threshold)
  let l:best_s = 0
  let l:best_contrast = 0
  let l:best_color = ''

  let l:normal_range = g:irodori#fg_tones
  let l:hex_hsl = irodori#rgb2hsl(a:hex)
  if l:hex_hsl[2] < 50
    let l:mono_range = range(1,9)
  else
    let l:mono_range = range(9,1,-1)
    let l:normal_range_inverted = []
    for i in range(len(l:normal_range))
      let l:normal_range_inverted += [l:normal_range[len(l:normal_range)-i-1]]
    endfor
    let l:normal_range = l:normal_range_inverted
  endif

  " normal colors
  let l:hue_idx = irodori#adjust_hue(irodori#hue_info(l:hex_hsl[0])['index']+12)
  for tone in l:normal_range
    let l:col = g:irodori#pccs[tone .. l:hue_idx]
    let l:con = irodori#get_contrast(a:hex, l:col)
    let l:sat = irodori#rgb2hsl(l:col)[1]
    if l:con > l:best_contrast && l:sat > l:best_s
      let l:best_s = l:sat
      let l:best_contrast = l:con
      let l:best_color = l:col
    endif
  endfor

  " monotone colors
  if l:best_contrast < a:threshold
    for i in l:mono_range
      let l:col = g:irodori#pccs['Gy-' .. i .. '.5']
      let l:con = irodori#get_contrast(a:hex, l:col)
      if l:con > l:best_contrast
        let l:best_contrast = l:con
        let l:best_color = l:col
        if l:best_contrast >= a:threshold
          break
        endif
      endif
    endfor
  endif

  return l:best_color
endfunction

function! irodori#rgb2hsl(hex) abort
  let l:hex = irodori#hex2ary(a:hex)
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

function! irodori#palette(pattern, accent_color, bg, isdark)
  let l:accent_hsl = irodori#rgb2hsl(a:accent_color)
  let l:accent_info = irodori#hue_info(l:accent_hsl[0])
  if a:pattern == 'dominant_color'
    " 'dominant_color' : トーン・色相固定
    for t in range(125, 75, -25)
      let l:colors = irodori#filter_suite_contrast(a:bg, l:accent_info['index'], t)
      if len(l:colors) >= 5
        break
      endif
    endfor

    if len(l:colors) < 5
      throw 'error while irodori: not enough suite contrasts'
    endif

    return l:colors
  elseif a:pattern == 'dominant_tone'
    let l:hue_idx = irodori#hue_info(l:accent_hsl[0])['index']
    let l:res = [
          \  irodori#hsl2rgb(irodori#idx2hue(irodori#adjust_hue(l:hue_idx +  4)), l:accent_hsl[1], l:accent_hsl[2]),
          \  irodori#hsl2rgb(irodori#idx2hue(irodori#adjust_hue(l:hue_idx +  8)), l:accent_hsl[1], l:accent_hsl[2]),
          \  irodori#hsl2rgb(irodori#idx2hue(irodori#adjust_hue(l:hue_idx + 12)), l:accent_hsl[1], l:accent_hsl[2]),
          \  irodori#hsl2rgb(irodori#idx2hue(irodori#adjust_hue(l:hue_idx + 16)), l:accent_hsl[1], l:accent_hsl[2]),
          \  irodori#hsl2rgb(irodori#idx2hue(irodori#adjust_hue(l:hue_idx + 20)), l:accent_hsl[1], l:accent_hsl[2]),
          \]
    if a:isdark == 1
      return l:res + [g:irodori#pccs['Gy-1.5']]
    else
      return l:res + [g:irodori#pccs['Gy-9.5']]
    endif
  elseif a:pattern == 'tone_in_tone'
    " 'tone_in_tone' : トーン固定
    return [
          \  irodori#hsl2rgb((l:accent_hsl[0] + (360/24* 0))%360, l:accent_hsl[1], irodori#clump(l:accent_hsl[2]*(1.0-a:isdark*(-0.2)), 0, 100)),
          \  irodori#hsl2rgb((l:accent_hsl[0] + (360/24* 0))%360, l:accent_hsl[1], irodori#clump(l:accent_hsl[2]*(1.0-a:isdark*( 0.2)), 0, 100)),
          \  irodori#hsl2rgb((l:accent_hsl[0] + (360/24*12))%360, 50, l:accent_hsl[2]),
          \  irodori#hsl2rgb((l:accent_hsl[0] + (360/24*12))%360, 50, irodori#clump(l:accent_hsl[2]*(1.0-a:isdark*( 0.2)), 0, 100)),
          \  irodori#hsl2rgb((l:accent_hsl[0] + (360/24*12))%360, 50, irodori#clump(l:accent_hsl[2]*(1.0-a:isdark*(-0.2)), 0, 100)),
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

function! irodori#highlights(colors)
  if irodori#rgb2hsl(a:colors.bg)[2] < 50
    set background=dark
  else
    set background=light
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
  call s:hi('Statement', a:colors.first, 'NONE', g:irodori#statement_bold ? 'BOLD' : 'NONE')
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
  call s:hi('Error', a:colors.bg, a:colors.red, 'underline')
  call s:hi('ErrorMsg', a:colors.bg, a:colors.red, 'NONE')
  call s:hi('Question', a:colors.third, a:colors.bg, 'NONE')
  call s:hi('WarningMsg', a:colors.bg, a:colors.yellow, 'NONE')
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

