call plug#begin('~/.config/nvim-plugins')
  Plug 'tpope/vim-commentary'
  Plug 'sonph/onehalf', {'rtp': 'vim'} "Theme
  Plug 'terryma/vim-expand-region'
  Plug 'psliwka/vim-smoothie'
call plug#end()

map <A-=> <Plug>(expand_region_expand)
map <A--> <Plug>(expand_region_shrink)