Plug 'mhinz/vim-startify'

" Mappings
" map <silent><leader>ss :SSave<CR>
" map <silent><leader>sc :SClose<CR>
" map <silent><leader>sd :SDelete<CR>

" Settings
let g:startify_enable_special = 0
let g:startify_fortune_use_unicode = 1
let g:startify_relative_path = 1

" Commits list
function! s:list_commits()
      let git = 'git -C ~/dotfiles'
      let commits = systemlist(git .' log --oneline | head -n10')
      let git = 'G'. git[1:]
      return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
endfunction

let g:startify_lists = [
      \ { 'type': 'files', 'header': ['   ⌛ Recent files'] },
      \ { 'type': 'dir', 'header': ['   📁 Current directory: '. getcwd()] },
      \ { 'type': 'sessions', 'header': ['   💾 Sessions'] },
      \ { 'type': 'bookmarks', 'header': ['   ⭐ Bookmarks'] },
      \ { 'type': 'commands', 'header': ['   📢 Commands'] },
      \ { 'header': ['   📜 Commits'], 'type': function('s:list_commits') },
      \ ]

let g:startify_bookmarks = [
            \ { 'cv': '~/.config/nvim/init.vim' },
            \ { 'cz': '~/.zshrc' },
            \ { 'cd': '~/dotfiles/.gitignore' },
            \ ]

let g:startify_custom_header = ['']
