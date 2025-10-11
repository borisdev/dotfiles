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
vim.g.python3_host_prog = '/opt/homebrew/bin/python3.12'
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
    -- Using habamax colorscheme which is built into Neovim 0.10+
    -- {
    --     "ellisonleao/gruvbox.nvim",
    --     priority = 1000, -- Load before other plugins
    --     config = function()
    --         require("gruvbox").setup({
    --             contrast = "hard", -- can be "hard", "soft" or empty string
    --             italic = {
    --                 strings = true,
    --                 comments = true,
    --                 operators = false,
    --                 folds = true,
    --             },
    --         })
    --         vim.cmd([[colorscheme gruvbox]])
    --     end,
    -- },
    require('plugins.cmp'),
    {
        'tpope/vim-fugitive'
    },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    'vim-airline/vim-airline',
    { 
        "nvim-treesitter/nvim-treesitter", 
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "python",
                    "typescript",
                    "tsx",
                    "markdown",
                    "markdown_inline",
                },
                highlight = { 
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },
                incremental_selection = { enable = true },
            })
        end,
    },
    'nvim-lua/plenary.nvim',
    -- 'nvie/vim-flake8',  -- Removed to prevent duplicate diagnostics with Pyright
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
      -- Optional dependencies
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    -- {
    --   "folke/which-key.nvim",
    --   event = "VeryLazy",
    --   init = function()
    --     vim.o.timeout = true
    --     vim.o.timeoutlen = 300
    --   end,
    --   opts = {
    --     -- your configuration comes here
    --     -- or leave it empty to use the default settings
    --     -- refer to the configuration section below
    --   }
    -- },
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
    },
    {
        'akinsho/toggleterm.nvim', version = "*", config = true
    },
    {
        'prettier/vim-prettier',
            run = 'yarn install --frozen-lockfile --production',
            ft = {'javascript', 'typescript', 'css', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'}
    },
    -- {
    --     'rcarriga/nvim-notify', version = "*", config = true
    -- },
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
                post_open_hook = function()
                    -- Set consistent dark colors for preview windows
                    vim.api.nvim_set_hl(0, 'FloatBorder', { bg = '#1e1e1e', fg = '#565656' })
                    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#1e1e1e', fg = '#d4d4d4' })
                    vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#252526', fg = '#cccccc' })
                    vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = '#252526', fg = '#454545' })
                    vim.api.nvim_set_hl(0, 'TelescopeSelection', { bg = '#094771', fg = '#ffffff' })
                    vim.api.nvim_set_hl(0, 'TelescopeSelectionCaret', { bg = '#094771', fg = '#ffffff' })
                    vim.api.nvim_set_hl(0, 'TelescopeMatching', { fg = '#4fc1ff', bold = true })
                    vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = '#313131', fg = '#cccccc' })
                    vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = '#313131', fg = '#454545' })
                end,
                post_close_hook = nil,
                references = {
                    provider = "telescope",
                    telescope = require("telescope.themes").get_dropdown({ 
                        hide_preview = false,
                        layout_config = { width = 0.8, height = 0.6 }
                    })
                },
                focus_on_open = true,
                dismiss_on_move = false,
                force_close = true,
                bufhidden = "wipe",
                stack_floating_preview_windows = false,
                same_file_float_preview = false,
                preview_window_title = { enable = true, position = "left" },
                zindex = 1,
            })
        end,
    },
    {
      "ibhagwan/fzf-lua",
      -- optional for icon support
      dependencies = { "nvim-tree/nvim-web-devicons" },
      -- or if using mini.icons/mini.nvim
      -- dependencies = { "echasnovski/mini.icons" },
      opts = {}
    }
})



-- Setup Mason and LSP before anything that depends on LSP
require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = { "pyright", "html" },
  handlers = {
    -- default handler for all servers you don't customize:
    function(server)
      require("lspconfig")[server].setup({})
    end,

    -- customized Pyright (overrides default so it's not set up twice)
    pyright = function()
      require("lspconfig").pyright.setup({
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
            },
            pythonPath = "/opt/homebrew/bin/python3.12",
          },
        },
      })
    end,

    -- your HTML setup:
    html = function()
      require("lspconfig").html.setup({
        cmd = {"vscode-html-language-server", "--stdio"},
        filetypes = {"html"},
        init_options = {
          configurationSection = {"html", "css", "javascript"},
          embeddedLanguages = { css = true, javascript = true },
          provideFormatter = true,
        },
      })
    end,
  },
})
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
    vim.keymap.set('n', 'gd', function()
        local params = vim.lsp.util.make_position_params(0, 'utf-8')
        vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result, ctx, config)
            if err then return end
            if not result or vim.tbl_isempty(result) then return end
            
            -- Jump to first result directly
            if vim.tbl_islist(result) then
                vim.lsp.util.jump_to_location(result[1], 'utf-8')
            else
                vim.lsp.util.jump_to_location(result, 'utf-8')
            end
        end)
    end, opts)
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

require("oil").setup({
    view_options = {
    -- Show files and directories that start with "."
    show_hidden = true,
},
})
require("toggleterm").setup{}
-- vim.notify = require("notify")

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

-- Configure LSP diagnostics display
vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
    source = 'always',  -- Always show diagnostic source to identify duplicates
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})
require('borisdev')

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.md", "*.txt", "*disable_ai*.py"}, -- Replace with desired file extensions
  callback = function()
    vim.cmd("Copilot disable")
  end,
})
