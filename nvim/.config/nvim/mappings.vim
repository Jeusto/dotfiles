"##################"
"###  Mappings  ###"
"##################"

"Use space as leader key"
nnoremap <SPACE> <Nop>
let mapleader = "\<space>"

"Better autocompletion mappins"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Enter> pumvisible() ? "\<C-y>" : "\<Enter>"

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
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==

"Hide search higlights"
nmap <leader>k :nohlsearch<CR>

"Delete current buffer"
nmap <leader>q :bdel <cr>

"Delete all buffers"
nmap <leader>Q :bufdo bdelete<cr>

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

"Center the pane by adding an empty buffer"
function CenterPane()
 lefta vnew
 wincmd w
 exec 'vertical resize '. string(&columns * 0.75)
endfunction
nnoremap <leader>c :call CenterPane()<cr>
