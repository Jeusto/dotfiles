"####################
"###  UI Options  ###
"####################

"Always display the status bar
set laststatus=2
"Always show cursor position
set ruler
"Display command line's tab complete options as a menu
set wildmenu
"Maximum number of tab pages that can be opened from the command line
set tabpagemax=50
"Disable beep on errors set noerrorbells
"Enable mouse for scrolling and resizing
set mouse=a
"Set the window's title, reflecting the file currently being edited
set title
"80 character limit line
set colorcolumn=80
"Show line numbers on the sidebar
set number
set nuw=2
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i"| set rnu | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &nu | set nornu | endif
:augroup END
"Change theme depending on system theme
if $THEME == "dark"
  colorscheme onehalfdark
else
  colorscheme onehalflight
endif
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

"Enable search highlighting
set hlsearch
"Ignore case when searching
set ignorecase
"Incremental search that shows partial matches
set incsearch
"Auto switch search to case-sensitive if search contains an uppercase letter
set smartcase

"#############################
"###  Performance options  ###
"#############################

"Limit the files searched for auto-completes
set complete-=i
"Don't update screen during macro and script execution
set lazyredraw

"################################
"###  Text rendering options  ###
"################################

"Always try to show a paragraph's last line
set display+=lastline
"Use an encoding that supports unicode
set encoding=utf-8
"Avoid wrapping a line in the middle of a word
set linebreak
"The number of screen lines to keep above and below the cursor
set scrolloff=1
"The number of screen columns to keep to the left and right of the cursor
set sidescrolloff=3
"Enable syntax highlighting
syntax enable
"Enable line wrapping
set wrap

"####################################
"###  Indentation and tabulation  ###
"####################################

"Indentation and tabulation
set tabstop=8
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent
set smarttab
set expandtab

"#######################
"###  Custom colors  ###
"#######################

hi link StartifyPath Comment
hi link StartifySlash Comment
hi link StartifyFile Delimiter
hi link StartifySection Directory
hi link StartifyNumber Number

"###############
"###  Other  ###
"###############

"Hide current mode text in status bar
set noshowmode

"Highlight current line
set cursorline

"Use system clipboard by default
set clipboard=unnamedplus

"Cursor types for different modes
let &t_SI="\eP\e[5 q\e\\"
let &t_EI="\eP\e[1 q\e\\"
let &t_SR="\eP\e[3 q\e\\"

"You will have bad experience for diagnostic messages when it's default 4000
set updatetime=300

"TextEdit might fail if hidden is not set
set hidden

"Give more space for displaying messages
set cmdheight=2

"Don't pass messages to |ins-completion-menu|
set shortmess+=c

"Indicators on the same column as line numbers
set signcolumn=yes
hi! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg

"Higlight yank
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup="Search", timeout=200 }
augroup END
