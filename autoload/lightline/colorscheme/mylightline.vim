
fu! s:gethi(attr, color) abort
  "todo: 256colorにも対応する
  let attrs = [a:attr, 'Normal', 'Comment']
  for item in attrs
    let res = synIDattr(synIDtrans(hlID(item)), a:color)
    if res != '' | return res | endif
  endfor
  return '#888888'
endf


let s:Nb   = [ s:gethi('Normal',       'bg#'), 235 ]
let s:Nf   = [ s:gethi('Normal',       'fg#'), 235 ]
let s:lnb  = [ s:gethi('LineNr',       'bg#'), 235 ]
let s:If   = [ s:gethi('Identifier',   'fg#'), 235 ]
let s:CLb  = [ s:gethi('CursorLine',   'bg#'), 235 ]
let s:Sf   = [ s:gethi('String',       'fg#'), 235 ]
let s:Df   = [ s:gethi('Define',       'fg#'), 235 ]
let s:Stf  = [ s:gethi('Statement',    'fg#'), 235 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left     = [ [s:Nb, s:If, 'bold'], [s:Nf, s:CLb ] ]
let s:p.normal.right    = [ [s:Nb, s:If, 'bold'], [s:Nf, s:CLb ] ]
let s:p.normal.middle   = [ [ s:Nf, s:CLb ] ]
let s:p.insert.left     = [ [s:Nb, s:Sf, 'bold'], [s:Nf, s:CLb ] ]
let s:p.insert.right    = [ [s:Nb, s:Sf, 'bold'], [s:Nf, s:CLb ] ]
""let s:p.insert.middle   = s:p.normal.middle
let s:p.replace.left    = [ [s:Nb, s:Df, 'bold'], [s:Nf, s:CLb ] ]
let s:p.replace.right   = [ [s:Nb, s:Df, 'bold'], [s:Nf, s:CLb ] ]
""let s:p.replace.middle  = s:p.normal.middle
let s:p.visual.left     = [ [s:Nb, s:Stf, 'bold'], [s:Nf, s:CLb ] ]
let s:p.visual.right    = [ [s:Nb, s:Stf, 'bold'], [s:Nf, s:CLb ] ]
""let s:p.visual.middle   = s:p.normal.middle
let s:p.inactive.left   = [ [s:Nf, s:CLb ], [s:Nf, s:CLb ] ]
let s:p.inactive.right  = s:p.inactive.left[1:]
let s:p.inactive.middle = [ [s:Nf, s:CLb ] ]

let s:p.tabline.left = [ [ s:Nb, s:Nf ] ]
let s:p.tabline.tabsel = [ [ s:Nb, s:Nf ] ]
let s:p.tabline.middle = [ [ s:Nb, s:Nf ] ]
let s:p.tabline.right = [ [ s:Nb, s:Nf ] ]
let s:p.normal.error = [ [ 'gray9', 'brightestred' ] ]
let s:p.normal.warning = [ [ 'gray1', 'yellow' ] ]

" ------------------------------------------------------------

let s:base03 = [ '#242424', 235 ]
let s:base023 = [ '#353535', 236 ]
let s:base02 = [ '#444444', 238 ]
let s:base01 = [ '#585858', 240 ]
let s:base00 = [ '#666666', 242  ]
let s:base0 = [ '#808080', 244 ]
let s:base1 = [ '#969696', 247 ]
let s:base2 = [ '#a8a8a8', 248 ]
let s:base3 = [ '#d0d0d0', 252 ]
let s:yellow = [ '#CAE682', 180 ]
let s:orange = [ '#E5786D', 173 ]
let s:red = [ '#E5786D', 203 ]
let s:magenta = [ '#F2C68A', 216 ]
let s:blue = [ '#8AC6F2', 117 ]
let s:cyan = s:blue
let s:green = [ '#95E454', 119 ]

"let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
"let s:p.normal.left = [ [ s:base02, s:blue ], [ s:base3, s:base01 ] ]
"let s:p.normal.right = [ [ s:base02, s:base0 ], [ s:base1, s:base01 ] ]
"let s:p.inactive.right = [ [ s:base023, s:base01 ], [ s:base00, s:base02 ] ]
"let s:p.inactive.left =  [ [ s:base1, s:base02 ], [ s:base00, s:base023 ] ]
"let s:p.insert.left = [ [ s:base02, s:green ], [ s:base3, s:base01 ] ]
"let s:p.replace.left = [ [ s:base023, s:red ], [ s:base3, s:base01 ] ]
"let s:p.visual.left = [ [ s:base02, s:magenta ], [ s:base3, s:base01 ] ]
"let s:p.normal.middle = [ [ s:base2, s:base02 ] ]
"let s:p.inactive.middle = [ [ s:base1, s:base023 ] ]

let s:p.tabline.left = [ [ s:base3, s:base00 ] ]
let s:p.tabline.tabsel = [ [ s:base3, s:base03 ] ]
let s:p.tabline.middle = [ [ s:base2, s:base02 ] ]
let s:p.tabline.right = [ [ s:base2, s:base00 ] ]
let s:p.normal.error = [ [ s:base03, s:red ] ]
let s:p.normal.warning = [ [ s:base023, s:yellow ] ]

let g:lightline#colorscheme#mylightline#palette = lightline#colorscheme#flatten(s:p)
