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
-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

vim.g.python3_host_prog = '/opt/homebrew/bin/python3.10'

require("lazy").setup({
    'folke/which-key.nvim',
    'folke/neodev.nvim',
    'neomake/neomake',
    'ellisonleao/glow.nvim',
    'neovim/nvim-lspconfig',
    'glepnir/lspsaga.nvim',
    'vim-airline/vim-airline',
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'scrooloose/nerdtree',
    'nvie/vim-flake8',
    'github/copilot.vim',
    'nvim-tree/nvim-web-devicons',
    'nvim-tree/nvim-tree.lua',
    'rhysd/vim-grammarous',
    'psf/black',
    'fisadev/vim-isort',
    {
        "vhyrro/luarocks.nvim",
        priority = 1001, -- this plugin needs to run before anything else
        opts = {
            rocks = { "magick" },
        },
    },
    {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    init = function()
            -- this is an example, not a default. Please see the readme for more configuration options
            vim.g.molten_output_win_max_height = 12
        end,
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration

            -- Only one of these is needed, not both.
            "nvim-telescope/telescope.nvim", -- optional
            },
        config = true
    }
})
require('settings')
-- require('plugins')
require'lspconfig'.pyright.setup{}
require('glow').setup({
  style = "dark",
  width = 120,
})


-- https://github.com/nvim-tree/nvim-tree.lua
-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- setup nvim-tree with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
local opts = { noremap=true, silent=true }
-- ctrl + t to toggle nvim-tree
vim.keymap.set('n', '<C-t>', ':NvimTreeToggle<CR>', opts)




-- exit if NERDTree is the only window left
vim.cmd([[ 
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
]])


-- To map <Esc> to exit terminal-mode. Source neovim.io/doc/user/nvim_terminal_emulator.html
vim.cmd([[ 
:tnoremap <Esc> <C-\><C-n>
]])


-- jump to last position on reopening file
vim.cmd([[ 
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
]])

-- Auto install packer.nvim if not exists
-- https://alpha2phi.medium.com/neovim-init-lua-e80f4f136030#:~:text=Normally%20init.,to%20specify%20a%20different%20folder.
--



-- https://github.com/neovim/nvim-lspconfig#suggested-configuration
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end


local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- default laptop host's pyright
    cmd = { "pyright-langserver", "--stdio" },
}

 -- logs here --> vim ~/.cache/nvim/log
 -- WARN  2023-01-05T15:05:56.322 5393  deadly_signal:161: got signal 1 (SIGHUP)



-- after a search then clear highlights by hitting ESC 2x 
vim.cmd("nnoremap <esc><esc> :noh<return>")

-- Grammer Checker
-- gramerous depends on java languagetool below 6.0 because --api is deprecate in 6.0
-- Download https://www.languagetool.org/download/LanguageTool-5.9.zip'
-- cp -rf ~/Downloads/LanguageTool-5.9 .local/share/nvim/plugged/vim-grammarous/misc/
--

-- pre-view mypy errors after the write
-- vim.cmd([[ 
-- call neomake#configure#automake('w')
-- let g:neomake_open_list = 2
-- let g:neomake_python_mypy_maker = {
--     \ 'exe': 'mypy',
--     \ 'args': ['%'],
--     \ 'errorformat': '%f:%l:%c: %trror: %m,%f:%l:%c: %tarning: %m,%f:%l:%c: %tote: %m',
--     \ }
-- ]])
