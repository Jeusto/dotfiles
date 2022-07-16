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
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"Hide search higlights
nmap <leader>u :nohlsearch<CR>

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

"Better autocompletion mappings
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Enter> pumvisible() ? "\<C-y>" : "\<Enter>"

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

"Temporarily bind ; to command-line mode 
nnoremap ; :
xnoremap ; :

"Saner  ctrl-l
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
