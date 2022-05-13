"#####################"
"###  Keybindings  ###"
"#####################"

"Make 0 act like Home: first click gets you to the first non-blank char,
"second click gets you to the start of the line.
nnoremap <expr> <silent> 0 col('.') == match(getline('.'),'\S')+1 ? '0' : '^'

"Use space as leader key"
nnoremap <SPACE> <Nop>
let mapleader = "\<space>"

"Map replace all to leader s"
nmap <leader>s :%s//g<Left><Left>

"Moving text"
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"Hide search higlights"
nmap <leader>u :nohlsearch<CR>

"Buffers manipulation"
nnoremap <silent> <Leader>bu :Buffers<CR>
nmap <leader>bd :bdel <cr>
nmap <leader>bq :bufdo bdelete <cr>
nmap <leader>bp :bprevious <cr>
nmap <leader>bn :bnext <cr>
nnoremap <leader>bf :bfirst<CR>
nnoremap <leader>bl :blast<CR>

"Quicker switching between windows"
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

"Better autocompletion mappings"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Enter> pumvisible() ? "\<C-y>" : "\<Enter>"

"######################################"
"###  Quality of life improvements  ###"
"######################################"

"Paste and indent by default and leader+p to paste without indenting"
:nnoremap p ]p
:nnoremap <leader>p p

"Open even non-existant files with gf"
map gf :edit <cfile><cr>

"Make capital y behave like everything else"
nnoremap Y y$

"Keep it centered"
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJz

"Reselect visual selection after indenting"
vnoremap < <gv
vnoremap > >gv

"Useless"
map q: <Nop>
nnoremap Q <Nop>

"Saner behavior of n and N, always use the same direction for n and N"
nnoremap <expr> n  'Nn'[v:searchforward]
xnoremap <expr> n  'Nn'[v:searchforward]
onoremap <expr> n  'Nn'[v:searchforward]

nnoremap <expr> N  'nN'[v:searchforward]
xnoremap <expr> N  'nN'[v:searchforward]
onoremap <expr> N  'nN'[v:searchforward]

"Saner command-line history"
cnoremap <expr> <c-n> wildmenumode() ? "\<c-n>" : "\<down>"
cnoremap <expr> <c-p> wildmenumode() ? "\<c-p>" : "\<up>"

"Different escape key"
" imap jk <esc>

"######################################################"
"###  Trigger vscode commands through vim mappings  ###"
"######################################################"

if exists('g:vscode')
  nnoremap <leader>n <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>
  nnoremap <leader>b <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>
  nnoremap <leader>t <Cmd>call VSCodeNotify('workbench.action.focusAuxiliaryBar')<CR>
  nmap <leader>s :%s/

  "Match neovim extensions"
  nnoremap <leader>e <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
  nnoremap <leader>r <Cmd>call VSCodeNotify('code-runner.run')<CR>

  nnoremap [g <Cmd>call VSCodeNotify('editor.action.marker.prev')<CR>
  nnoremap ]g <Cmd>call VSCodeNotify('editor.action.marker.next')<CR>

  nmap <leader>cr <Cmd>call VSCodeNotify('editor.action.rename')<CR>

  "Use vscode's own comment commands"
  nmap gc  <Plug>VSCodeCommentary
  xmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine

  "Fix moving cursor unfolds a folded section of the code"
  nmap j gj
  nmap k gk
endif
