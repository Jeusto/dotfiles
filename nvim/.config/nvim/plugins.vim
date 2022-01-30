call plug#begin('~/.config/nvim-plugins')

"Plugins for both neovim & vscode-neovim"
source $HOME/.config/nvim/plugins/vim-easymotion.vim
source $HOME/.config/nvim/plugins/vim-cutlass.vim "d and c operations don't affect clipboard"
Plug 'tpope/vim-surround' "Easily add/remove brackets/tags etc"
Plug 'tpope/vim-unimpaired' "Pairs of handy bracket mappings"
Plug 'terryma/vim-expand-region'
Plug 'searleser97/vim-sneak'

if !exists('g:vscode')
  "Plugins only for neovim"
  source $HOME/.config/nvim/plugins/vim-airline.vim "Status/tabline"
  source $HOME/.config/nvim/plugins/vim-startify.vim "Fancy start screen"
  source $HOME/.config/nvim/plugins/vim-gitgutter.vim "Show git gutters"
  source $HOME/.config/nvim/plugins/nerdtree.vim "File navigation window"
  source $HOME/.config/nvim/plugins/ale.vim "Linting"
  source $HOME/.config/nvim/plugins/coc.vim "Intellisense"
  source $HOME/.config/nvim/plugins/fzf.vim "Fuzzy search"
  Plug 'tpope/vim-commentary' "Easily comment/uncomment"
  Plug 'sheerun/vim-polyglot' "Collection of language packs"
  Plug 'SirVer/ultisnips' "Snipppets engine"
  Plug 'honza/vim-snippets' "Snippets"
  Plug 'preservim/tagbar' "Display tags/classes etc in a window"
  Plug 'joshdick/onedark.vim' "Theme"
  Plug 'ryanoasis/vim-devicons' "Adds file type icons"
  Plug 'tpope/vim-fugitive' "Git wrapper"
  Plug '0x84/vim-coderunner' "Code runner"
  "Plug 'sheerun/vim-sensible' "Good default settings"
  "Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
  "Plug 'ianding1/leetcode.vim'
  "Plug 'nvim-lua/plenary.nvim'
  "Plug 'nvim-telescope/telescope.nvim'
  "Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}
  "Plug 'antoinemadec/coc-fzf'
  "Plug 'junegunn/goyo.vim'
  "Plug 'junegunn/limelight.vim'
endif

call plug#end()

"Other plugin settings"
let g:leetcode_browser='firefox'
map <leader>t :TagbarToggle<CR>
let g:UltiSnipsExpandTrigger = "<F5>"
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
let g:rainbow_active = 1
