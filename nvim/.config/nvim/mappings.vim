"##################"
"###  Mappings  ###"
"##################"

"Use space as leader key"
nnoremap <SPACE> <Nop>
let mapleader = "\<space>"

map <F7> :NERDTreeToggle<CR>
map <F8> :TagbarToggle<CR>

let g:UltiSnipsExpandTrigger = "<F5>" 

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Enter> pumvisible() ? "\<C-y>" : "\<Enter>"

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

"Break points for undo"
inoremap , , <c-g>u
inoremap . . <c-g>u

"Moving text"
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+2<CR>==
