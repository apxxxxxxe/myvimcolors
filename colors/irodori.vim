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
  let g:irodori#fg_tones = ['dkg', 'dk', 'dp', 'g', 'd', 's', 'v', 'ltg', 'sf', 'b', 'lt', 'p']
endif
if !exists('g:irodori#patterns')
  let g:irodori#patterns = ['dominant_color', 'tone_on_tone', 'dominant_tone', 'tone_in_tone']
endif
if !exists('g:irodori#bg_tones')
  " this must be sorted from light to dark
  let g:irodori#bg_tones = ['p', 'lt', 'b', 'sf', 'ltg', 'v', 's', 'd', 'g', 'dp', 'dk', 'dkg']
endif
if !exists('g:irodori#statement_bold')
  let g:irodori#statement_bold = 1
endif
if !exists('g:irodori#contrast')
  let g:irodori#contrast = 1.0
endif

let s:seed = srand()

" ----------------------------------------------------------------
" culculate and apply colors
" ----------------------------------------------------------------
let s:idx = irodori#adjust_hue(rand(s:seed)%12*2)
let s:pccs = g:irodori#fg_tones[rand(s:seed)%len(g:irodori#fg_tones)] .. s:idx
let s:pattern  = g:irodori#patterns[rand(s:seed)%len(g:irodori#patterns)]
let s:FIRST    = g:irodori#pccs[s:pccs]

let g:irodori#emem = s:pccs .. '/' .. s:pattern

call irodori#highlights(irodori#culculate_colors(s:FIRST, s:pattern))
