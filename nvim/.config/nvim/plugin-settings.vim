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
      \ 'coc-jedi',
      \ 'coc-clangd'
      \ ]

"Coc indicators"
let g:coc_user_config = {
      \ "diagnostic.errorSign": '✖✖',
      \ "diagnostic.warningSign": '!!',
      \ "diagnostic.infoSign": 'ii',
      \ "diagnostic.hintSign": 'hh',
      \ "diagnostic.signOffset": 100,
      \ "coc.preferences.enableFloatHighlight": v:false,
      \ }

"Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocAction('format')
"Add `:Fold` command to fold current buffer"
command! -nargs=? Fold :call CocAction('fold', <f-args>)
"Highlight the symbol and its references when holding the cursor"
autocmd CursorHold * silent call CocActionAsync('highlight')

"Symbol renaming"
nmap <leader>rn <Plug>(coc-rename)
"Formatting selected code"
xmap <leader>fo <Plug>(coc-format-selected)
"Apply AutoFix to problem on the current line"
map <leader>qf <Plug>(coc-fix-current)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> <leader>d <Plug>(coc-diagnostic-info)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> ]h <Plug>(coc-git-nextchunk)
nmap <silent> [h <Plug>(coc-git-prevchunk)

" apply autofix to problem on the current line.
nmap <leader>af  <plug>(coc-fix-current)
nmap <leader>am  <plug>(coc-format-selected)
xmap <leader>am  <plug>(coc-format-selected)
nmap <leader>ac  <Plug>(coc-codeaction)
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ga  <Plug>(coc-codeaction-line)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

nmap <leader>l :CocFzfList<cr>

"#############"
"###  FZF  ###"
"#############"

"Mappings"
nnoremap <silent> <Leader>bb :Buffers<CR>
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

map <leader>t :TagbarToggle<CR>
let g:UltiSnipsExpandTrigger = "<F5>"

"##################"
"###  NERDTree  ###"
"##################"

let NERDTreeShowHidden=1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1

" " Nerd tree better toggle
nnoremap <expr> <leader>n g:NERDTree.IsOpen() ? ':NERDTreeClose<CR>' : @% == '' ? ':NERDTree<CR>' : ':NERDTreeFind<CR>'
nmap <leader>N :NERDTreeToggle<CR>

" If more than one window and previous buffer was NERDTree, go back to it.
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif

"##################"
"###  Startify  ###"
"##################"

let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   ⌛ Recent files']            },
      \ { 'type': 'dir',       'header': ['   🗃️ Current directory: '. getcwd()] },
      \ { 'type': 'sessions',  'header': ['   💾 Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   ⭐ Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   📢 Commands']       },
      \ ]

let g:startify_bookmarks = [
            \ { 'cv': '~/.config/nvim/init.vim' },
            \ { 'cz': '~/.zshrc' },
            \ ]

let g:startify_enable_special = 0
let g:startify_fortune_use_unicode = 1

map <silent><leader>ss :SSave<CR>
map <silent><leader>sc :SClose<CR>
map <silent><leader>sd :SDelete<CR>

"###############"
"###  Sneak  ###"
"###############"

map f <Plug>Sneak_s
map F <Plug>Sneak_S
map t <Plug>Sneak_t
map T <Plug>Sneak_T

highlight Sneak guifg=black guibg=#61afef ctermfg=black ctermbg=blue
highlight SneakScope guifg=black guibg=#e06c75 ctermfg=black ctermbg=red

let g:sneak#use_ic_scs = 1
let g:sneak#s_next = 1
let g:sneak#label = 1
let g:sneak#prompt = '🔎 '

"########################"
"###  Limelight+goyo  ###"
"########################"

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

"#################"
"### Cutlass   ###"
"#################"

"Use x for delete and yank, use dl for removing letter"
nnoremap x d
xnoremap x d

nnoremap xx dd
nnoremap X D
