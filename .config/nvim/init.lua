-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  local result = vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
  if vim.v.shell_error ~= 0 then
    -- stylua: ignore
    vim.api.nvim_echo({ { ("Error cloning lazy.nvim:\n%s\n"):format(result), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
    vim.fn.getchar()
    vim.cmd.quit()
  end
end

vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"

vim.cmd.colorscheme("ashen")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })                           -- remove bg
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })                      -- remove bg
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })                         -- remove bg
vim.api.nvim_set_hl(0, "StatusLine", { bg = "none", fg = "#ffddbb" })       -- remove statusline bg
vim.api.nvim_set_hl(0, "TabLine", { bg = "none", fg = "#ffddbb" })       -- remove statusline bg
vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#ffddbb" })       -- remove statusline bg
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none", fg = "#666666" })     -- remove statusline bg
vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })                       -- remove cursorline bg
-- vim.api.nvim_set_hl(0, "VertSplit", { bg = "none", fg = "#d87c4a" })     -- V
vim.api.nvim_set_hl(0, "WinSeparator", {bg = "none", fg = "#df6464"})       -- remove vertical separator (tree | code)
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })                       -- remove signs bg
-- vim.api.nvim_set_hl(0, "StatusColumn", { bg = "none" })                  -- ^
vim.api.nvim_set_hl(0, "WinBar", { bg = "none" })                           -- remomve upper bar
vim.cmd("highlight LineNr guibg=NONE ctermbg=NONE")                         -- remove line numbers bg

vim.opt.cursorline = true
vim.cmd("highlight LineNr guifg=#df6464") -- ctermfg=red")
vim.cmd("highlight CursorLineNr guibg=NONE guifg=#aaaaaa")

-- highlights = {
--   init = {
--     Normal = { bg = "NONE" },         -- Основной фон
--     NeoTreeNormal = { bg = "NONE" },  -- Файловый менеджер
--     NormalFloat = { bg = "NONE" },    -- Плавающие окна
--   },
-- }

