if exists('g:loaded_myvimcolors')
  " finish
endif
let g:loaded_myvimcolors = 1

" tones
let g:myvimcolors#tone_v    = #{S: 100, L:  50}
let g:myvimcolors#tone_b    = #{S:  80, L:  75}
let g:myvimcolors#tone_s    = #{S:  80, L:  50}
let g:myvimcolors#tone_dp   = #{S:  80, L:  25}
let g:myvimcolors#tone_lt   = #{S:  70, L:  80}
let g:myvimcolors#tone_sf   = #{S:  70, L:  75}
let g:myvimcolors#tone_d    = #{S:  70, L:  40}
let g:myvimcolors#tone_dk   = #{S:  70, L:  25}
let g:myvimcolors#tone_p    = #{S:  50, L:  80}
let g:myvimcolors#tone_ltg  = #{S:  50, L:  60}
let g:myvimcolors#tone_g    = #{S:  50, L:  40}
let g:myvimcolors#tone_W    = #{S:   0, L: 100}
let g:myvimcolors#tone_ltGy = #{S:   0, L:  80}
let g:myvimcolors#tone_mGy  = #{S:   0, L:  50}
let g:myvimcolors#tone_dkGy = #{S:   0, L:  20}
let g:myvimcolors#tone_Bk   = #{S:   0, L:   5}

function! myvimcolors#tone2rgb(H, tone)
  return myvimcolors#hsl2rgb(a:H, a:tone.S, a:tone.L)
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
