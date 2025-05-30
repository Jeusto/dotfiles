-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

vim.opt.relativenumber = true

-- Old vim mappings
vim.cmd('source ~/.vimrc')

-- Neovide specific settings
vim.o.guifont = "JetBrainsMono Nerd Font:h12"
-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
-- vim.g.neovide_transparency = 0.6
-- vim.g.transparency = 0.6
-- vim.g.neovide_window_blurred = true
-- vim.g.neovide_floating_blur_amount_x = 0.7
-- vim.g.neovide_floating_blur_amount_y = 0.7