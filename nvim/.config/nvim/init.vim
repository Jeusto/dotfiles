set all&
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"
let g:ale_disable_lsp = 1

source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/main-settings.vim
source $HOME/.config/nvim/mappings.vim
source $HOME/.config/nvim/plugin-settings.vim
source $HOME/.config/nvim/functions.vim
