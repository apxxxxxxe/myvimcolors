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
let g:colors_name = 'chameleon'

if !exists('g:myvimcolors#fg_tones')
  let g:myvimcolors#fg_tones = ['dkg', 'dk', 'dp', 'g', 'd', 's', 'v', 'ltg', 'sf', 'b', 'lt', 'p']
endif
if !exists('g:myvimcolors#patterns')
  let g:myvimcolors#patterns = ['dominant_color', 'tone_on_tone', 'dominant_tone', 'tone_in_tone']
endif
if !exists('g:myvimcolors#bg_tones')
  let g:myvimcolors#bg_tones = ['dkg', 'dk', 'dp', 'g', 'd', 's', 'v', 'ltg', 'sf', 'b', 'lt', 'p']
endif
if !exists('g:myvimcolors#statement_bold')
  let g:myvimcolors#statement_bold = 1
endif
if !exists('g:myvimcolors#contrast')
  let g:myvimcolors#contrast = 1.0
endif

let s:seed = srand()

" ----------------------------------------------------------------
" culculate and apply colors
" ----------------------------------------------------------------
let s:idx = myvimcolors#adjust_hue(rand(s:seed)%12*2)
let s:pccs = g:myvimcolors#fg_tones[rand(s:seed)%len(g:myvimcolors#fg_tones)] .. s:idx
let s:pattern  = g:myvimcolors#patterns[rand(s:seed)%len(g:myvimcolors#patterns)]
let s:FIRST    = g:myvimcolors#pccs[s:pccs] " Statement,Type

let g:myvimcolors#emem = s:pccs .. '/' .. s:pattern

call myvimcolors#highlights(myvimcolors#culculate_colors(s:FIRST, s:pattern))
