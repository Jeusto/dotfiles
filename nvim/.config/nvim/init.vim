set all&
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"

source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/main-settings.vim
source $HOME/.config/nvim/mappings.vim
source $HOME/.config/nvim/plugin-settings.vim
source $HOME/.config/nvim/functions.vim