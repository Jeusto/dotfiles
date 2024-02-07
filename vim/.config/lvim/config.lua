--------------------------
---  General settings  ---
--------------------------

lvim.log.level = "warn"
lvim.format_on_save = true
vim.opt.relativenumber = true
vim.opt.nuw = 2
vim.opt.smartcase = true
vim.opt.wrap = false
vim.opt.timeoutlen = 250
vim.opt.termguicolors = true

lvim.autocommands = {
  {
    "ColorScheme",
    { command = "hi CursorLine guibg=none ctermbg=none" },
  },
  {
    "ColorScheme",
    { command = "hi LineNr guibg=none ctermbg=none" },
  },
  {
    "ColorScheme",
    { command = "hi CursorLineNr guibg=none ctermbg=none" },
  }
}

vim.g.neovide_transparency = 0.85
vim.g.transparency = 0.8
-- vim.opt.guifont = "JetBrainsMono Nerd Font:h14"
-- vim.o.guifont = "Source Code Pro:h14" -- text below applies for VimScript

---------------
---  Theme  ---
---------------

lvim.colorscheme = "vscode"
lvim.builtin.theme.name = "vscode"
lvim.transparent_window = true

-- Transparent background if env var is set
-- if os.getenv("TRANSPARENT_NVIM") == "1" then
--   lvim.transparent_window = true
--   vim.cmd [[autocmd ColorScheme * hi LineNr guibg=NONE]]
--   vim.cmd [[autocmd ColorScheme * hi CursorLine guibg=NONE]]
--   vim.cmd [[autocmd ColorScheme * hi CursorLineNR guibg=NONE]]
-- end

-- -- Function to toggle light/dark theme on the current gnome theme
-- local function update_theme_from_gnome()
--   if not vim.fn.executable('gsettings') then
--     return
--   end

--   local color_scheme = vim.fn.system('gsettings get org.gnome.desktop.interface color-scheme')
--   color_scheme = color_scheme:gsub('%s+', ''):gsub("'", "")

--   if color_scheme == 'prefer-dark' then
--     vim.opt.background = 'dark'
--   else
--     vim.opt.background = 'light'
--   end
-- end

-- update_theme_from_gnome()

------------------
---  Mappings  ---
------------------

