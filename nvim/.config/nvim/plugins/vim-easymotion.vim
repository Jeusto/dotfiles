"Load the correct version of the extension
if has('ide')
  set easymotion
elseif exists('g:vscode')
  Plug 'asvetliakov/vim-easymotion', {'as': 'vsc-easymotion'}
else
  Plug 'easymotion/vim-easymotion', {'as': 'vim-easymotion'}
  autocmd User EasyMotionPromptEnd silent! CocEnable
  autocmd User EasyMotionPromptBegin silent! CocDisable
endif

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
let g:EasyMotion_prompt = ''
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = 'ASDFJKL;GHQWERUITYZXCVBNM'
let g:EasyMotion_verbose = 0
let g:EasyMotion_move_highlight = 0
let g:EasyMotion_off_screen_search = 0

map f <Plug>(easymotion-f)
map t <Plug>(easymotion-t)

map <silent> <Leader>f <Plug>(easymotion-bd-f2)
map <silent> <Leader>t <Plug>(easymotion-bd-t2)

map <silent> <Leader>w <Plug>(easymotion-bd-w)
