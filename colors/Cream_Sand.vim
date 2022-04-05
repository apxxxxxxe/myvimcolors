" Vim color file
" Cream_Sand
" Created with ThemeCreator (https://github.com/mswift42/themecreator)

hi clear

if exists("syntax on")
  syntax reset
endif

set t_Co=256
let g:colors_name = "Cream_Sand"


let s:whip = "#efe5da"
let s:puff = "#ded7c3"
let s:cream = "#d4ccb9"
let s:butter = "#c5baa8"
let s:choco_powder = "#aa908d"

let s:coffee = "#6d4a45"
let s:cocoa = "#65565b"
let s:choco = "#45363b"

let s:berry = "#ce3654"
let s:rosemary = "#738450"
let s:pastry = "#dec076"
let s:greap = "#4a457d"

" Define reusable colorvariables.
let s:bg2 = "#949890"
let s:bg3 = "#878b84"
let s:bg4 = "#7a7d77"
let s:fg2 = "#534843"
let s:fg3 = "#635853"
let s:fg4 = "#736863"

let s:keyword = s:coffee
let s:builtin = s:berry
let s:const = s:rosemary
let s:func = s:berry
let s:str = s:coffee
let s:type = s:berry
let s:var = s:rosemary

let s:comment = "#a19794"
let s:comment = s:choco_powder
let s:warning = "#ff0000"
let s:warning2 = "#ff3f00"

exe 'hi Search guifg='s:cream' guibg='s:type
exe 'hi! link IncSearch Search'
exe 'hi! link MatchParen Search'
exe 'hi TabLineSel guifg='s:choco' guibg='s:whip' gui=bold cterm=bold'
exe 'hi TabLine guifg='s:cream' guibg='s:cocoa
exe 'hi TabLineFill guifg='s:choco' guibg='s:whip

exe 'hi Normal guifg='s:choco' guibg='s:cream
exe 'hi Cursor guifg='s:cream' guibg='s:cocoa
exe 'hi CursorLine  guibg='s:puff' gui=NONE cterm=NONE'
exe 'hi CursorLineNr guifg='s:berry' guibg='s:whip' gui=bold cterm=bold'
exe 'hi CursorColumn  guibg='s:butter
exe 'hi ColorColumn  guibg='s:butter
exe 'hi LineNr guifg='s:cream' guibg='s:choco
exe 'hi VertSplit guifg='s:fg3' guibg='s:bg3
" exe 'hi MatchParen guifg='s:builtin'  gui=underline cterm=underline'
exe 'hi StatusLine guifg='s:cocoa' guibg='s:whip' gui=bold cterm=bold'
exe 'hi Pmenu guifg='s:choco' guibg='s:bg2
exe 'hi PmenuSel  guibg='s:bg3
" exe 'hi IncSearch guifg='s:cream' guibg='s:keyword
" exe 'hi Search   gui=underline cterm=underline'
exe 'hi Directory guifg='s:const
exe 'hi Folded guifg='s:fg4' guibg='s:cream
exe 'hi WildMenu guifg='s:str' guibg='s:cream

