local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
})

-- require("lazy").setup({
-- 
--     -- Theme
--     { "folke/tokyonight.nvim" },
-- 
--     -- UI
--     { "nvim-lualine/lualine.nvim" },
--     { "akinsho/bufferline.nvim" },
--     { "lukas-reineke/indent-blankline.nvim" },
--     { "folke/which-key.nvim" },
-- 
--     -- File explorer
--     {
--         "nvim-neo-tree/neo-tree.nvim",
--         dependencies = {
--             "MunifTanjim/nui.nvim",
--             "nvim-tree/nvim-web-devicons",
--             "nvim-lua/plenary.nvim",
--         }
--     },
-- 
--     -- Telescope
--     {
--         "nvim-telescope/telescope.nvim",
--         dependencies = {
--             "nvim-lua/plenary.nvim"
--         }
--     },
-- 
--     -- Treesitter
--     {
--         "nvim-treesitter/nvim-treesitter",
--         build = ":TSUpdate"
--     },
-- 
--     -- LSP
--     { "neovim/nvim-lspconfig" },
--     { "mason-org/mason.nvim" },
--     { "mason-org/mason-lspconfig.nvim" },
-- 
--     -- Completion
--     { "hrsh7th/nvim-cmp" },
--     { "hrsh7th/cmp-buffer" },
--     { "hrsh7th/cmp-path" },
--     { "hrsh7th/cmp-nvim-lsp" },
--     { "L3MON4D3/LuaSnip" },
-- 
--     -- Git
--     { "lewis6991/gitsigns.nvim" },
-- 
-- })
