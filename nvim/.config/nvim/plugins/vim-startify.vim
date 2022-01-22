Plug 'mhinz/vim-startify'

" Mappings
" map <silent><leader>ss :SSave<CR>
" map <silent><leader>sc :SClose<CR>
" map <silent><leader>sd :SDelete<CR>

" Settings
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