exe 'hi Boolean guifg='s:const
exe 'hi Character guifg='s:const
exe 'hi Comment guifg='s:comment' guibg='s:cream' gui=italic cterm=NONE'
exe 'hi Conditional guifg='s:keyword
exe 'hi Constant guifg='s:const
exe 'hi Todo guibg='s:cream
exe 'hi Define guifg='s:keyword
exe 'hi DiffAdd guifg=#fafafa guibg=#123d0f gui=bold cterm=bold'
exe 'hi DiffDelete guibg='s:bg2
exe 'hi DiffChange  guibg=#151b3c guifg=#fafafa'
exe 'hi DiffText guifg=#ffffff guibg=#ff0000 gui=bold cterm=bold'
exe 'hi ErrorMsg guifg='s:warning' guibg='s:bg2' gui=bold cterm=bold'
exe 'hi WarningMsg guifg='s:choco' guibg='s:warning2
exe 'hi Float guifg='s:const
exe 'hi Function guifg='s:func' gui=NONE'
exe 'hi Identifier guifg='s:type
exe 'hi Keyword guifg='s:keyword
exe 'hi Label guifg='s:var
exe 'hi NonText guifg='s:comment
exe 'hi Number guifg='s:const
exe 'hi Operator guifg='s:keyword
exe 'hi PreProc guifg='s:keyword
exe 'hi Special guifg='s:choco
exe 'hi SpecialKey guifg='s:fg2' guibg='s:bg2
exe 'hi Statement guifg='s:keyword
exe 'hi StorageClass guifg='s:type
exe 'hi String guifg='s:rosemary
exe 'hi Tag guifg='s:keyword
exe 'hi Title guifg='s:choco'  gui=bold cterm=bold'
exe 'hi Todo guifg='s:fg2'  gui=inverse,bold cterm=inverse,bold'
exe 'hi Type guifg='s:type
exe 'hi Underlined   gui=underline cterm=underline'

" Neovim Terminal Mode
let g:terminal_color_0 = s:cream
let g:terminal_color_1 = s:warning
let g:terminal_color_2 = s:keyword
let g:terminal_color_3 = s:bg4
let g:terminal_color_4 = s:func
let g:terminal_color_5 = s:builtin
let g:terminal_color_6 = s:fg3
let g:terminal_color_7 = s:str
let g:terminal_color_8 = s:bg2
let g:terminal_color_9 = s:warning2
let g:terminal_color_10 = s:fg2
let g:terminal_color_11 = s:var
let g:terminal_color_12 = s:type
let g:terminal_color_13 = s:const
let g:terminal_color_14 = s:fg4
let g:terminal_color_15 = s:comment

" Ruby Highlighting
exe 'hi rubyAttribute guifg='s:builtin
exe 'hi rubyLocalVariableOrMethod guifg='s:var
exe 'hi rubyGlobalVariable guifg='s:var
exe 'hi rubyInstanceVariable guifg='s:var
exe 'hi rubyKeyword guifg='s:keyword
exe 'hi rubyKeywordAsMethod guifg='s:keyword' gui=bold cterm=bold'
exe 'hi rubyClassDeclaration guifg='s:keyword' gui=bold cterm=bold'
exe 'hi rubyClass guifg='s:keyword' gui=bold cterm=bold'
exe 'hi rubyNumber guifg='s:const

" Python Highlighting
exe 'hi pythonBuiltinFunc guifg='s:builtin

" Go Highlighting
exe 'hi goBuiltins guifg='s:builtin
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints      = 1
let g:go_highlight_chan_whitespace_error  = 1
let g:go_highlight_extra_types            = 1
let g:go_highlight_fields                 = 1
let g:go_highlight_format_strings         = 1
let g:go_highlight_function_calls         = 1
let g:go_highlight_function_parameters    = 1
let g:go_highlight_functions              = 1
let g:go_highlight_generate_tags          = 1
let g:go_highlight_operators              = 1
let g:go_highlight_space_tab_error        = 1
let g:go_highlight_string_spellcheck      = 1
let g:go_highlight_types                  = 1
let g:go_highlight_variable_assignments   = 1
let g:go_highlight_variable_declarations  = 1

" Javascript Highlighting
exe 'hi jsBuiltins guifg='s:builtin
exe 'hi jsFunction guifg='s:keyword' gui=bold cterm=bold'
exe 'hi jsGlobalObjects guifg='s:type
exe 'hi jsAssignmentExps guifg='s:var

" Html Highlighting
exe 'hi htmlLink guifg='s:var' gui=underline cterm=underline'
exe 'hi htmlStatement guifg='s:keyword
exe 'hi htmlSpecialTagName guifg='s:keyword

" Markdown Highlighting
exe 'hi mkdCode guifg='s:builtin


