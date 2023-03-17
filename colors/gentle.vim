" ----------------------------------------------------------------
" manual colors and paramaters
" ----------------------------------------------------------------
let g:colors_name = 'gentle'

let s:FIRST    = g:myvimcolors#pccs['dp8'] " Statement,Type
let s:pattern  = 'tone_in_tone'
let s:contrast = 1.0

if !exists('g:statement_bold')
  let g:statement_bold = 1
endif

" ----------------------------------------------------------------
" culculated colors
" ----------------------------------------------------------------
let s:BG = myvimcolors#find_suite_contrast(s:FIRST, 125)

if s:pattern != ''
  let s:palette = myvimcolors#palette(s:pattern, s:FIRST, s:BG)
  let s:SECOND     = s:palette[0]
  let s:THIRD      = s:palette[1]
  let s:FOURTH     = s:palette[2]
  let s:FIFTH      = s:palette[3]
  let s:SIXTH      = s:palette[4]
else
  let s:SECOND     = g:myvimcolors#pccs['Gy-9.5'] " Number,Float,Boolean
  let s:THIRD      = g:myvimcolors#pccs['Gy-8.5'] " String,CursorLineNr
  let s:FOURTH     = g:myvimcolors#pccs['Gy-7.5'] " Function
  let s:FIFTH      = g:myvimcolors#pccs['Gy-6.5'] " Special
  let s:SIXTH      = g:myvimcolors#pccs['Gy-5.5'] " PreProc,Operator
endif

if myvimcolors#rgb2hsl(s:BG)[2] < 50
  set background=dark
  let s:isdark = 1
else
  set background=light
  let s:isdark = -1
endif

let s:first_hsl = myvimcolors#rgb2hsl(s:FIRST)
let s:GREEN = myvimcolors#hsl2rgb(120, s:first_hsl[1], s:first_hsl[2])
let s:YELLOW = myvimcolors#hsl2rgb(50, s:first_hsl[1], s:first_hsl[2])
let s:RED = myvimcolors#hsl2rgb(0, s:first_hsl[1], s:first_hsl[2])

let s:bg_hsl = myvimcolors#rgb2hsl(s:BG)
let s:FG         = myvimcolors#hsl2rgb(s:bg_hsl[0], s:bg_hsl[1], myvimcolors#clump(100 - myvimcolors#rgb2hsl(s:BG)[2], 20, 80))
let s:SUBBG     = myvimcolors#adjust_hex(s:BG, float2nr(s:isdark * 7.5 * s:contrast))
let s:COMMENT    = myvimcolors#adjust_hex(s:BG, float2nr(s:isdark * 40 * s:contrast))
let s:MATCHPAREN = myvimcolors#opposite(s:BG)
let s:LINENR     = myvimcolors#adjust_hex(s:BG, float2nr(s:isdark * 20 * s:contrast))

let s:colors = #{
      \  fg:         s:FG,
      \  bg:         s:BG,
      \  comment:    s:COMMENT,
      \  first:      s:FIRST,
      \  second:     s:SECOND,
      \  third:      s:THIRD,
      \  fourth:     s:FOURTH,
      \  fifth:      s:FIFTH,
      \  sixth:      s:SIXTH,
      \  red:        s:RED,
      \  green:      s:GREEN,
      \  yellow:     s:YELLOW,
      \  subbg:      s:SUBBG,
      \  linenr:     s:LINENR,
      \  matchparen: s:MATCHPAREN,
      \}

call myvimcolors#highlights(s:colors)
