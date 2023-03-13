require('settings')
require('plugins')
require'lspconfig'.pyright.setup{}


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
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}


-- after a search then clear highlights by hitting ESC 2x 
vim.cmd("nnoremap <esc><esc> :noh<return>")



-- Only 1 in the 4 GRAMMER CHECKERS I got to work
-- all depend on the java language tool
-- test your java language tool is installed and working...
-- echo “This is is a test.” | java -jar  /opt/homebrew/Cellar/languagetool/6.0/libexec/languagetool-commandline.jar -c utf-8 -l en-US

-- 1. Supposedlky the best one
vim.cmd("let g:grammarous#languagetool_jar = '/Users/borisdev/workspace/languagetool/languagetool-standalone/target/LanguageTool-6.1-SNAPSHOT/LanguageTool-6.1-SNAPSHOT/languagetool-commandline.jar'")

-- 2. 
vim.cmd("let g:languagetool_jar = '/Users/borisdev/workspace/languagetool/languagetool-standalone/target/LanguageTool-6.1-SNAPSHOT/LanguageTool-6.1-SNAPSHOT/languagetool-commandline.jar'")
vim.cmd("let g:langtool_jar = '/Users/borisdev/workspace/languagetool/languagetool-standalone/target/LanguageTool-6.1-SNAPSHOT/LanguageTool-6.1-SNAPSHOT/languagetool-commandline.jar'")

-- 3. ALE does work with languagetool ??
vim.g.ale_linters = {
  markdown = {'languagetool'},
}

-- 4. LANGTOOL -- works!! BUT super slow sync grammer checker (the above ones did not
-- work...weird errors) 
-- https://github.com/Konfekt/vim-langtool
-- To automatically open the location-list window after LangTool
vim.cmd("autocmd QuickFixCmdPost lmake lwindow") 
-- To automatically run LangTool after saving the modifications to a text, mail or markdown file,
-- vim.cmd("autocmd FileType text,mail,markdown autocmd BufWrite <buffer=abuf> LangTool")

-- let s:enablecategories = 'CREATIVE_WRITING,WIKIPEDIA' .
-- let s:enable = 'PASSIVE_VOICE,TIRED_INTENSIFIERS'
vim.g.langtool_parameters = "--disable WHITESPACE_RULE"
