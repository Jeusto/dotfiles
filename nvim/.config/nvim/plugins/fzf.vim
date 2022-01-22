Plug 'junegunn/fzf', { 'do': { ->  fzf#install() } }
Plug 'junegunn/fzf.vim'

"Mappings"
nnoremap <silent> <Leader>bb :Buffers<CR>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Leader>e :Files<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>g :Commits<CR>
" nnoremap <silent> <Leader>hh :History<CR>
" nnoremap <silent> <Leader>h: :History:<CR>
" nnoremap <silent> <Leader>h/ :History/<CR>

