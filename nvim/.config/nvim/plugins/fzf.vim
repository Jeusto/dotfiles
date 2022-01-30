Plug 'junegunn/fzf', { 'do': { ->  fzf#install() } }
Plug 'junegunn/fzf.vim'

"Mappings"
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Leader>e :Files<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>hf :History<CR>
nnoremap <silent> <Leader>hc :History:<CR>
nnoremap <silent> <Leader>hs :History/<CR>
