"#####################
"###  Keybindings  ###
"#####################

"Use space as leader key
nnoremap <SPACE> <Nop>
let mapleader = "\<space>"

"Map replace all to leader s
nmap <leader>s :%s//g<Left><Left>

"Make 0 act like Home: first click gets you to the first non-blank char,
"second click gets you to the start of the line.
nnoremap <expr> <silent> 0 col('.') == match(getline('.'),'\S')+1 ? '0' : '^'

"Moving text
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"Hide search higlights
nmap <leader>h :nohlsearch<CR>
nnoremap <silent> <Esc> :nohlsearch<CR>

"Buffers manipulation
nnoremap <silent> <A-e> :Buffers<CR>
nmap <A-w> :bdel <cr>
nmap <A-q> :bufdo bdelete <cr>
nmap <A-h> :bprevious <cr>
nmap <A-l> :bnext <cr>
nnoremap <A-0> :bfirst<CR>
nnoremap <A-9> :blast<CR>

"Quicker switching between windows
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <A-l> gt
nmap <A-h> gT
nmap <A-w> :tabclose<CR>

"Better autocompletion mappings
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Enter> pumvisible() ? "\<C-y>" : "\<Enter>"

"Make file executable
nnoremap <silent> <leader>x :!chmod +x %<CR>

"######################################
"###  Quality of life improvements  ###
"######################################

"Paste and indent by default and leader+p to paste without indenting
:nnoremap p ]p
:nnoremap <leader>p p

"Open even non-existant files with gf
map gf :edit <cfile><cr>

"Make capital y behave like everything else
nnoremap Y y$

"Keep it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJz

"Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

"Remove useless mapping
map q: <Nop>
nnoremap Q <Nop>

"Saner behavior of n and N, always use the same direction for n and N
nnoremap <expr> n  'Nn'[v:searchforward]
xnoremap <expr> n  'Nn'[v:searchforward]
onoremap <expr> n  'Nn'[v:searchforward]

nnoremap <expr> N  'nN'[v:searchforward]
xnoremap <expr> N  'nN'[v:searchforward]
onoremap <expr> N  'nN'[v:searchforward]

"Saner command-line history
cnoremap <expr> <c-n> wildmenumode() ? "\<c-n>" : "\<down>"
cnoremap <expr> <c-p> wildmenumode() ? "\<c-p>" : "\<up>"

"D and c only deletes, use x for delete and yank, use dl for removing letter
nnoremap x d
xnoremap x d
nnoremap xx dd
nnoremap X D

nnoremap d "_d
vnoremap d "_d
nnoremap D "_D
vnoremap D "_D

nnoremap c "_c
vnoremap c "_c
nnoremap C "_C
vnoremap C "_C

"Easier command-line mode
nnoremap ; :
xnoremap ; :

"Saner  ctrl-l
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

"Use global marks by default
noremap <silent> <expr> ' "`".toupper(nr2char(getchar()))
noremap <silent> <expr> m "m".toupper(nr2char(getchar()))
sunmap '
sunmap m

"Alternate escape key
inoremap jk <Esc>
cnoremap jk <C-C>

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
"Show line numbers on the sidebar
set number
set nuw=2
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i"| set rnu | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &nu | set nornu | endif
:augroup END
"Change theme depending on system theme
set termguicolors

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

"###############
"###  Other  ###
"###############

"Hide current mode text in status bar
set noshowmode

"Use system clipboard by default
set clipboard=unnamedplus

"Show the line number relative to the line with the cursor
set relativenumber

"Cursor types for different modes
let &t_SI="\eP\e[5 q\e\\"
let &t_EI="\eP\e[1 q\e\\"
let &t_SR="\eP\e[3 q\e\\"

"TextEdit might fail if hidden is not set
set hidden

"Give more space for displaying messages
set cmdheight=2

"Don't pass messages to |ins-completion-menu|
set shortmess+=c

"Higlight yank
hi YankHighlight guibg=#9e6a03"
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup="YankHighlight", timeout=200 }
augroup END

" Disable parentheses matching depends on system.
set noshowmatch
function! g:FckThatMatchParen ()
    if exists(":NoMatchParen")
        :NoMatchParen
    endif
endfunction

augroup plugin_initialize
    autocmd!
    autocmd VimEnter * call FckThatMatchParen()
augroup END

"Fix % for tsx files
runtime macros/matchit.vim
