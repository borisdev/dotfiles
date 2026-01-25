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

-- Text formatting options
vim.opt.textwidth = 88  -- Wrap at 88 characters (Python Black default)
vim.opt.formatoptions:append("t")  -- Auto-wrap text using textwidth
vim.opt.formatoptions:append("c")  -- Auto-wrap comments
vim.opt.formatoptions:append("q")  -- Allow formatting comments with gq
vim.opt.formatoptions:remove("o")  -- Don't insert comment leader with o/O

-- Disable LSP for fugitive buffers to prevent errors
vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = "fugitive://*",
  callback = function(args)
    vim.b[args.buf].lsp_disable = true
  end,
})


-- Filetype-specific textwidth
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.textwidth = 88  -- Black's default line length
    vim.opt_local.formatoptions:append("t")
    vim.opt_local.formatoptions:append("c")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"markdown", "text", "gitcommit"},
  callback = function()
    vim.opt_local.textwidth = 80
  end,
})

-- Workaround for treesitter highlighter race / extmark range errors
vim.g._ts_force_sync_parsing = true

-- Stop treesitter in nofile markdown/goose floats to prevent crashes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "goose" },
  callback = function(args)
    if vim.bo[args.buf].buftype == "nofile" then
      pcall(vim.treesitter.stop, args.buf)
    end
  end,
})

-- Additional treesitter crash prevention for floating windows
vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function(args)
    local buf = args.buf
    if vim.api.nvim_buf_get_option(buf, "buftype") == "nofile" then
      pcall(vim.treesitter.stop, buf)
    end
  end,
})


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
            {'zbirenbaum/copilot-cmp'},
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
            vim.api.nvim_set_hl(0, 'CmpSel', { bg = '#094771', fg = '#ffffff', bold = true })

            vim.opt.pumblend = 0     -- no transparency
            vim.opt.pumheight = 15   -- ensure you can scroll the menu

            cmp.setup({
                preselect = cmp.PreselectMode.Item,
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },
                window = {
                    completion = {
                        border = "rounded",
                        scrollbar = true,
                        col_offset = 0,
                        side_padding = 0, -- ✅ remove left/right padding so highlight reaches edge
                        winhighlight = "Normal:CmpNormal,FloatBorder:CmpSel,CursorLine:CmpSel,PmenuSel:CmpSel,Search:None,PmenuSbar:CmpNormal,PmenuThumb:CmpSel",
                    },
                    documentation = {
                        border = "rounded",
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
                    -- Arrow keys for completion navigation
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
                    -- Keep Ctrl+j/k as backup
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
                    -- Keep Tab for snippet expansion only, allowing Copilot to handle Tab otherwise
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback() -- Let Copilot handle Tab
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback() -- Let Copilot handle Shift+Tab
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'copilot' },     -- Copilot suggestions first
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                }),
                formatting = {
                    format = function(entry, vim_item)
                        vim_item.menu = ({
                            copilot = "[Copilot]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snip]",
                            buffer = "[Buf]",
                        })[entry.source.name]
                        return vim_item
                    end
                },
            })

            -- Initialize copilot-cmp
            require("copilot_cmp").setup()
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
    -- GitHub Copilot via Lua, integrated into nvim-cmp
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({
          panel = { enabled = false },        -- no side panel
          suggestion = {
            enabled = false,                  -- IMPORTANT: use cmp instead of ghost text
          },
          filetypes = {
            markdown = true,                  -- enable Copilot in markdown
            gitcommit = true,
            ["*"] = true,
          },
        })
        -- Toggle Copilot mapping
        vim.keymap.set("n", "<leader>tc", function()
          local client = require("copilot.client")
          if client.is_disabled() then
            vim.cmd("Copilot enable")
          else
            vim.cmd("Copilot disable")
          end
        end, { desc = "Toggle Copilot" })
      end,
    },
    'rhysd/vim-grammarous',
    -- 'psf/black',  -- OBSOLETE: Replaced by Ruff (via conform.nvim)
    -- 'fisadev/vim-isort',  -- OBSOLETE: Replaced by Ruff (via conform.nvim)
    -------------------------------------------------------
    -- Conform: unified formatter (Ruff + Prettier)
    -------------------------------------------------------
    {
      "stevearc/conform.nvim",
      opts = {
        formatters_by_ft = {
          -- Python via Ruff (replaces black + isort)
          python = { "ruff_organize_imports", "ruff_format" },
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
        format_on_save = function(bufnr)
          if vim.bo[bufnr].filetype == "markdown" then
            return false
          end
          return {
            timeout_ms = 500,
            lsp_fallback = true,
          }
        end,
        -- Configure Ruff to use project's pyproject.toml if found
        formatters = {
          ruff_organize_imports = {
            command = "ruff",
            args = { "check", "--select", "I", "--fix", "--stdin-filename", "$FILENAME", "-"},
          },
          ruff_format = {
            -- Ruff will automatically find pyproject.toml in parent directories
            -- but we can explicitly set it if needed
            condition = function(ctx)
              -- Use system ruff if available, otherwise use mason-installed one
              return true
            end,
          },
        },
      },
    },
    -------------------------------------------------------
    -- nvim-lint: Linting (Ruff for Python)
    -------------------------------------------------------
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
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Find files' })
            vim.keymap.set('n', '<leader>fp', require('telescope.builtin').live_grep, { desc = 'Live grep' })
            vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, { desc = 'Git files' })
        end,
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
                default_mappings = false,  -- We'll set mappings manually
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
                stack_floating_preview_windows = true,
                same_file_float_preview = true,  -- Show preview even for same file
                preview_window_title = { enable = true, position = "left" },
                zindex = 1,
            })

            -- Set up keymappings explicitly with function wrappers
            vim.keymap.set('n', 'gpd', function()
                require('goto-preview').goto_preview_definition()
            end, { desc = "Preview definition" })
            vim.keymap.set('n', 'gpt', function() require('goto-preview').goto_preview_type_definition() end, { desc = "Preview type definition" })
            vim.keymap.set('n', 'gpi', function() require('goto-preview').goto_preview_implementation() end, { desc = "Preview implementation" })
            vim.keymap.set('n', 'gpD', function() require('goto-preview').goto_preview_declaration() end, { desc = "Preview declaration" })
            vim.keymap.set('n', 'gP', function() require('goto-preview').close_all_win() end, { desc = "Close all preview windows" })
            vim.keymap.set('n', 'gpr', function() require('goto-preview').goto_preview_references() end, { desc = "Preview references" })
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
    {
      "lewis6991/satellite.nvim",
      event = "VeryLazy",
      config = function()
        require('satellite').setup({
          current_only = false,
          winblend = 50,
          zindex = 40,
          excluded_filetypes = { "cmp_menu", "cmp_docs", "TelescopePrompt", "oil" },
          width = 2,
          handlers = {
            cursor = {
              symbols = { '⎺', '⎻', '⎼', '⎽' }
            },
            search = {
              enable = true,
            },
            diagnostic = {
              enable = true,
            },
            gitsigns = {
              enable = true,
            },
            marks = {
              enable = true,
              show_builtins = false,
            },
          },
        })
      end,
    },
    {
      "azorng/goose.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        {
          "MeanderingProgrammer/render-markdown.nvim",
          opts = { anti_conceal = { enabled = false } },
        },
      },
      config = function()
        -- Ensure goose CLI is in PATH
        local goose_path = "/Users/borisdev/.local/bin"
        if not string.match(vim.env.PATH, goose_path) then
          vim.env.PATH = goose_path .. ":" .. vim.env.PATH
        end
        
        require("goose").setup({ 
          default_global_keymaps = true,
          ui = {
            window_width = 0.8,
            window_height = 0.8,
            min_height = 10,
            min_width = 40
          },
          goose = {
            session_auto_create = true,
            session_name_prefix = "nvim-"
          }
        })
        
        -- Fix Goose.nvim floating window colors to remove purple
        local function fix_goose_colors()
          vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
          vim.api.nvim_set_hl(0, "FloatBorder", { link = "WinSeparator" })

          -- Goose-specific groups (override the purple theme)
          vim.api.nvim_set_hl(0, "GooseBackground", { bg = "NONE", fg = "NONE" })
          vim.api.nvim_set_hl(0, "GooseBorder", { link = "WinSeparator" })
          vim.api.nvim_set_hl(0, "GooseInput", { link = "Normal" })
          vim.api.nvim_set_hl(0, "GooseOutput", { link = "Normal" })

          -- Fix markdown rendering in goose windows (grey blocks with invisible text)
          vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#2d2d2d", fg = "#d4d4d4" })
          vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { bg = "#3a3a3a", fg = "#e6e6e6" })
          vim.api.nvim_set_hl(0, "RenderMarkdownTableHead", { bg = "#2d2d2d", fg = "#ffffff", bold = true })
          vim.api.nvim_set_hl(0, "RenderMarkdownTableRow", { bg = "#252526", fg = "#d4d4d4" })
          vim.api.nvim_set_hl(0, "RenderMarkdownTableFill", { bg = "#1e1e1e", fg = "#808080" })

          -- Additional markdown highlights for better visibility
          vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { bg = "#3a3a3a", fg = "#e6e6e6" })
          vim.api.nvim_set_hl(0, "@markup.raw.block.markdown", { bg = "#2d2d2d", fg = "#d4d4d4" })
        end
        
        vim.api.nvim_create_autocmd("ColorScheme", { callback = fix_goose_colors })
        fix_goose_colors()
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

