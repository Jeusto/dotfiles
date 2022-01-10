"#############"
"###  Ale  ###"
"#############"

let g:ale_set_balloons = 1
let g:ale_sign_error = '✖✖'
let g:ale_sign_warning = '!!'

"#############"
"###  Coc  ###"
"#############"

"Coc extensions"
let g:coc_preferences_enableFloatHighLight = 0
let g:coc_config_home = '$HOME/.coc'
let g:coc_global_extensions = [
      \ 'coc-snippets',
      \ 'coc-pairs',
      \ 'coc-tsserver',
      \ 'coc-eslint',
      \ 'coc-prettier',
      \ 'coc-json',
      \ 'coc-java',
      \ 'coc-python',
      \ 'coc-clangd'
      \ ]

"Coc indicators"
let g:coc_user_config = {
      \ "diagnostic.errorSign": '✖✖',
      \ "diagnostic.warningSign": '!!',
      \ "diagnostic.infoSign": 'ℹ️',
      \ "diagnostic.hintSign": '💡',
      \ "diagnostic.signOffset": 100,
      \ "coc.preferences.enableFloatHighlight": v:false,
      \ }

"Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocAction('format')

"Add `:Fold` command to fold current buffer"
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

"Highlight the symbol and its references when holding the cursor"
autocmd CursorHold * silent call CocActionAsync('highlight')

"Symbol renaming"
nmap <leader>rn <Plug>(coc-rename)

"Formatting selected code"
xmap <leader>f  <Plug>(coc-format-selected)

"Apply AutoFix to problem on the current line"
map <leader>qf  <Plug>(coc-fix-current)

"#############"
"###  FZF  ###"
"#############"

nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>

"#################"
"###  Airline  ###"
"#################"

let g:airline_section_c = '%t%r'
let g:airline_section_x = '%p%%'
let g:airline_section_y = ''
let g:airline_section_z = '%l:%c'

let g:airline_powerline_fonts = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_skip_empty_sections = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.dirty='*'
let g:airline_symbols.maxlinenr = ' ⦁ '

let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#buffers_label = ''
let g:airline#extensions#tabline#buf_label_first = 0
let g:airline#extensions#tabline#left_sep = '▏'
let g:airline#extensions#tabline#left_alt_sep = '▏'
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_nr = 0

let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#buffer_min_count = 2

"###############"
"###  Other  ###"
"###############"

let g:leetcode_browser='firefox'

let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = '~~'
let g:gitgutter_sign_removed = '--'

" map <F7> :NERDTreeToggle<CR>
" map <F8> :TagbarToggle<CR>

" let g:UltiSnipsExpandTrigger = "<F5>" 

" Nerd tree better toggle
nnoremap <expr> <leader>n g:NERDTree.IsOpen() ? : ':NERDTreeClose<CR>' @% == '' ? ':NERDTree<CR>' : ':NERDTreeFind<CR>'
