"Load the correct version of the extension
if exists('g:vscode')
  Plug 'asvetliakov/vim-easymotion', {'as': 'vsc-easymotion'}
else
  Plug 'easymotion/vim-easymotion', {'as': 'nvim-easymotion'}
endif

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
let g:EasyMotion_prompt = 'Search for {n} character(s): '
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = 'ASDFJKL;GHQWERUITYZXCVBNM'
let g:EasyMotion_verbose = 0
let g:EasyMotion_move_highlight = 0

map f <Plug>(easymotion-f)
map F <Plug>(easymotion-F)
map t <Plug>(easymotion-t)
map T <Plug>(easymotion-T)

map <Leader>l <Plug>(easymotion-bd-wl)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

map <Leader>f <Plug>(easymotion-bd-f2)
map <Leader>t <Plug>(easymotion-bd-t2)

map <Leader>w <Plug>(easymotion-bd-w)

map ; <Plug>(easymotion-next)
map . <Plug>(easymotion-previous)

autocmd User EasyMotionPromptEnd silent! CocEnable
autocmd User EasyMotionPromptBegin silent! CocDisable
