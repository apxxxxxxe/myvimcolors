" ----------------------------------------------------------------
" manual paramaters
" ----------------------------------------------------------------
let s:contrast = 1.0

if !exists('g:statement_bold')
  let g:statement_bold = 1
endif

" ----------------------------------------------------------------
" load myvimcolors
" ----------------------------------------------------------------
if !exists('g:loaded_myvimcolors')
  runtime plugin/myvimcolors.vim
endif
if !exists('g:autoloaded_myvimcolors')
  runtime autoload/myvimcolors.vim
endif

" ----------------------------------------------------------------
" setup
" ----------------------------------------------------------------
let g:colors_name = 'gentle'

let s:tones = ['dkg', 'dk', 'dp', 'g', 'd', 's', 'v', 'ltg', 'sf', 'b', 'lt', 'p']
let s:patterns = ['dominant_color', 'tone_on_tone', 'dominant_tone', 'tone_in_tone']
let s:seed = srand()

let s:idx = myvimcolors#adjust_hue(rand(s:seed)%12*2)
let s:pccs = s:tones[rand(s:seed)%len(s:tones)] .. s:idx
let s:pattern  = s:patterns[rand(s:seed)%len(s:patterns)]
let s:FIRST    = g:myvimcolors#pccs[s:pccs] " Statement,Type

" ----------------------------------------------------------------
" culculated colors
" ----------------------------------------------------------------
let s:BG = myvimcolors#find_suite_contrast(s:FIRST, 125)

if myvimcolors#rgb2hsl(s:BG)[2] < 50
  set background=dark
  let s:isdark = 1
else
  set background=light
  let s:isdark = -1
endif

let s:palette = myvimcolors#palette(s:pattern, s:FIRST, s:isdark)
let s:SECOND     = s:palette[0]
let s:THIRD      = s:palette[1]
let s:FOURTH     = s:palette[2]
let s:FIFTH      = s:palette[3]
let s:SIXTH      = s:palette[4]
if len(s:pattern) == 6
  let s:BG         = s:palette[5]
endif

let s:SUBBG     = myvimcolors#adjust_hex(s:BG, float2nr(s:isdark * 7.5 * s:contrast))
let s:COMMENT    = myvimcolors#adjust_hex(s:BG, float2nr(s:isdark * 40 * s:contrast))
let s:MATCHPAREN = myvimcolors#opposite(s:BG)
let s:LINENR     = myvimcolors#adjust_hex(s:BG, float2nr(s:isdark * 20 * s:contrast))

let s:bg_hsl = myvimcolors#rgb2hsl(s:BG)
let s:FG         = myvimcolors#hsl2rgb(s:bg_hsl[0], s:bg_hsl[1], myvimcolors#clump(100 - s:bg_hsl[2], 30, 70))

let s:first_hsl = myvimcolors#rgb2hsl(s:FIRST)
let s:GREEN = myvimcolors#hsl2rgb(120, s:first_hsl[1], s:first_hsl[2])
let s:YELLOW = myvimcolors#hsl2rgb(50, s:first_hsl[1], s:first_hsl[2])
let s:RED = myvimcolors#hsl2rgb(0, s:first_hsl[1], s:first_hsl[2])

call myvimcolors#highlights(#{
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
      \})
let g:myvimcolors#emem = s:pccs .. '/' .. s:pattern
