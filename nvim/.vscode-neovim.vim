"##################
"###  Mappings  ### 
"##################

"Use space as leader key
nnoremap <SPACE> <Nop>
let mapleader = "\<space>"

"Make 0 act like Home: first click gets you to the first non-blank char,
"second click gets you to the start of the line.
nnoremap <expr> <silent> 0 col('.') == match(getline('.'),'\S')+1 ? '0' : '^'

"Moving text
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"Hide search higlights
nmap <leader>u :nohlsearch<CR>

"Quicker switching between windows
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <A-l> gt
nmap <A-h> gT
nmap <A-w> :tabclose<CR>

"Paste and indent by default and leader+p to paste without indenting
:nnoremap p ]p
:nnoremap <leader>p p

"Make capital y behave like everything else
nnoremap Y y$

"Keep it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJz

"Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

"Useless
map q: <Nop>
nnoremap Q <Nop>

"Saner behavior of n and N, always use the same direction for n and N
nnoremap <expr> n  'Nn'[v:searchforward]
xnoremap <expr> n  'Nn'[v:searchforward]
onoremap <expr> n  'Nn'[v:searchforward]

nnoremap <expr> N  'nN'[v:searchforward]
xnoremap <expr> N  'nN'[v:searchforward]
onoremap <expr> N  'nN'[v:searchforward]

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

"Saner  ctrl-l
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

"##################################
"###  Vscode specific mappings  ### 
"##################################

nnoremap <leader>n <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>
nnoremap <leader>b <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>
nnoremap <leader>t <Cmd>call VSCodeNotify('workbench.action.focusAuxiliaryBar')<CR>

"Map replace all to leader s
nmap <leader>s :%s/

"Match neovim 
nnoremap <leader>e <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
nnoremap <leader>r <Cmd>call VSCodeNotify('code-runner.run')<CR>

"Use vscode's own comment commands
nmap gc  <Plug>VSCodeCommentary
xmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

"Fix moving cursor unfolds a folded section of the code
nmap j gj
nmap k gk

"Fix ctrl+d and u not affecting selection in visual mode
nnoremap <C-d> 27j
vnoremap <C-d> 27j
nnoremap <C-u> 27k
vnoremap <C-u> 27k

"#################
"###  Plugins  ###
"#################

call plug#begin('~/.config/nvim-plugins')
  source $HOME/.config/nvim/plugins/vim-easymotion.vim
  Plug 'tpope/vim-surround' "Easily add/remove brackets/tags etc"
  Plug 'tpope/vim-unimpaired' "Pairs of handy bracket mappings"
  Plug 'terryma/vim-expand-region'
  Plug 'justinmk/vim-sneak'
call plug#end()

map <A-=> <Plug>(expand_region_expand)
map <A--> <Plug>(expand_region_shrink)

"##################
"###  Settings  ###
"##################

"Enable search highlighting
set hlsearch
"Ignore case when searching
set ignorecase
"Incremental search that shows partial matches
set incsearch
"Auto switch search to case-sensitive if search contains an uppercase letter
set smartcase

"The number of screen lines to keep above and below the cursor
set scrolloff=1

"Indentation and tabulation
set tabstop=8
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent
set smarttab
set expandtab

"Use system clipboard by default
set clipboard=unnamedplus

"Show the line number relative to the line with the cursor
set relativenumber

"##################################
"###  Vscode specific settings  ###
"##################################

nnoremap <C-f> <Nop>
set showmode
