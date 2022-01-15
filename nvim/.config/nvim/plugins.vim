"#################"
"###  Plugins  ###"
"#################"

call plug#begin('~/.config/nvim-plugins')

Plug 'tpope/vim-sensible' "Good default settings"
Plug 'sheerun/vim-polyglot' "Collection of language packs"
Plug 'SirVer/ultisnips' "Snipppets engine"
Plug 'honza/vim-snippets' "Snippets"
Plug 'tpope/vim-commentary' "Easily comment/uncomment"
Plug 'tpope/vim-surround' "Easily add/remove brackets/tags etc"
Plug 'tpope/vim-unimpaired' "Pairs of handy bracket mappings"

Plug 'preservim/nerdtree' "File navigation window"
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'preservim/tagbar' "Display tags/classes etc in a window"

Plug 'joshdick/onedark.vim' "Theme"
Plug 'ryanoasis/vim-devicons' "Adds file type icons"
Plug 'vim-airline/vim-airline' "Status/tabline"
Plug 'mhinz/vim-startify' "Fancy start screen"

Plug 'tpope/vim-fugitive' "Git wrapper"
Plug 'airblade/vim-gitgutter' "Show git gutters in the editor"
Plug 'ianding1/leetcode.vim' "Solve LeetCode problems in Vim"

Plug 'neoclide/coc.nvim', {'branch': 'release'} "Intellisense"
Plug 'dense-analysis/ale' "Linting"
Plug 'prettier/vim-prettier', { 'do': 'yarn install' } "Prettier wrapper"

Plug 'junegunn/fzf', { 'do': { ->  fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}

Plug 'justinmk/vim-sneak'
Plug 'terryma/vim-expand-region'
Plug 'svermeulen/vim-cutlass' "d and c operations don't affect clipboard"

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

call plug#end()
