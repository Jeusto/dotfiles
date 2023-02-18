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
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"Hide search higlights
nmap <leader>h :nohlsearch<CR>

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

"Temporarily bind ; to command-line mode
nnoremap ; :
xnoremap ; :

"##################################
"###  Vscode specific mappings  ###
"##################################

"Map replace all to leader s
nmap <leader>s :%s/

"Match neovim
nnoremap <leader>e <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
nnoremap <leader>n <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>
nnoremap <leader>b <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>
nnoremap <leader>t <Cmd>call VSCodeNotify('workbench.action.focusAuxiliaryBar')<CR>
nnoremap <leader>f <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
nnoremap <leader>c <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
nnoremap <leader>P <Cmd>call VSCodeNotify('workbench.action.openRecent')<CR>
nnoremap <leader>sr <Cmd>call VSCodeNotify('workbench.action.openRecent')<CR>

"Match neovim plugins
"coderunner
nnoremap <leader>r <Cmd>call VSCodeNotify('code-runner.run')<CR>

"comment
nmap gc  <Plug>VSCodeCommentary
xmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

"hop
nnoremap <leader>j <Cmd>call VSCodeNotify('jump-extension.jump-to-the-start-of-a-word')<CR>

"Fix moving cursor unfolds a folded section of the code
nmap j gj
nmap k gk

"Fix ctrl+d and u not affecting selection in visual mode
nnoremap <C-d> 27j
vnoremap <C-d> 27j
nnoremap <C-u> 27k
vnoremap <C-u> 27k

"Remove some binds to let vscode handle them
nnoremap <C-f> <Nop:>

"#################
"###  Plugins  ###
"#################

call plug#begin('~/.config/vscode-neovim-plugins')
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'terryma/vim-expand-region'
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

"Indentation and tabulation
set tabstop=8
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent
set smarttab
set expandtab

"Hide current mode text in status bar
set noshowmode

"Use system clipboard by default
set clipboard=unnamedplus

"Show the line number relative to the line with the cursor
set relativenumber

"Higlight yank
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup="Search", timeout=200 }
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
