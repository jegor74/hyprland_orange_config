--@type vim
local vim = vim

-- INSTALLING lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- PLUGINS SETTINGS
require("lazy").setup({

    -- colorscheme
    {
        "ficcdaf/ashen.nvim",
        -- tag = "*",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("ashen") -- turning on the colorscheme
	end
    },

    -- treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      -- lazy = true,
      build = ":TSUpdate",
      config = function()
          local ok, configs = pcall(require, "nvim-treesitter.configs")

          if not ok then
            return
          end

          configs.setup({
              ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "python", "go" },
              auto_install = true,
              highlight = { enable = true},
              indent = { enable = true},
          })
      end
    },

    -- mason
    {
      "williamboman/mason.nvim",
      build = ":MasonUpdate",       -- important
      config = function()
        require("mason").setup()
      end
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "pyright", "clangd", "gopls" }, -- autoinstall
                automatic_installation = true,
            })
        end
    },

    -- LSP and autosuggestions
    { "neovim/nvim-lspconfig" },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip"
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({ { name = "nvim_lsp" } }, { { name = "buffer" } })
            })
        end
    },

    -- {
    --     "MunifTanjim/nui.nvim",
    --     config = function()
    --         local NuiLayout = require("nui.layout")
    --         local NuiPopup = require("nui.popup")

    --         -- Создание окна с рамкой
    --         local popup = NuiPopup({
    --             enter = true,
    --             focusable = true,
    --             border = {
    --                 style = "rounded", -- или "single", "double", "solid"
    --                 text = {
    --                     top = " My window ",
    --                     top_align = "center",
    --                 },
    --             },
    --             position = "50%",
    --             size = {
    --                 width = "80%",
    --                 height = "60%",
    --             },
    --         })

    --         -- Открыть окно
    --         popup:mount()
    --     end
    -- },

    -- autopairs
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end
    },

    -- comments
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    },

    -- hotkey tips
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup()
        end
    },

    -- git in DE
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end
    },

    -- status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "auto",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" }
            }
        }                                           -- empty table = default settings
    },

    -- telescope (searching)
    {
       "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Найти файлы" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Поиск по тексту" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Список буферов" })
        end
    },

    -- file tree
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                view = { width=30 }
	    })
            vim.keymap.set("n", "<F2>", "<cmd>NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Open file tree" })
        end
    }

})


-- Устанавливаем лидера клавиш (пробел)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Основные настройки
vim.opt.number = true               -- показывать номера строк
vim.opt.relativenumber = false      -- относительные номера строк
vim.opt.mouse = "a"                 -- включить мышь во всех режимах
vim.opt.ignorecase = true           -- игнорировать регистр при поиске
vim.opt.smartcase = true            -- умный учет регистра
vim.opt.hlsearch = false            -- не подсвечивать результаты поиска
vim.opt.wrap = false                -- не переносить длинные строки
vim.opt.breakindent = true          -- сохранять отступ при переносе
vim.opt.tabstop = 4                 -- ширина табуляции в пробелах
vim.opt.shiftwidth = 4              -- ширина отступа для >> и <<
vim.opt.expandtab = true            -- преобразовывать табы в пробелы
vim.opt.clipboard = "unnamedplus"   -- использовать системный буфнер обмена


-- DIAGNOSTIC
vim.diagnostic.config({
    virtual_text = true,      -- показывать текст ошибки справа
    signs = true,             -- показывать значки в gutter
    underline = true,         -- подчёркивать проблемные места
    update_in_insert = false, -- обновлять при вводе
    severity_sort = true,     -- сортировать по серьёзности
})


-- TRANSPARENCY SETTINGS
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })                           -- remove bg
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })                      -- remove bg
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })                         -- remove bg
vim.api.nvim_set_hl(0, "StatusLine", { bg = "none", fg = "#ffffff" })       -- remove statusline bg
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none", fg = "#666666" })     -- remove statusline bg
vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })                       -- remove cursorline bg
-- vim.api.nvim_set_hl(0, "VertSplit", { bg = "none", fg = "#d87c4a" })     -- V
vim.api.nvim_set_hl(0, "WinSeparator", {bg = "none", fg = "#df6464"})       -- remove vertical separator (tree | code)
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })                       -- remove signs bg
-- vim.api.nvim_set_hl(0, "StatusColumn", { bg = "none" })                  -- ^
vim.cmd("highlight LineNr guibg=NONE ctermbg=NONE")                         -- remove line numbers bg

vim.opt.cursorline = true
vim.cmd("highlight LineNr guifg=#df6464") -- ctermfg=red")
vim.cmd("highlight CursorLineNr guibg=NONE guifg=#aaaaaa")


-- TREE COLORS SETTINGS
vim.api.nvim_set_hl(0, "NvimTreeFileIcon", { fg = "#df6464" })
vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#df6464" })
vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderIcon", { fg = "#df6464" })
vim.api.nvim_set_hl(0, "NvimTreeSymlinkIcon", { fg = "#df6464" })


-- inner windows settings
-- vim.o.winborder = "rounded"
-- vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#df6464" })


-- LSP SETTINGS
-- local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- pyright
vim.lsp.config["pyright"] = {
    capabilities = capabilities,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",  -- или "strict" для более строгих проверок
            diagnosticMode = "workspace"
          }
        }
    }
}

--clangd
vim.lsp.config["clangd"] = {
    capabilities = capabilities,
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",        -- включить clang-tidy для доп. проверок
      "--header-insertion=iwyu",
    }
}

--gopls
vim.lsp.config["gopls"] = {
    capabilities = capabilities,
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,  -- включить дополнительные проверки
      }
    }
}


-- Автосохранение при потере фокуса
vim.api.nvim_create_autocmd({"FocusLost", "BufLeave"}, {
    pattern = {"*"},
    command = "silent! wall",  -- сохранить все без сообщений
})


-- HotKeys
local map = vim.keymap.set  -- short alias


-- main binds
map("n", "<leader>h", ":nohlsearch<CR>", {desc = "Отключить подсветку поиска"})
map("n", "<leader>w", ":w<CR>", {desc = "Сохранить файл"})
map("n", "<leader>q", ":q<CR>", {desc = "Закрыть файл"})


-- Перемещение между окнами
map("n", "<C-h>", "<C-w>h", {desc = "Перейти в левое окно"})
map("n", "<C-j>", "<C-w>j", {desc = "Перейти в нижнее окно"})
map("n", "<C-k>", "<C-w>k", {desc = "Перейти в верхнее окно"})
map("n", "<C-l>", "<C-w>l", {desc = "Перейти в правое окно"})


-- Сообщение о загрузке конфига
print("✓ Neovim инициализирован!")
