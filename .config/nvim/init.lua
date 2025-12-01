-- Suppress lspconfig deprecation warnings (must be set before any lspconfig require() calls)
-- Set as early as possible, before lazy.nvim loads
vim.g.lspconfig_silence_deprecation_warnings = true
vim.g.lspconfig_silence_warnings = true

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
-- vim.g.python3_host_prog = '/opt/homebrew/bin/python3.12'
--vim.g.python3_host_prog = '/opt/homebrew/bin/python3.12'

vim.g.python3_host_prog = vim.fn.expand("~/.venvs/nvim/bin/python")



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
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            {'L3MON4D3/LuaSnip'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'saadparwaiz1/cmp_luasnip'},
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            -- Set up gentle, eye-friendly colors for completion menu
            vim.api.nvim_set_hl(0, 'CmpNormal', { bg = '#2d2d2d', fg = '#d4d4d4' })
            vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { fg = '#569cd6', bold = true })
            vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { fg = '#569cd6' })
            vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { fg = '#dcdcaa' })
            vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { fg = '#dcdcaa' })
            vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { fg = '#9cdcfe' })
            vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { fg = '#569cd6' })
            vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { fg = '#9cdcfe' })
            vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { fg = '#b5cea8' })
            vim.api.nvim_set_hl(0, 'CmpItemMenu', { fg = '#808080', italic = true })
            vim.api.nvim_set_hl(0, 'CmpSel', { bg = '#404040', fg = '#ffffff' })

            cmp.setup({
                window = {
                    completion = {
                        winhighlight = "Normal:CmpNormal,CursorLine:CmpSel,Search:None",
                        border = 'rounded',
                    },
                    documentation = {
                        border = 'rounded',
                        winhighlight = "Normal:CmpNormal",
                    },
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    -- Use Ctrl+j/k OR arrows for completion navigation
                    ['<C-j>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<C-k>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<Down>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<Up>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    -- Tab only for snippets
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                }),
                formatting = {
                    format = function(entry, vim_item)
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snip]",
                            buffer = "[Buf]",
                        })[entry.source.name]
                        return vim_item
                    end
                },
            })
        end,
    },
    {
      "xTacobaco/cursor-agent.nvim",
      config = function()
        vim.keymap.set("n", "<leader>ca", ":CursorAgent<CR>", { desc = "Cursor Agent: Toggle terminal" })
        vim.keymap.set("v", "<leader>ca", ":CursorAgentSelection<CR>", { desc = "Cursor Agent: Send selection" })
        vim.keymap.set("n", "<leader>cA", ":CursorAgentBuffer<CR>", { desc = "Cursor Agent: Send buffer" })
      end,
    },
    {
        'tpope/vim-fugitive'
    },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    {
      "neovim/nvim-lspconfig",
      init = function()
        -- Suppress deprecation warnings BEFORE plugin loads
        vim.g.lspconfig_silence_deprecation_warnings = true
        vim.g.lspconfig_silence_warnings = true
      end,
      config = function()
        -- Also set here as backup
        vim.g.lspconfig_silence_deprecation_warnings = true
        vim.g.lspconfig_silence_warnings = true
      end,
    },
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
    'rhysd/vim-grammarous',
    -------------------------------------------------------
    -- Conform: unified formatter (Ruff + Prettier)
    -------------------------------------------------------
    {
      "stevearc/conform.nvim",
      opts = {
        formatters_by_ft = {
          -- Python via Ruff
          python = { "ruff_format" },
          -- JS / TS / Web stack via Prettierd / Prettier
          javascript = { "prettierd", "prettier" },
          javascriptreact = { "prettierd", "prettier" },
          typescript = { "prettierd", "prettier" },
          typescriptreact = { "prettierd", "prettier" },
          vue = { "prettierd", "prettier" },
          svelte = { "prettierd", "prettier" },
          html = { "prettierd", "prettier" },
          css = { "prettierd", "prettier" },
          scss = { "prettierd", "prettier" },
          less = { "prettierd", "prettier" },
          json = { "prettierd", "prettier" },
          jsonc = { "prettierd", "prettier" },
          yaml = { "prettierd", "prettier" },
          markdown = { "prettierd", "prettier" },
          markdown_inline = { "prettierd", "prettier" },
          graphql = { "prettierd", "prettier" },
        },
        -- Auto-format on save for configured filetypes
        format_on_save = {
          enabled = true,
          timeout_ms = 2000,
          lsp_fallback = true,
          async = false,
        },
        -- Configure Ruff to use project's pyproject.toml if found
        formatters = {
          ruff_format = {
            -- Ruff will automatically find pyproject.toml in parent directories
            -- but we can explicitly set it if needed
            condition = function(ctx)
              -- Use system ruff if available, otherwise use mason-installed one
              return true
            end,
            -- Suppress errors for invalid syntax (Ruff can't format broken code)
            -- The errors will still show in the log but won't block formatting
            quiet = false,
          },
        },
        -- Don't fail format_on_save if formatter errors occur
        notify_on_error = false,
      },
      config = function(_, opts)
        require("conform").setup(opts)
        -- Manual autocmd to ensure format_on_save works
        local formatters_by_ft = opts.formatters_by_ft
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = "*",
          group = vim.api.nvim_create_augroup("conform_auto_format", { clear = true }),
          callback = function(args)
            -- Only format if there's a formatter configured for this filetype
            local ft = vim.bo[args.buf].filetype
            if ft and formatters_by_ft[ft] then
              local conform = require("conform")
              conform.format({ bufnr = args.buf, async = false, timeout_ms = 2000 })
            end
          end,
        })
      end,
    },
    -------------------------------------------------------
    -- nvim-lint: Linting (Ruff for Python)
    -------------------------------------------------------
    {
      "mfussenegger/nvim-lint",
      config = function()
        local lint = require("lint")
        
        lint.linters_by_ft = {
          python = { "ruff" },
          -- Add other linters as needed
          -- javascript = { "eslint_d" },
          -- typescript = { "eslint_d" },
        }
        
        -- Auto-lint on save and when entering buffer
        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
        
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
          group = lint_augroup,
          callback = function()
            lint.try_lint()
          end,
        })
      end,
    },
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
    -- NOTE: vim-prettier removed; formatting handled by Conform
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
    },
    -- CodeCompanion: Zed/Cursor-style editing + chat
    {
      "olimorris/codecompanion.nvim",
      version = "v17.33.0",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
      },
      opts = {
        -- Use OpenAI as a simple default; relies on OPENAI_API_KEY
        adapters = {
          http = {
            openai = function()
              return require("codecompanion.adapters").extend("openai_compatible", {
                env = {
                  api_key = vim.env.OPENAI_API_KEY,
                  url = "https://api.openai.com",
                  -- chat_url = "/v1/chat/completions", -- optional; default is this anyway
                },
                schema = {
                  model = { default = "gpt-4o" },
                },
              })
            end,
          },
        },
        strategies = {
          chat   = { adapter = "openai" },
          inline = {
            adapter = "openai",
            keymaps = {
              -- SAFE: explicit, leader-based keys
              accept_change = {
                modes = { n = "<leader>a" },      -- Accept
                description = "Accept inline diff",
              },
              reject_change = {
                modes = { n = "<leader>r" },      -- Reject
                description = "Reject inline diff",
              },
              -- SAFETY: disable "YOLO accept everything" (gdy)
              always_accept = {
                modes = {},                        -- no keybound (gdy disabled for safety)
                description = "Always accept (disabled in safe mode)",
              },
            },
          },
          cmd    = { adapter = "openai" },
        },
      },
      config = function(_, opts)
        -- Load API key from .env file if not already set
        if not vim.env.OPENAI_API_KEY then
          local env_file = vim.fn.expand("~/workspace/sindri-mono/.env")
          local file = io.open(env_file, "r")
          if file then
            for line in file:lines() do
              -- Match OPENAI_API_KEY=value (handles quoted and unquoted values)
              local value = line:match("^OPENAI_API_KEY=(.+)$")
              if value then
                -- Remove quotes if present
                value = value:gsub("^['\"]", ""):gsub("['\"]$", "")
                vim.env.OPENAI_API_KEY = value
                break
              end
            end
            file:close()
          end
        end

        require("codecompanion").setup(opts)
        local map = vim.keymap.set

        -- Chat buffer: "agent mode" / conversation with workspace
        map("n", "<leader>ac", "<cmd>CodeCompanionChat Toggle<CR>", {
          desc = "AI Chat (CodeCompanion)",
        })

        -- Visual: send selected text into chat (Zed-style "edit this")
        map("v", "<leader>as", "<cmd>CodeCompanionChat Toggle<CR>", {
          desc = "AI Chat on selection",
        })

        -- Action palette: Zed/Cursor-style commands (/fix, /refactor, etc)
        map({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionActions<CR>", {
          desc = "AI Actions (Zed-style)",
        })

        -- Explicitly disable gdy (always accept) for safety
        vim.keymap.set("n", "gdy", "<Nop>", { buffer = true, desc = "Disabled: always accept (safety)" })
      end,
    },
})