require("mason-lspconfig").setup({
  ensure_installed = { "html" },
  handlers = {
    -- default handler for servers we don't customize:
    function(server)
      vim.lsp.config[server] = {}
    end,

    -- Disable pyright from Mason (we use basedpyright instead)
    pyright = function() end,

    -- your HTML setup:
    html = function()
      vim.lsp.config.html = {
        cmd = {"vscode-html-language-server", "--stdio"},
        filetypes = {"html"},
        init_options = {
          configurationSection = {"html", "css", "javascript"},
          embeddedLanguages = { css = true, javascript = true },
          provideFormatter = true,
        },
      }
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
    -- Format: use Conform (Ruff / Prettier) with LSP fallback
    vim.keymap.set('n', '<space>f', function()
      require("conform").format({ async = true, lsp_fallback = true })
    end, opts)
  end,
})


-----------------------------------------------------------
-- basedpyright (Python LSP)
-----------------------------------------------------------
-- Enable basedpyright for Python files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function(args)
    local root_dir = vim.fs.root(args.buf, {'.git', 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'pyrightconfig.json'})
    if not root_dir then
      root_dir = vim.fn.getcwd()
    end

    vim.lsp.start({
      name = 'basedpyright',
      cmd = { '/Users/borisdev/.local/bin/basedpyright-langserver', '--stdio' },
      root_dir = root_dir,
      settings = {
        basedpyright = {
          analysis = {
            typeCheckingMode = "standard",
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly",
            useLibraryCodeForTypes = true,
            venvPath = ".",
            venv = ".venv",
          },
        },
      },
    })
  end,
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
