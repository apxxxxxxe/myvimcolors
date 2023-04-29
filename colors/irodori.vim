" ----------------------------------------------------------------
" load irodori
" ----------------------------------------------------------------
if !exists('g:loaded_irodori')
  runtime plugin/irodori.vim
endif
if !exists('g:autoloaded_irodori')
  runtime autoload/irodori.vim
endif

" ----------------------------------------------------------------
" setup
" ----------------------------------------------------------------
let g:colors_name = 'irodori'

if !exists('g:irodori#fg_tones')
  " this must be sorted from light to dark
  let g:irodori#fg_tones = ['dkg', 'dk', 'dp', 'g', 'd', 's', 'v', 'ltg', 'sf', 'b', 'lt', 'p']
endif
if !exists('g:irodori#patterns')
  let g:irodori#patterns = ['dominant_color', 'tone_on_tone', 'dominant_tone', 'tone_in_tone']
endif
if !exists('g:irodori#bg_tones')
  let g:irodori#bg_tones = ['p', 'lt', 'b', 'sf', 'ltg', 'v', 's', 'd', 'g', 'dp', 'dk', 'dkg']
endif
if !exists('g:irodori#statement_bold')
  let g:irodori#statement_bold = 1
endif
if !exists('g:irodori#contrast')
  let g:irodori#contrast = 1.0
endif
if !exists('g:irodori#monotone_bg_possibility')
  " min=0, max=99
  let g:irodori#monotone_bg_possibility = 33
endif

let s:seed = srand()

" ----------------------------------------------------------------
" calculate and apply colors
" ----------------------------------------------------------------
let s:pccs = irodori#random_tone(g:irodori#bg_tones)
let s:pattern  = g:irodori#patterns[rand(s:seed)%len(g:irodori#patterns)]
let s:BG    = g:irodori#pccs[s:pccs]

if rand(s:seed) % 100 < g:irodori#monotone_bg_possibility
  let s:bg_info = irodori#rgb2hsl(s:BG)
  let s:BG = irodori#hsl2rgb(s:bg_info[0], 0, s:bg_info[2])
endif

let g:irodori#emem = s:pccs .. '/' .. s:pattern

call irodori#highlights(irodori#calculate_colors(s:BG, s:pattern))