-- Setup Mason and LSP before anything that depends on LSP
require("mason").setup()

-- Install tools via mason-tool-installer
require("mason-tool-installer").setup({
  ensure_installed = {
    "ruff",           -- Python formatter + linter
    "prettierd",      -- Fast Prettier daemon
    "prettier",       -- Prettier fallback
  },
  auto_update = false,
  run_on_start = true,
})

-- Shared LSP setup
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

-- Shared capabilities so all LSPs use the same position encoding
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.positionEncodings = { "utf-16" }

require("mason-lspconfig").setup({
  ensure_installed = { "html" },  -- no need to list basedpyright here
  handlers = {
    -- Default handler for servers we *do* want Mason to manage
    function(server)
      lspconfig[server].setup({
        capabilities = capabilities,
      })
    end,

    -- Custom HTML config (kept as you had it)
    html = function()
      lspconfig.html.setup({
        cmd = {"vscode-html-language-server", "--stdio"},
        filetypes = {"html"},
        init_options = {
          configurationSection = {"html", "css", "javascript"},
          embeddedLanguages = { css = true, javascript = true },
          provideFormatter = true,
        },
        capabilities = capabilities,
      })
    end,

    -- ❌ Disable Pyright (Mason sees it installed, so we override with a no-op)
    pyright = function() end,
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
    -- Format: use Conform (Ruff / Prettier) with LSP fallback
    vim.keymap.set('n', '<space>f', function()
      require("conform").format({ bufnr = 0, async = false, timeout_ms = 2000, lsp_fallback = true })
    end, opts)
  end,
})


-----------------------------------------------------------
-- Explicitly disable Pyright BEFORE setting up basedpyright
-----------------------------------------------------------
-- Stop and disable pyright completely - we use basedpyright instead
lspconfig.pyright.setup({
  autostart = false,
})

-- Kill any existing pyright clients that might be running
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("KillPyright", { clear = true }),
  callback = function(ev)
    local clients = vim.lsp.get_clients({ bufnr = ev.buf })
    for _, client in ipairs(clients) do
      if client.name == "pyright" then
        vim.notify("Stopping pyright client (using basedpyright instead)", vim.log.levels.INFO)
        vim.lsp.stop_client(client.id, true)
      end
    end
  end,
})

