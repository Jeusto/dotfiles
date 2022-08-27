Plug 'vim-airline/vim-airline'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline_symbols.dirty='*'
let g:airline#extensions#ale#enabled = 1

"Sections"
let g:airline_section_x = '%p%%'
let g:airline_section_c = '%t%r'
let g:airline_section_y = ''
let g:airline_section_z = '%l:%c'

"Tabline configuration"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = '▏'
let g:airline#extensions#tabline#left_alt_sep = '▏'
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_splits = 0

let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#show_tab_count = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#tab_min_count = 2

let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_buffer_nr_show = 0
let g:airline#extensions#tabline#buffers_label = ''
let g:airline#extensions#tabline#buf_label_first = 0
let g:airline#extensions#tabline#buffer_min_count = 2

"Hide encoding text"
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:webdevicons_enable_airline_statusline_fileformat_symbols = 0