lvim.leader = "space"

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<C-p>"] = "<Cmd>Telescope git_files<CR>"
lvim.keys.normal_mode["<C-t>"] = "<Cmd>ToggleTerm direction=horizontal<CR>"
lvim.keys.normal_mode["ga"] = ":lua vim.lsp.buf.code_action()<CR>"
vim.api.nvim_set_keymap('n', 'gh', ':lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })

-- Hop.nvim
vim.api.nvim_set_keymap('', 'f',
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
  , {})
vim.api.nvim_set_keymap('', 'F',
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
  , {})
vim.api.nvim_set_keymap('', 't',
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
  , {})
vim.api.nvim_set_keymap('', 'T',
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>"
  , {})

-- Old vim mappings
vim.cmd([[
  "Make 0 act like Home
  nnoremap <expr> <silent> 0 col('.') == match(getline('.'),'\S')+1 ? '0' : '^'

  "D and c only deletes, use x for delete and yank, use dl for removing letter
  nnoremap x d
  xnoremap x d
  nnoremap xx dd
  nnoremap X D

  nnoremap d "_d
  vnoremap d "_d
  nnoremap D "_D
  vnoremap D "_D

  nnoremap c "_c
  vnoremap c "_c
  nnoremap C "_C
  vnoremap C "_C

  "Easier command-line mode
  nnoremap ; :
  xnoremap ; :

  "Buffers manipulation
  nnoremap <silent> <A-e> :Telescope buffers<CR>
  nmap <A-w> :bdel <cr>
  nmap <A-q> :bufdo bdelete <cr>
  nmap <A-h> :bprevious <cr>
  nmap <A-l> :bnext <cr>
  nnoremap <A-0> :bfirst<CR>
  nnoremap <A-9> :blast<CR>

  map <A-=> <Plug>(expand_region_expand)
  map <A--> <Plug>(expand_region_shrink)

  "Use global marks by default
  noremap <silent> <expr> ' "`".toupper(nr2char(getchar()))
  noremap <silent> <expr> m "m".toupper(nr2char(getchar()))
  sunmap '
  sunmap m

  "Tmux
  nnoremap <silent> <C-f> :silent !tmux new tmux-sessionizer<CR>

  "Alternate escape key
  inoremap jk <Esc>
  cnoremap jk <C-C>

  "Make ! work with aliases
  set shellcmdflag=-ic

  "Replace all
  nmap s :%s/

  "Hide search higlights
  nnoremap <silent> <Esc> :nohlsearch<CR>
]])

-- Rename with LSP
vim.api.nvim_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  i = { -- for input mode
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
    ["<esc>"] = actions.close,
  },
  n = { -- for normal mode
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["v"] = { "<cmd>vsplit<CR>", "Vertical split" }
lvim.builtin.which_key.mappings["w"] = { "<cmd>HopWord<cr>", "Hop to word" }
lvim.builtin.which_key.mappings["j"] = { "<cmd>HopWord<cr>", "Hop to word" }
lvim.builtin.which_key.mappings["n"] = { "<cmd>NvimTreeToggle<cr>", "Nvim tree toggle" }
lvim.builtin.which_key.mappings["e"] = { "<cmd>Telescope buffers<cr>", "Telescope buffers" }
lvim.builtin.which_key.mappings["r"] = { "<cmd>RunCode<cr>", "Run code" }
lvim.builtin.which_key.mappings["o"] = { "<cmd>SymbolsOutline<cr>", "Symbols outline" }
lvim.builtin.which_key.mappings["sc"] = { "<cmd>TodoTelescope<CR>", "Todo comments" }
lvim.builtin.which_key.mappings["ss"] = { "<cmd>Telescope<CR>", "All possible options" }
lvim.builtin.which_key.mappings["su"] = { "<cmd>Telescope undo<CR>", "Undo tree" }
lvim.builtin.which_key.mappings["sd"] = { "<cmd>Telescope diagnostics <CR>", "Diagnostics" }
lvim.builtin.which_key.mappings["bq"] = { "<cmd>execute '%bd|e#|bd#'<CR>", "Close all buffers except current" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
  c = { "<cmd>TodoTrouble<cr>", "Todo comments" },
}

---------------------------------------
---  Config for predefined plugins  ---
---------------------------------------

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.alpha.dashboard.section.header.val = {}
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.lir.show_hidden_files = true
lvim.builtin.illuminate.active = false

-- Lualine
local components = require("lvim.core.lualine.components")
local function lvimName()
  return [[Lvim]]
end
lvim.builtin.lualine.style = "lvim"
lvim.builtin.lualine.sections.lualine_a = { lvimName }
lvim.builtin.lualine.sections.lualine_x = { components.diagnostics, "filetype" }

-- Other
table.insert(lvim.builtin.project.patterns, 0, "!>packages") -- fix for js monorepos
file_ignore_patterns = { ".git/", ".cache", "%.o", "%.a", "%.out", "%.class",
  "%.pdf", "%.mkv", "%.mp4", "%.zip" }

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.rainbow = {
  enable = true,
  extended_mode = true,
  max_file_lines = 2500,
  colors = {
    "#e06c75",
    "#d19a66",
    "#e5c07b",
    "#98c379",
    "#56b6c2",
    "#61afef",
    "#c678dd",
  },
}

-----------------
---  Plugins  ---
-----------------
lvim.plugins = {
  { "navarasu/onedark.nvim" },
  { "tpope/vim-unimpaired" },
  { "tpope/vim-surround" },
  { "sheerun/vim-polyglot" },
  { "terryma/vim-expand-region" },
  { "p00f/nvim-ts-rainbow", },
  { "Mofiqul/vscode.nvim" },
  { "kshenoy/vim-signature" },
  { "folke/todo-comments.nvim" },
  { "mg979/vim-visual-multi" },
  { "metakirby5/codi.vim" },
  { "folke/trouble.nvim",                     cmd = "TroubleToggle", },
  { "nvim-treesitter/nvim-treesitter-angular" },
  { "sindrets/diffview.nvim" },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {}
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    config = function()
      require("todo-comments").setup {}
    end
  },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require('symbols-outline').setup {
        position = 'left',
      }
    end
  },
  {
    "CRAG666/code_runner.nvim",
    config = function()
      require('code_runner').setup {
        filetype = {
          java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
          python = "python3 -u",
          typescript = "deno run",
          rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt"
        },
      }
    end
  },
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true,
        throttle = true,
        max_lines = 0,
        patterns = {
          default = {
            'class',
            'function',
            'method',
          },
        },
      }
    end
  },
  {
    "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup {
          plugin_manager_path = get_runtime_dir() .. "/site/pack/packer",
          suggestion = {
            enabled = true,
            auto_trigger = true,
            debounce = 75,
            accept = false,
          },
          copilot_node_command = 'node',
          server_opts_overrides = {},
        }
      end, 100)
    end,
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require('neoscroll').setup({})
      local mappings    = {}
      mappings['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '150' } }
      mappings['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '150' } }
      mappings['<C-b>'] = { 'scroll', { '-vim.api.nvim_win_get_height(0)', 'true', '150' } }
      mappings['<C-f>'] = { 'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '150' } }
      mappings['<C-y>'] = { 'scroll', { '-0.10', 'false', '150' } }
      mappings['<C-e>'] = { 'scroll', { '0.10', 'false', '150' } }
      mappings['zt']    = { 'zt', { '150' } }
      mappings['zz']    = { 'zz', { '150' } }
      mappings['zb']    = { 'zb', { '150' } }
      require('neoscroll.config').set_mappings(mappings)
    end
  },
}

-- Toggle copilot
function trigger_suggestions()
  vim.cmd("Copilot toggle")
end

vim.api.nvim_set_keymap('i', '<C-g>', '<cmd>lua trigger_suggestions()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-g>', '<cmd>lua trigger_suggestions()<CR>', { noremap = true, silent = true })
lvim.builtin.which_key.mappings["lg"] = { "<cmd>lua trigger_suggestions()<CR>", "Toggle Copilot" }

-- Tab accept copilot suggestion
vim.keymap.set("i", '<Tab>', function()
  if require("copilot.suggestion").is_visible() then
    require("copilot.suggestion").accept()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
  end
end, {
  silent = true,
})

-- Toggle virtual text for diagnostics
local function toggle_virtual_text()
  local current_setting = vim.lsp.handlers["textDocument/publishDiagnostics"].config.virtual_text
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = not current_setting
    }
  )
  print("Diagnostics virtual text is now", not current_setting and "enabled" or "disabled")
end

vim.api.nvim_set_keymap('n', '<A-CR>', '<cmd>lua toggle_virtual_text()<CR>', { noremap = true, silent = true })

--------------------
---  Formatters  ---
--------------------
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black",        filetypes = { "python" } },
  { command = "isort",        filetypes = { "python" } },
  { command = "clang-format", filetypes = { "c", "cpp", "objc", "objcpp" } },
  {
    command = "prettier",
    extra_args = { "--print-with", "100" },
    filetypes = { "typescript", "typescriptreact" },
  },
}

-----------------
---  Linters  ---
-----------------
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
  {
    command = "shellcheck",
    extra_args = { "--severity", "warning" },
  },
}
