local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- space bar as leader for custom keybindings
vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"
vim.g.python3_host_prog = '/opt/homebrew/bin/python3.10'


require("lazy").setup({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    'vim-airline/vim-airline',
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    'nvim-lua/plenary.nvim',
    'nvie/vim-flake8',
    'github/copilot.vim',
    'rhysd/vim-grammarous',
    'psf/black',
    'fisadev/vim-isort',
    {
        "vhyrro/luarocks.nvim",
        priority = 1001, -- this plugin needs to run before molten-nvim
        opts = {
            rocks = { "magick" },
        },
    },
    {
        "3rd/image.nvim",
        event = "VeryLazy",
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter",
                build = ":TSUpdate",
                config = function()
                    require("nvim-treesitter.configs").setup({
                    ensure_installed = {
                        "markdown",
                        "markdown_inline",
                        "python",
                    },
                    highlight = { 
                        enable = true,
                        additional_vim_regex_highlighing = false,
                    },
                })
                end,
            },
        },
        opts = {
            backend = "kitty",
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "markdown", "vimwiki" }, -- quarto here
                },
                neorg = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "norg" },
                },
            },
            max_width = 100,
            max_height = 12,
            max_width_window_percentage = math.huge,
            max_height_window_percentage = math.huge,
            window_overlap_clear_enabled = true,
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
            kitty_method = "normal",
        },
    },
    {
        "benlubas/molten-nvim",
        -- version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        build = ":UpdateRemotePlugins",
        init = function()
            vim.g.molten_output_win_max_height = 12
            vim.g.molten_use_border_highlights = true
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_wrap_output = true
            vim.g.molten_virt_text_output = true
        end,
    },
    {
      'stevearc/oil.nvim',
      opts = {},
      -- Optional dependencies
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
      end,
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    },
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
    },
    {
        'akinsho/toggleterm.nvim', version = "*", config = true
    }
})

require("mason").setup()
require("mason-lspconfig").setup()
-- require("lspconfig").pyright.setup {}

-- require'lspconfig'.pyright.setup{
require('lspconfig').pyright.setup{
    settings = {
        python = {
            -- :PyrightSetPythonPath /opt/homebrew/bin/python3.10
            pythonPath = "/opt/homebrew/bin/python3.10",
        }
    }
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})


-- :LspLog shows the log of the language server (ie, pyright issues)

-- now run `:Mason` to install language servers for different languages
-- `:MasonInstall pyright` to install python language server
-- `:LspInstall basedpyright` to install python language server

-- require'lspconfig'.basedpyright.setup{}
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#basedpyright

require("oil").setup()
require("toggleterm").setup{}
-- my customizations
require('borisdev')
