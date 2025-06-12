vim.o.termguicolors = true
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
--vim.g.python3_host_prog = '/opt/homebrew/bin/python3.11'



-- Save the last cursor position in a file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end
})

-- default mappings for goto-preview
--[[
nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
nnoremap gpt <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>
nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
nnoremap gpD <cmd>lua require('goto-preview').goto_preview_declaration()<CR>
nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>
nnoremap gpr <cmd>lua require('goto-preview').goto_preview_references()<CR>
]]--

require("lazy").setup({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "vim-airline/vim-airline",
    "tpope/vim-fugitive",
    'nvie/vim-flake8',
    'github/copilot.vim',
    'rhysd/vim-grammarous',
    'psf/black',
    'fisadev/vim-isort',
    { 
        "nvim-treesitter/nvim-treesitter", 
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "typescript",
                    "tsx",
                    "markdown",
                    "markdown_inline",
                    -- Commenting out Python treesitter to preserve old highlighting
                    -- "python",
                },
                highlight = { 
                    enable = true,
                    -- Disable treesitter highlighting for Python
                    disable = { "python" },
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    },
    {
      'stevearc/oil.nvim',
      opts = {
        git = {
            -- Return true to automatically git add/mv/rm files
            add = function(path)
              return false
            end,
            mv = function(src_path, dest_path)
              return false
            end,
            rm = function(path)
              return false
            end,
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
        'prettier/vim-prettier',
            run = 'yarn install --frozen-lockfile --production',
            ft = {'javascript', 'typescript', 'css', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'}
    },
    {
    "kevinhwang91/nvim-ufo",
        dependencies = {
        { "kevinhwang91/promise-async" },
        },
    },
    {
        "rmagatti/goto-preview",
        event = "BufEnter",
        config = function()
            require('goto-preview').setup({
                default_mappings = true,
                width = 120,
                height = 15,
                border = {"↖", "─" ,"┐", "│", "┘", "─", "└", "│"},
                debug = false,
                opacity = nil,
                resizing_mappings = false,
                post_open_hook = nil,
                post_close_hook = nil,
                references = {
                    provider = "telescope",
                    telescope = require("telescope.themes").get_dropdown({ hide_preview = false })
                },
                focus_on_open = true,
                dismiss_on_move = false,
                force_close = true,
                bufhidden = "wipe",
                stack_floating_preview_windows = true,
                same_file_float_preview = true,
                preview_window_title = { enable = true, position = "left" },
                zindex = 1,
            })
        end,
    },
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        -- dependencies = { "nvim-tree/nvim-web-devicons" },
        -- or if using mini.icons/mini.nvim
        -- dependencies = { "echasnovski/mini.icons" },
        opts = {}
    }
})



-- Setup Mason and LSP before anything that depends on LSP
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "pyright", "html" }
})
require('lspconfig').pyright.setup{
    settings = {
        python = {
            -- :PyrightSetPythonPath /opt/homebrew/bin/python3.10
            -- pythonPath = "/opt/homebrew/bin/python3.10",
            pythonPath = "/opt/homebrew/bin/python3.11",
        }
    }
}
require('lspconfig').html.setup{
  cmd = {"vscode-html-language-server", "--stdio"},
  filetypes = {"html"},
  init_options = {
    configurationSection = {"html", "css", "javascript"},
    embeddedLanguages = {
      css = true,
      javascript = true
    },
    provideFormatter = true
  }
}
-- require('lspconfig').htmx.setup{}

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
vim.notify = require("notify")

--[[
vim.o.foldcolumn = '1' -- '0' is not bad
vim.foldlevel = 99
vim.o.foldenable = true
vim.api.nvim_set_keymap('n', 'zR', ':lua require("ufo").openAllFolds()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'zM', ':lua require("ufo").closeAllFolds()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'zP', ':lua require("ufo").peekFoldedLinesUnderCursor()<CR>', { noremap = true, silent = true })
require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
        -- return {'treesitter', 'indent'}
        return {'lsp', 'indent'}
    end
})
]]

-- Custom cursor position autocmd is defined at the top of this file
-- No need to delete any conflicting autocmds

-- my customizations
require('borisdev')
