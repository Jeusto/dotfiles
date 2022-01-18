"##################"
"###  Mappings  ###"
"##################"

"Use space as leader key"
nnoremap <SPACE> <Nop>
let mapleader = "\<space>"

"To avoid using arrow keys"
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

"Map replace all to S"
nnoremap S :%s//g<Left><Left>

"Make capital y behave like everything else"
nnoremap Y y$

"Keep it centered"
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJz

"Moving text"
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"Hide search higlights"
nmap <silent> <leader>u :nohlsearch<CR>

"Buffers"
nmap <silent> <leader>bd :bdel <cr>
nmap <silent> <leader>bq :bufdo bdelete <cr>
nmap <silent> <leader>bp :bprevious <cr>
nmap <silent> <leader>bn :bnext <cr>

"Open even non-existant files with gf"
map gf :edit <cfile><cr>

"Reselect visual selection after indenting"
vnoremap < <gv
vnoremap > >gv

"Quicker switching between windows"
nmap <silent> <C-h> <C-w>h
nmap <silent> <C-j> <C-w>j
nmap <silent> <C-k> <C-w>k
nmap <silent> <C-l> <C-w>l

"Open current file in the default program"
nmap <leader>x :!xdg-opn %<cr><cr>

"Better autocompletion mappings"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Enter> pumvisible() ? "\<C-y>" : "\<Enter>"

"Paste and indent by default and ctrl+p to paste without indenting"
:nnoremap p ]p
:nnoremap <c-p> p
