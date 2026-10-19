local cmp = require("cmp")

cmp.setup({
    mapping = cmp.mapping.preset.insert(),
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
    },
})
