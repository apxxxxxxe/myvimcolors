" Vim color file
" mask-tune
" Created by  with ThemeCreator (https://github.com/mswift42/themecreator)

hi clear

if exists("syntax on")
syntax reset
endif

set t_Co=256
let g:colors_name = "mask-tune"


let s:ddaak="#9ab8ba"
" Define reusable colorvariables.
let s:fg1="#c9c9c9"
let s:fg2="#b9b9b9"
let s:fg3="#a9a9a9"
let s:fg4="#999999"
let s:bg1="#606060"
let s:bg2="#6d6d6d"
let s:bg3="#797979"
let s:bg4="#868686"
let s:keyword=s:ddaak
let s:builtin=s:fg1
let s:const=s:fg1
let s:comment="#909090"
let s:func="#c6aeb5"
let s:str="#ba9a9c"
let s:type=s:fg1
let s:var="#c6b0a7"
let s:warning="#ff1276"
let s:warning2="#ff4d12"

exe 'hi Search   guifg=#c2e0e7 guibg='s:type

exe 'hi! link IncSearch Search'

exe 'hi Normal guifg='s:fg1' guibg='s:bg1
"exe 'hi Cursor guifg='s:bg1' guibg='s:fg1
exe 'hi Cursor guifg='s:bg1' guibg='s:fg1
"exe 'hi! link TabLineSel Normal'
"exe 'hi! link TabLine Cursor'

exe 'hi CursorLine  guibg='s:bg2
exe 'hi CursorLineNr guifg='s:str' guibg='s:bg1
exe 'hi CursorColumn  guibg='s:bg2
exe 'hi ColorColumn  guibg='s:bg2
" exe 'hi LineNr guifg='s:fg2' guibg='s:bg2
exe 'hi LineNr guifg='s:bg1' guibg='s:comment
exe 'hi CursorLineNr guifg='s:comment' guibg='s:bg1

exe 'hi TabLine guifg='s:bg1' guibg='s:comment
exe 'hi TabLineFill guifg='s:comment' guibg='s:bg1
exe 'hi TabLineSel guifg='s:comment' guibg='s:bg1

exe 'hi VertSplit guifg='s:fg3' guibg='s:bg3

"exe 'hi MatchParen guifg='s:warning2
exe 'hi! link MatchParen Search'
exe 'hi StatusLine guifg='s:fg2' guibg='s:bg3
exe 'hi Pmenu guifg='s:fg1' guibg='s:bg2
exe 'hi PmenuSel  guibg='s:bg3
"exe 'hi IncSearch guifg='s:bg1' guibg='s:keyword
"exe 'hi Search   gui=underline'
exe 'hi Directory guifg='s:const
exe 'hi Folded guifg='s:fg4' guibg='s:bg1
exe 'hi WildMenu guifg='s:str' guibg='s:bg1

exe 'hi Boolean guifg='s:const
exe 'hi Character guifg='s:const
exe 'hi Comment guifg='s:comment .. " gui=italic"
exe 'hi Conditional guifg='s:keyword
exe 'hi Constant guifg='s:const
exe 'hi Todo guibg='s:bg1
exe 'hi Define guifg='s:keyword
exe 'hi DiffAdd guifg=#fafafa guibg=#123d0f gui=bold'
exe 'hi DiffDelete guibg='s:bg2
exe 'hi DiffChange  guibg=#151b3c guifg=#fafafa'
exe 'hi DiffText guifg=#ffffff guibg=#ff0000 gui=bold'
exe 'hi ErrorMsg guifg='s:warning' guibg='s:bg2
exe 'hi WarningMsg guifg='s:fg1' guibg='s:warning2
exe 'hi Float guifg='s:const
exe 'hi Function guifg='s:func
exe 'hi Identifier guifg='s:type
exe 'hi Keyword guifg='s:keyword .. " gui=bold"
exe 'hi Label guifg='s:var
exe 'hi NonText guifg='s:bg4' guibg='s:bg2
exe 'hi Number guifg='s:const
exe 'hi Operator guifg='s:keyword
exe 'hi PreProc guifg='s:keyword
exe 'hi Special guifg='s:fg1
exe 'hi SpecialKey guifg='s:fg2' guibg='s:bg2
exe 'hi Statement guifg='s:keyword
exe 'hi StorageClass guifg='s:type
exe 'hi String guifg='s:str
exe 'hi Tag guifg='s:keyword
exe 'hi Title guifg='s:fg1
exe 'hi Todo guifg='s:fg2
exe 'hi Type guifg='s:type
exe 'hi Underlined   gui=underline'


" Neovim Terminal Mode
let g:terminal_color_0 = s:bg1
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
exe 'hi rubyKeywordAsMethod guifg='s:keyword
exe 'hi rubyClassDeclaration guifg='s:keyword
exe 'hi rubyClass guifg='s:keyword
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
exe 'hi jsFunction guifg='s:keyword
exe 'hi jsGlobalObjects guifg='s:type
exe 'hi jsAssignmentExps guifg='s:var

" Html Highlighting
exe 'hi htmlLink guifg='s:var
exe 'hi htmlStatement guifg='s:keyword
exe 'hi htmlSpecialTagName guifg='s:keyword

" Markdown Highlighting
exe 'hi mkdCode guifg='s:builtin


