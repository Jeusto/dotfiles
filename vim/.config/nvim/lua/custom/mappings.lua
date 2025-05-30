---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },

    -- f2 rename with lsp
    ["<F2>"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "rename" },

    ["<leader>gg"] = { "<cmd>LazyGit<CR>" },
    ["<leader>o"] = { "<cmd>SymbolsOutline<CR>" },
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
  i = {
    ["<A-a"] = { "<cmd> lua require('copilot.suggestion').accept()<CR>", "Accept Copilot suggestion" },
  }
}

M.telescope = {
  -- lvim.keys.normal_mode["<C-p>"] = "<Cmd>Telescope git_files<CR>"
  n = {
    ["<C-p>"] = { "<cmd>Telescope git_files<CR>", "find files" },
    ["<leader>fp"] = { "<cmd>Telescope projects<CR>", "find projects "}
  },
}

M.nvimtree = {
  n = {
    ["<A-n>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
    ["<leader>n"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
  }
}

M.hop = {
  n = {
    ["<leader>w"] = { "<cmd> HopWord <CR>", "Hop word" },
  },
}
-- more keybinds!

return M