-----------------------------------------------------------
-- basedpyright (Python LSP from /opt/homebrew/bin)
-----------------------------------------------------------

-- Helper to find package root with pyproject.toml containing [tool.pyright]
local function find_pyright_package_root(fname)
  local current = vim.fn.fnamemodify(fname, ":p:h")
  
  -- Walk up directory tree looking for pyproject.toml with [tool.pyright]
  while current ~= "/" do
    local pyproject = current .. "/pyproject.toml"
    if vim.fn.filereadable(pyproject) == 1 then
      -- Check if this pyproject.toml has [tool.pyright] section
      local file = io.open(pyproject, "r")
      if file then
        local content = file:read("*all")
        file:close()
        if content:match("%[tool%.pyright%]") then
          -- Found package root with pyright config
          return current
        end
      end
    end
    current = vim.fn.fnamemodify(current, ":h")
  end
  
  -- Fallback to standard detection
  return util.root_pattern("pyproject.toml", "pyrightconfig.json", ".git")(fname)
end

-- You know you have `/opt/homebrew/bin/basedpyright`, so we can be explicit:
lspconfig.basedpyright.setup({
  cmd = { "/opt/homebrew/bin/basedpyright", "--stdio" },

  root_dir = find_pyright_package_root,
  capabilities = capabilities,

  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "standard",
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
      },
    },
    -- Ensure basedpyright reads pyproject.toml settings
    python = {
      analysis = {
        autoImportCompletions = true,
        typeCheckingMode = "standard",
      },
    },
  },
  
  -- Let basedpyright read pyproject.toml and pyrightconfig.json automatically
  -- It should pick up venvPath and venv from [tool.pyright] sections
})

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

-----------------------------------------------------------
-- Diagnostics display configuration
-----------------------------------------------------------
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

require("cursor-agent").setup({})
