"#############"
"###  Ale  ###"
"#############"

let g:ale_disable_lsp = 0
let g:ale_set_balloons = 1
let g:ale_sign_error = '⛔'
let g:ale_sign_warning = '⚠️'
let g:ale_set_highlights = 0

highlight clear ALEErrorSign
highlight clear ALEWarningSign

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
      \ "diagnostic.errorSign": '⛔',
      \ "diagnostic.warningSign": '⚠️',
      \ "diagnostic.infoSign": 'ℹ️',
      \ "diagnostic.hintSign": '💡',
      \ "diagnostic.signOffset": 100,
      \ "coc.preferences.enableFloatHighlight": v:false,
      \ }

"TextEdit might fail if hidden is not set"
set hidden

"Some servers have issues with backup files, see #649"
set nobackup
set nowritebackup

"Give more space for displaying messages?"
set cmdheight=2

"Don't pass messages to |ins-completion-menu|"
set shortmess+=c

"Indicators on the same column as line numbers"
set signcolumn=number

"Add `:Format` command to format current buffer"
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

let g:airline_powerline_fonts = 1
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_c = '%t'
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#tabline#fnamemod = ':t'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.dirty='*'
let g:airline_symbols.maxlinenr = ' ⦁ '

let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#buffers_label = ''
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_nr = 0

"###############"
"###  Other  ###"
"###############"

let g:leetcode_browser='firefox'
