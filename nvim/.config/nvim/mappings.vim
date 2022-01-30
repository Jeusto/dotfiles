"#####################"
"###  Keybindings  ###"
"#####################"

"Use space as leader key"
nnoremap <SPACE> <Nop>
let mapleader = "\<space>"

"Map replace all to leader s"
" nnoremap S :%s//g<Left><Left>
nnoremap <leader>s :%s//g<Left><Left>

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

"######################################################"
"###  Trigger vscode commands through vim mappings  ###"
"######################################################"

if exists('g:vscode')
  nnoremap <leader>n <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>
  nnoremap <leader>b <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>
  nnoremap <leader>e <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
  nnoremap <leader>t <Cmd>call VSCodeNotify('workbench.action.goToSymbol')<CR>
  
  "Code runner extension"
  nnoremap <leader>r <Cmd>call VSCodeNotify('code-runner.run')<CR>

  "Use vscode's own comment commands"
  nmap gc  <Plug>VSCodeCommentary
  xmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine
endif
