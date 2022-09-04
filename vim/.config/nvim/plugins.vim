let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim-plugins')
  source $HOME/.config/nvim/plugins/vim-easymotion.vim
  source $HOME/.config/nvim/plugins/vim-airline.vim "Status/tabline
  source $HOME/.config/nvim/plugins/vim-startify.vim "Fancy start screen
  source $HOME/.config/nvim/plugins/vim-gitgutter.vim "Show git gutters
  source $HOME/.config/nvim/plugins/nerdtree.vim "File navigation window
  source $HOME/.config/nvim/plugins/ale.vim "Linting
  source $HOME/.config/nvim/plugins/coc.vim "Intellisense 
  source $HOME/.config/nvim/plugins/fzf.vim "Fuzzy search
  Plug 'tpope/vim-surround' "Easily add/remove brackets/tags etc
  Plug 'tpope/vim-unimpaired' "Pairs of handy bracket mappings
  Plug 'tpope/vim-commentary' "Easily comment/uncomment
  Plug 'tpope/vim-fugitive' "Git wrapper
  Plug 'xianzhon/vim-code-runner' "Code runner
  Plug 'preservim/tagbar' "Display tags/classes etc in a window
  Plug 'sheerun/vim-polyglot' "Collection of language packs
  Plug 'SirVer/ultisnips' "Snipppets engine
  Plug 'honza/vim-snippets' "Snippets
  Plug 'sonph/onehalf', {'rtp': 'vim'} "Theme
  Plug 'ryanoasis/vim-devicons' "Adds file type icons
  Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app && yarn install'}
  Plug 'terryma/vim-expand-region'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'airblade/vim-rooter'
  Plug 'psliwka/vim-smoothie'
call plug#end()

"Random plugin settings/mappings
let g:UltiSnipsExpandTrigger = "<F5>"
let g:rainbow_active = 1

map <leader>t :TagbarToggle<CR>

nmap <silent><leader>r <plug>CodeRunner

map <A-=> <Plug>(expand_region_expand)
map <A--> <Plug>(expand_region_shrink)

let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_start_word_key      = '<A-n>'
let g:multi_cursor_select_all_word_key = '<C-n>'
let g:multi_cursor_start_key           = 'g<A-n>'
let g:multi_cursor_select_all_key      = 'g<C-n>'
let g:multi_cursor_next_key            = '<A-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'
