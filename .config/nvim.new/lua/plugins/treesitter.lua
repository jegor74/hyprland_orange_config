require("nvim-treesitter.configs").setup({

    ensure_installed = {
        "lua",
        "python",
        "cpp",
        "c",
        "rust",
        "bash",
        "json",
        "yaml",
        "toml",
        "markdown",
    },

    highlight = {
        enable = true,
    },

    indent = {
        enable = true,
    },

})
