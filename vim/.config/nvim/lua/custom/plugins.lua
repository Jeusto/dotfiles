local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
  },

  -- Override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    -- event = "BufWritePre"
    event = "BufWritePre",
    config = function()
      require "custom.configs.conform"
    end,
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
    event = "BufRead",
    config = function()
      require('symbols-outline').setup {
        position = 'left',
      }
    end
  },

  {
    "CRAG666/code_runner.nvim",
    event = "BufRead",
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
    "ahmedkhalf/project.nvim",
    event = "BufRead",
    config = function()
      require("project_nvim").setup {
        patterns = { ".git", ".project", ".hg", ".svn", "Makefile", "package.json", "Cargo.toml", "go.mod" },
        silent_chdir = true,
      }
    end,
  },

  -- {
  --   "karb94/neoscroll.nvim",
  --   event = 'BufRead',
  --   config = function()
  --     require('neoscroll').setup({})
  --     local mappings    = {}
  --     -- mappings['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '150' } }
  --     -- mappings['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '150' } }
  --     -- mappings['<C-b>'] = { 'scroll', { '-vim.api.nvim_win_get_height(0)', 'true', '150' } }
  --     -- mappings['<C-f>'] = { 'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '150' } }
  --     -- mappings['<C-y>'] = { 'scroll', { '-0.10', 'false', '150' } }
  --     -- mappings['<C-e>'] = { 'scroll', { '0.10', 'false', '150' } }
  --     mappings['zt']    = { 'zt', { '150' } }
  --     mappings['zz']    = { 'zz', { '150' } }
  --     mappings['zb']    = { 'zb', { '150' } }
  --     require('neoscroll.config').set_mappings(mappings)
  --   end,
  -- },

  -- Sticky scroll
  {
    "romgrk/nvim-treesitter-context",
    event = 'BufRead',
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

  { "tpope/vim-unimpaired" },
  { "tpope/vim-surround" },
  { "sheerun/vim-polyglot" },
  { "terryma/vim-expand-region" },
  -- {
  --   "kshenoy/vim-signature",
  --   event = 'BufRead'
  -- },
  { "mg979/vim-visual-multi" },
  { "folke/trouble.nvim",                     cmd = "TroubleToggle", },
  { "nvim-treesitter/nvim-treesitter-angular" },
  { "sindrets/diffview.nvim" },
  -- {
  --   "p00f/nvim-ts-rainbow",
  --   event = "BufRead"
  -- },
  -- {
  --   "chentoast/marks.nvim",
  --   event = "BufRead"
  -- },

  {
    "zbirenbaum/copilot.lua",
    event = "BufRead",
    config = function()
      require("copilot").setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          accept = false,
          keymap = {
            accept = "<C-e>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
      }
    end,
  },

  {
    "ggandor/leap.nvim",
    event = "BufRead",
    config = function()
      require("leap").set_default_keymaps()
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    event = 'BufRead',
    requires = {
      "nvim-lua/plenary.nvim"
    }
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = 'BufRead',
    opts = {
    }
  },

  -- Auto close and autorename html tags
  {
    "windwp/nvim-ts-autotag",
    event = 'BufRead',
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  {
    'stevearc/dressing.nvim',
    opts = {},
  }

  -- {
  --   "f-person/auto-dark-mode.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("auto-dark-mode").setup {
  --       default = "dark",
  --       start_at = 19,
  --       end_at = 7,
  --       disable = { "dashboard", "NvimTree", "packer" },
  --     }
  --   end,
  -- }

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
