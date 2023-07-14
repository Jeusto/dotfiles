source $HOME/.vimrc

"####################
"###  Keybindings ###
"####################

"Lsp
nnoremap <leader>lj <Cmd>call VSCodeNotify('editor.action.marker.next')<CR>
nnoremap <leader>lk <Cmd>call VSCodeNotify('editor.action.marker.prev')<CR>
nnoremap <leader>lr <Cmd>call VSCodeNotify('editor.action.rename')<CR>
nnoremap <leader>lf <Cmd>call VSCodeNotify('editor.action.formatDocument')<CR>

"Git
nnoremap <leader>gd <Cmd>call VSCodeNotify('git.openChange')<CR>
nnoremap <leader>gb <Cmd>call VSCodeNotify('git.checkout')<CR>
nnoremap <leader>gl <Cmd>call VSCodeNotify('gitlens.toggleLineBlame')<CR>
nnoremap <leader>gC <Cmd>call VSCodeNotify('gitlens.openFileRevision')<CR>
nnoremap <leader>gj <Cmd>call VSCodeNotify('workbench.action.editor.nextChange')<CR>
nnoremap <leader>gk <Cmd>call VSCodeNotify('workbench.action.editor.previousChange')<CR>
nnoremap <leader>gp <Cmd>call VSCodeNotify('editor.action.dirtydiff.next')<CR>
nnoremap <leader>gr <Cmd>call VSCodeNotify('git.revertSelectedRanges')<CR>
nnoremap <leader>gs <Cmd>call VSCodeNotify('git.stageSelectedRanges')<CR>
nnoremap <leader>gg <Cmd>call VSCodeNotify('binocular.customCommands', 'Lazygit')<CR>

"Other
nnoremap <leader>e <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
nnoremap <leader>n <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>
nnoremap <leader>b <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>
nnoremap <leader>t <Cmd>call VSCodeNotify('workbench.action.focusAuxiliaryBar')<CR>
nnoremap <leader>f <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
nnoremap <leader>c <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>
nnoremap <leader>P <Cmd>call VSCodeNotify('workbench.action.openRecent')<CR>
nnoremap <leader>sr <Cmd>call VSCodeNotify('workbench.action.openRecent')<CR>
nnoremap <leader>st <Cmd>call VSCodeNotify('binocular.searchFileContent')<CR>
nnoremap <leader>P <Cmd>call VSCodeNotify('binocular.customCommands', 'Projects')<CR>
nnoremap <leader>o <Cmd>call VSCodeNotify('outline.focus')<CR>
nnoremap <leader>v <Cmd>call VSCodeNotify('workbench.action.splitEditor')<CR>
nnoremap ga <Cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<CR>

"Replace all
nmap s :%s/

"Fix moving cursor unfolds a folded section of the code
nmap j gj
nmap k gk

"Fix ctrl+d and u not affecting selection in visual mode
nnoremap <C-d> 27j
vnoremap <C-d> 27j
nnoremap <C-u> 27k
vnoremap <C-u> 27k

"Remove some binds to let Vscode handle them
nnoremap <C-f> <Nop:>

"Move lines
noremap <A-j> :m .+1<CR>==
noremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"#################
"###  Plugins  ###
"#################

call plug#begin('~/.config/vscode-neovim-plugins')
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'terryma/vim-expand-region'
call plug#end()

map <A-=> <Plug>(expand_region_expand)
map <A--> <Plug>(expand_region_shrink)

"###########################
"###  Match nvim plugins ###
"###########################

"Coderunner
nnoremap <leader>r <Cmd>call VSCodeNotify('code-runner.run')<CR>

"Comment
nmap gc  <Plug>VSCodeCommentary
xmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

"Hop
nnoremap <leader>w <Cmd>call VSCodeNotify('jump-extension.jump-to-the-start-of-a-word')<CR>
nnoremap <leader>j <Cmd>call VSCodeNotify('jump-extension.jump-to-the-start-of-a-word')<CR>
