vim.cmd([[ 
call plug#begin(stdpath('data') . '/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'vim-airline/vim-airline'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'scrooloose/nerdtree'
Plug 'nvie/vim-flake8'
Plug 'github/copilot.vim'
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'rhysd/vim-grammarous'
call plug#end()
]])

-- https://black.readthedocs.io/en/stable/integrations/editors.html#vim
